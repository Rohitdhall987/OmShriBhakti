import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;


class AdsService{
  final String _url = dotenv.get('BASE_URl', fallback: "");
  Future<int> checkForLastAdd(token, userId)async{

     http.Response res= await http.post(Uri.parse("${_url}user/CheckFreeCoinTransaction?user_id=$userId&apiKey=${dotenv.get("API_KEY", fallback: "")}"),

        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token"
        }
    );
    // print("api data: ${res.body}");
    if(res.statusCode==200){
      var data=jsonDecode(res.body);
      if(data["message"]=="success"){
        return data["status"];
      }
    }
    return 0;
  }


  BannerAd loadBannerAd({required Function(Ad ad) callback}) {

    String bannerId = dotenv.get('BANNER', fallback: "");
    final bannerAd = BannerAd(
      adUnitId: bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: callback,
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          // print('Banner ad failed to load: $error');
        },
      ),
    )..load();
    return bannerAd;
  }

  void loadRewardedAd({required Function(RewardedAd ad) callback,required Function(LoadAdError error) failedCallback}) {
    String id = dotenv.get('REWORDED', fallback: "");
      RewardedAd.load(
      adUnitId: id,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: callback,

        onAdFailedToLoad:failedCallback
      ),
    );
  }

  NativeAd loadNativeAds({required Function(Ad ad) callback,}) {
    String nativeId = dotenv.get('NATIVEAD', fallback: "");

    final nativeAdTop = NativeAd(
        adUnitId: nativeId,
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: callback,
          onAdFailedToLoad:  (Ad ad, LoadAdError error) {
            ad.dispose();
            // print('Native ad (top) failed to load: $error');
          },
        ),

        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(

              backgroundColor: Colors.orangeAccent,
              style: NativeTemplateFontStyle.normal,

            ),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.blue,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)
        )
    )..load();
    return nativeAdTop;
  }
}