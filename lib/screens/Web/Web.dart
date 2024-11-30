import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:omshribhakti/app.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/google_ads_service.dart';
import 'package:omshribhakti/services/wallet_service.dart';

class Web extends ConsumerStatefulWidget {
  const Web({super.key});

  @override
  ConsumerState<Web> createState() => _WebState();
}

class _WebState extends ConsumerState<Web> {
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  NativeAd? _nativeAdTop;
  bool isBannerAdLoaded = false;
  bool isRewardedAdLoaded = false;
  bool isNativeAdTopLoaded = false;
  bool noAd=false;
  bool comeAgain=false;

  final AdsService _adsService=AdsService();

  @override
  void initState() {
    super.initState();
    loadPage();
    _bannerAd = _adsService.loadBannerAd(callback:(Ad ad) {
      setState(() {
        isBannerAdLoaded = true;
      });
    }, );
    _nativeAdTop=_adsService.loadNativeAds(callback: (Ad ad) {
      setState(() {
        isNativeAdTopLoaded = true;
      });
    },);
  }

  void loadPage()async{
    // print("status loading");
    final user=ref.read(customUserProvider);
    int canGetAdd=await _adsService.checkForLastAdd(user!.apiData!['token'], user.apiData!['userId']);
    if(canGetAdd==1){
      // print("loading add");
      _adsService.loadRewardedAd(callback: (RewardedAd ad) {
        setState(() {
          // print("add loaded");
          _rewardedAd = ad;
          isRewardedAdLoaded = true;
        });
      }, failedCallback: (LoadAdError error) {
        setState(() {
          noAd=true;
        });
        // print('Rewarded ad failed to load: $error');
      },);

    }else{
      // print("status 0 check ::$canGetAdd");
      setState(() {
        comeAgain=true;
      });
    }
  }





  void _showRewardedAd() {
    if (isRewardedAdLoaded) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          WalletService wallet=WalletService();
          final user=ref.read(customUserProvider);
          wallet.addFreeCoin(user!.apiData!["userName"], user.apiData!["token"]).then((_)=>mounted?context.pop():null);
        },
      );
      _rewardedAd = null;
      isRewardedAdLoaded = false;
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _rewardedAd?.dispose();
    _nativeAdTop?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Free Coins',
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isNativeAdTopLoaded)
                  AspectRatio(
                      aspectRatio: 1,
                      child: AdWidget(ad: _nativeAdTop!)
                  ),
                SizedBox(height: 20),
                isRewardedAdLoaded?
                ElevatedButton(
                  onPressed: _showRewardedAd,
                  child: Text('1 Free Coin \n 1 मुफ़्त सिक्का'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                ):
                noAd?
                const Text("No ad available.",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
                    :
                comeAgain?const Text("come again after 5 mins.",
                  style: TextStyle(color: Colors.white),
                ):const CircularProgressIndicator()
                ,

              ],
            ),
          ),
          if (isBannerAdLoaded)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
      ),
    );
  }
}
