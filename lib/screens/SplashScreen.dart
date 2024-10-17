import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/services/VersionServices.dart';
import 'package:omshribhakti/utils/Colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  // Function to check and update version
  void checkVersion() async {
    await VersionService.getLatestVersion(ref);
    if ( await VersionService.isUpdated(ref)) {

    } else {
      GoRouter.of(context).goNamed("Update");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: Image.asset("images/app_icon.png"),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: Image.asset("images/logo_text.png"),
            ),
          ],
        ),
      ),
    );
  }
}
