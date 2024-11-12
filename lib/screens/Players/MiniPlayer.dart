import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(8),
      color: AppTheme.background,
      width: double.maxFinite,
      height: 60,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 40,
                width: 40,
                child: cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",BoxFit.fitHeight)
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(child: Text("name  sgf dsfdsf f",
            style: TextStyle(color: Colors.white),
          )),
          Icon(Icons.play_arrow_rounded,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Icon(Icons.close,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
