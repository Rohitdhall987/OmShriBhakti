import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/colors.dart';
import 'package:omshribhakti/widgets/nav_item.dart';

Widget myBottomNavigationBar(ref, context, index, changeIndex) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        padding: const EdgeInsets.only(top: 8),
        color: AppTheme.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => changeIndex(ref, 0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: buildNavItem(
                  icon: Icons.home,
                  index: 0,
                  selectedIndex: index,
                  label: "Home",
                ),
              ),
            ),
            GestureDetector(
              onTap: () => changeIndex(ref, 1),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: buildNavItem(
                  icon: Icons.play_circle,
                  index: 1,
                  selectedIndex: index,
                  label: "Video",
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 5,
            ),
            GestureDetector(
              onTap: () => changeIndex(ref, 3),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: buildNavItem(
                  icon: Icons.music_note,
                  index: 3,
                  selectedIndex: index,
                  label: "Music",
                ),
              ),
            ),
            GestureDetector(
              onTap: () => changeIndex(ref, 4),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: buildNavItem(
                  icon: Icons.grid_view_rounded,
                  index: 4,
                  selectedIndex: index,
                  label: "More",
                ),
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => changeIndex(ref, 2),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  border: Border.all(
                    width: 2,
                    color: AppTheme.background,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Shop",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
