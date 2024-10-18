import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/colors.dart';
import 'package:omshribhakti/utils/routers.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
       MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.background,
          primarySwatch:  AppTheme.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.primary,
          ),
        ),
        routerConfig: routes,

    );
  }
}
