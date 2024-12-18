import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/Navigation_Provider.dart';
import 'package:omshribhakti/provider/music_player_provider.dart';
import 'package:omshribhakti/screens/Articles/Articles.dart';
import 'package:omshribhakti/screens/Home.dart';
import 'package:omshribhakti/screens/Players/MiniPlayer.dart';
import 'package:omshribhakti/screens/Video.dart';
import 'package:omshribhakti/screens/ecom/EcomHome.dart';
import 'package:omshribhakti/widgets/bottom_navigation_bar.dart';

class NavigationBarScreen extends ConsumerWidget {
  const NavigationBarScreen({super.key});


  void changeIndex(WidgetRef ref, int index) {
    ref.read(navigationIndexProvider.notifier).state=index;
  }


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final index = ref.watch(navigationIndexProvider);

    // navigationIndexProvider

    debugPrint("Tab index: $index");

    // Screens to show
    final tabScreens = [
      const Home(),
      const Videos(),
      const EcomHome(),
       Articles(),
      const Placeholder(),
    ];

    // Debugging: Print which tab is being built
    // debugPrint("Building screen for index $index");


    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height - 63,
                child: Column(
                  children: [
                    Expanded(child: tabScreens[index]),
                    Consumer(
                      builder: (context, ref, child) {
                        final player = ref.watch(playerProvider);
                        // print("building");
                        // print(player.isPlaying.toString() + " playing");
                          return player.isPlaying ? GestureDetector(
                            onTap: (){
                              GoRouter.of(context).pushNamed("MusicPlayerPage");
                            },
                              child: const MiniPlayer()) : const SizedBox.shrink();

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          myBottomNavigationBar(ref, context, index, changeIndex)
        ],
      ),
    );
  }
}
