import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';

class ReadShloak extends StatelessWidget {
  const ReadShloak({super.key});

  final String adhyaya = 'Adhyaya 1';
  final String shlokaNumber = 'Shloka 1';

  // Dummy Shloka text in three languages
  final String shlokaEnglish = 'You have the right to work, but never to its fruits.';
  final String shlokaHindi = 'तुम्हें कर्म करने का अधिकार है, लेकिन उसके फलों पर नहीं।';
  final String shlokaSanskrit = 'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$adhyaya - $shlokaNumber'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.6,
            colors: [
              AppTheme.background,
              AppTheme.primary.shade200,
              AppTheme.background,
            ],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'English',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              shlokaEnglish,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: AppTheme.primary, thickness: 1),
            SizedBox(height: 20),
            Text(
              'Hindi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              shlokaHindi,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: AppTheme.primary, thickness: 1),
            SizedBox(height: 20),
            Text(
              'Sanskrit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              shlokaSanskrit,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}