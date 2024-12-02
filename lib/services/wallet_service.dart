import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:omshribhakti/model/free_wallet.dart';
import 'package:omshribhakti/model/main_wallet.dart';

class WalletService {
  final baseUrl=dotenv.get("BASE_URl",fallback: "");
   Future<MainWallet> getMainWalletAmount({required int id,required String token}) async {
    try {
      String url = "${baseUrl}v1/user/home/MainWallet?user_id=$id&apiKey=${dotenv.get("API_KEY", fallback: "")}";

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );


      if (response.statusCode == 200) {
        return MainWallet.fromJson(jsonDecode(response.body));
      } else {
        // print(response.body );
        throw "Unable to load main wallet from API";
      }
    } catch (e) {
      // print("Error: $e");
      throw "unable to fetch main wallet $e";
    }
  }
   Future<FreeWallet> getFreeWalletAmount({required int id,required String token}) async {


     try {
       String url = "${baseUrl}v1/user/home/FreeWallet?user_id=$id&apiKey=${dotenv.get("API_KEY", fallback: "")}";

       http.Response response = await http.post(
         Uri.parse(url),
         headers: {
           HttpHeaders.authorizationHeader:"Bearer $token"
         },
       );


       if (response.statusCode == 200) {
         return FreeWallet.fromJson(jsonDecode(response.body));
       }
       else {
         throw "Unable to load free wallet from API";
       }
     } catch (e) {
       // print("Error: $e");
       throw "unable to fetch free wallet $e";
     }
   }


Future<void> addFreeCoin(username,token) async {


  print("getting data");
  String baseUrl = dotenv.get("BASE_URl", fallback: "");
  String apiKey = dotenv.get("API_KEY", fallback: "");
  // String? userId = _userData.getname();
  // String? token = _userData.getToken();

  if (baseUrl.isEmpty || apiKey.isEmpty ) {
    return;
  }

  Uri url = Uri.parse("${baseUrl}user/GetCoinByAds?user_id=$username&apiKey=$apiKey");

  print(url);

  try {
    http.Response response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Failed to get coins: ${response.statusCode} ${response.body}");
    }
  } catch (e) {
    print("Error occurred while making the request: $e");
  }

}
}
