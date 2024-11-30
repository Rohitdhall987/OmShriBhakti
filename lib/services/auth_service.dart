import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CustomUser? _currentUser; // Store custom user model

// Silent Sign-In (check if the user is already signed in)
  Future<CustomUser?> signInSilently() async {
    try {
      // Use a Future to listen to the auth state changes
      await for (var event in _auth.authStateChanges()) {
        if (event != null) {
          print("event not empty");
          // Register the user or update your custom model
          await registerLogin(event.email.toString(), event.uid);
        } else {
          print("event empty");
          // Handle guest login
          await guestRegisterLogin();
        }
        print("reaching here");
        break;
      }

      print("returning");

      return _currentUser;
    } catch (e) {
      throw Exception("Silent Sign-In Failed: $e");
    }
  }

  // Sign in with Google using Firebase OAuth
  Future<CustomUser?> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =await _auth.signInWithProvider(googleAuthProvider);
      // final AuthCredential credential = await _getGoogleAuthCredential();
      // UserCredential userCredential =
      // await _auth.signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      print("here-----");

      if (firebaseUser != null ) {
        // Create CustomUser with Google and API data
        _currentUser = CustomUser(
          signInType: 'google',
          apiData: null, // Update this based on your API response
          googleData: {
            "uid": firebaseUser.uid,
            "email": firebaseUser.email,
            "displayName": firebaseUser.displayName,
            "photoURL": firebaseUser.photoURL,
          },
        );
        print("trying to register");
        // Call your API to register/login
        final success = await registerLogin(firebaseUser.email!, firebaseUser.uid);
        if (!success) throw Exception("Google API registration failed.");
      }else{
        print("firebaseuser null-----");
      }


      return _currentUser;
    } catch (e) {
      throw Exception("Google Sign-In Failed: $e");
    }
  }

  // Guest Registration
  Future<CustomUser?> guestRegisterLogin() async {

    print("guest login ------");
    try {
      String deviceIp = await getDeviceIP();

      Uri url = Uri.https(
        dotenv.get("DOMAIN", fallback: ""),
        "/api/v1/userRegisterLogin",
        {"type": "guest", "ip": deviceIp},
      );

      http.Response res = await http.post(
        url,
        headers: {"apiKey": dotenv.get("API_KEY", fallback: "")},
      );

      if (res.statusCode != 200) throw Exception("Guest login failed.");
      var data = jsonDecode(res.body);

      if (data["message"] != "success") throw Exception("API Error: ${data["message"]}");

      // Create CustomUser for guest
      _currentUser = CustomUser(
        signInType: 'guest',
        apiData: data,
        googleData: null,
      );
      return _currentUser;
    } catch (e) {
      throw Exception("Guest Register/Login Failed: $e");
    }
  }

  // Helper function to call the API for Google users
  Future<bool> registerLogin(String email, String fuid) async {
    print("google login----");
    try {
      Uri url = Uri.https(
        dotenv.get("DOMAIN", fallback: ""),
        "/api/v1/userRegisterLogin",
        {"type": "google", "email": email, "fuid": fuid},
      );

      http.Response res = await http.post(
        url,
        headers: {"apiKey": dotenv.get("API_KEY", fallback: "")},
      );
      print(res.statusCode);
      if (res.statusCode != 200) return false;
      var data = jsonDecode(res.body);
      print(data["message"]);
      if (data["message"] != "success") return false;

      // Update _currentUser with API data
      _currentUser = CustomUser(
        signInType: 'google',
        apiData: data,
        googleData: _currentUser?.googleData,
      );
      return true;
    } catch (e) {
      throw Exception("Register/Login API call failed: $e");
    }
  }

  // Get Device IP (or unique identifier)
  Future<String> getDeviceIP() async {
    try {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor!;
      }
      return "unknown";
    } catch (e) {
      throw Exception("Failed to get device identifier: $e");
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
  }

  // Get the current user (returns the custom user model)
  CustomUser? get currentUser => _currentUser;

  // Helper function to get Google AuthCredential
  // Future<AuthCredential> _getGoogleAuthCredential() async {
  //   final List<String> scopes = ['email', 'profile'];
  //   final OAuthCredential googleCredential = GoogleAuthProvider.credential();
  //   return googleCredential;
  // }
}