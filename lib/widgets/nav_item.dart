// Function to build each navigation item
import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/colors.dart';

Widget buildNavItem({required IconData icon, required int index, required int selectedIndex ,required String label}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        color: selectedIndex == index ? AppTheme.primary : Colors.white,
        size: 30,
      ),
      const SizedBox(height: 5),
      Text(label,
        style: const TextStyle(
          color: Colors.white
        ),
      )
    ],
  );
}