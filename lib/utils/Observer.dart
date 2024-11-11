import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/music_player_provider.dart';

class GoRouterObserver extends NavigatorObserver {





  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final player = ProviderScope.containerOf(route.navigator!.context).read(playerProvider);

      if(player.isPlaying){
        print("here");
        if(route.settings.name=="NavigationBarScreen"  ){
          player.hide();
        }else{
          player.display();
        }
      }
    });


  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final player = ProviderScope.containerOf(route.navigator!.context).read(playerProvider);
      if(player.isPlaying){
        print("here");
        if(previousRoute!.settings.name=="NavigationBarScreen"){
          player.hide();
        }else{
          player.display();
        }
      }
    });


  }

}

