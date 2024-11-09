import 'package:flutter/material.dart';

class Web extends StatelessWidget {
  const Web({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Web Page here.",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
