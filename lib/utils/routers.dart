

import 'package:go_router/go_router.dart';
import 'package:omshribhakti/screens/NavigationBarScreen.dart';
import 'package:omshribhakti/screens/SongsByMonth.dart';
import 'package:omshribhakti/screens/SplashScreen.dart';
import 'package:omshribhakti/screens/UpdateAppPage.dart';

final GoRouter routes=GoRouter(
    routes: [
      GoRoute(path: "/",
        name: "Splash",
        builder: (context,state)=>const SplashScreen()
      ),
      GoRoute(path: "/Update",
        name: "Update",
        builder: (context,state)=>const UpdateApp()
      ),
      GoRoute(path: "/NavigationBarScreen",
        name: "NavigationBarScreen",
        builder: (context,state)=> const NavigationBarScreen()
      ),
      GoRoute(path: "/SongsByMonth",
        name: "SongsByMonth",
        builder: (context,state)=> const SongsByMonth()
      ),
    ]
);