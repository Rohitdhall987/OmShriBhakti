import 'package:flutter/material.dart';
import 'dart:math';

class MusicPlayerUI extends StatefulWidget {
  const MusicPlayerUI({super.key});

  @override
  _MusicPlayerUIState createState() => _MusicPlayerUIState();
}

class _MusicPlayerUIState extends State<MusicPlayerUI> {
  double _progress = 0.6; // Initial progress (60%)

  void _updateProgress(Offset localPosition) {
    // Define the center of the widget (116,116 is half of 232 size of progress indicator)
    final center = Offset(116, 116);

    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Calculate the angle and convert it to progress (percentage of 2 * pi)
    double angle = atan2(dy, dx);
    if (angle < 0) angle += 2 * pi; // Ensure angle is positive

    setState(() {
      _progress = angle / (2 * pi); // Update progress based on angle
    });
  }

  @override
  Widget build(BuildContext context) {
    double handleAngle = 2 * pi * _progress; // Calculate handle position based on progress

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            // Convert global position to local position within the widget
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset localPosition = box.globalToLocal(details.globalPosition);
            _updateProgress(localPosition);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Padding around the Image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 10), // Oval shadow effect
                      ),
                    ],
                  ),
                ),
              ),
              // Circular Progress Indicator with padding
              SizedBox(
                width: 232, // Image size + padding
                height: 232,
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade800,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ),
              // Circular Handle
              Transform.translate(
                offset: Offset(
                  108 * cos(handleAngle), // Radius minus padding for the handle
                  108 * sin(handleAngle),
                ),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
