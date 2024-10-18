import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/version.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/provider/VersionProvider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  static Future<Version> getLatestVersion(WidgetRef ref) async {
    String url = dotenv.get('BASE_URl', fallback: "");

    bool success = false;
    http.Response? response;

    do {
      // try {
        response = await http.get(Uri.parse('${url}versionCheck'));

        if ( response.statusCode == 200) {
          success = true;
        } else {
          // print(response.body );
          throw "Unable to load version from API";
        }
      // } catch (e) {
      //   // print("Error: $e");
      //
      // }
    } while (!success);

    final latestVersion = Version.fromJson(jsonDecode(response.body));
    ref.read(versionProvider.notifier).state = latestVersion;

    return latestVersion;
  }

  static Future<bool> isUpdated(WidgetRef ref) async {
    // Get app version from device
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionInApp = packageInfo.version;

    // Fetch the latest version from the server
    Version latestVersion = await getLatestVersion(ref);
    if(latestVersion.status==0){
      return true;
    }

    String versionFromServer = latestVersion.version; // Assuming the `Version` model has a `version` field

    // Split versions into parts
    List<int> appVersionParts = versionInApp.split('.').map(int.parse).toList();
    List<int> serverVersionParts = versionFromServer.split('.').map(int.parse).toList();

    // Compare each part of the version
    for (int i = 0; i < serverVersionParts.length; i++) {
      if (i >= appVersionParts.length || appVersionParts[i] < serverVersionParts[i]) {
        return false; // Needs update
      } else if (appVersionParts[i] > serverVersionParts[i]) {
        return true; // Up-to-date
      }
    }

    return true; // App is up-to-date
  }
}
