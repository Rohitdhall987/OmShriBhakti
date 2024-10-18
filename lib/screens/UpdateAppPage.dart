import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/VersionProvider.dart';
import 'package:omshribhakti/utils/colors.dart';

class UpdateApp extends ConsumerWidget {
  const UpdateApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncVersion=ref.watch(currentVersionProvider);
    final latestVersion=ref.watch(versionProvider);

    return Scaffold(
      body: asyncVersion.when(
        data: (packageInfo) {
          String currentVersion = packageInfo.version;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height*0.15,
                    width: MediaQuery.sizeOf(context).height*0.15,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(child: Icon(Icons.warning_rounded,color: Colors.white,size: MediaQuery.sizeOf(context).height*0.08,)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: AppTheme.backgroundLight.shade900,
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                          children: [
                            const TextSpan(text: "App is not Updated "),
                            const TextSpan(
                              text: "current app version is ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: currentVersion),
                            const TextSpan(text: " and "),
                            const TextSpan(
                              text: "latest version is ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: latestVersion!.version),
                            const TextSpan(text: " tap the \"Update App\" button to update the app. or you can directly go to  Google PlayStore to Update the app."),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text("Update App"),
                    )
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
