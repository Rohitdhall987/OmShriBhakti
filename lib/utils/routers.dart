

import 'package:go_router/go_router.dart';
import 'package:omshribhakti/screens/NavigationBar.dart';
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
      GoRoute(path: "/NavigationBar",
        name: "NavigationBar",
        builder: (context,state)=> const NavigationBar()
      ),
    ]
);