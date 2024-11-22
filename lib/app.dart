import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omshribhakti/provider/music_player_provider.dart';
import 'package:omshribhakti/screens/AllLiveDarshans.dart';
import 'package:omshribhakti/screens/Players/MiniPlayer.dart';
import 'package:omshribhakti/utils/colors.dart';
import 'package:omshribhakti/utils/routers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.background,
        primarySwatch: AppTheme.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: AppTheme.background,
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: AppTheme.background,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary,
        ),
      ),
      routerConfig: route(),
      builder: (context, child) {
          return AppWithMiniPlayer(child: child!);
      },
    );
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppWithMiniPlayer extends StatelessWidget {
  final Widget child;

  const AppWithMiniPlayer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: child, // This takes up all available space
          ),
          Consumer(
            builder: (context, ref, child) {
              final player = ref.watch(playerProvider);
              // print("building again");
              // print((!player.isHidden).toString() + " s d s hidden");
              // print(player.isPlaying.toString() + " s ds playing");
              if (!player.isHidden) {
                return player.isPlaying ? GestureDetector(
                    onTap: (){
                      GoRouter.of(rootNavigatorKey.currentContext!).pushNamed("MusicPlayerPage");
                      //navigate to  page
                    },
                    child: const MiniPlayer()) : const SizedBox.shrink();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

