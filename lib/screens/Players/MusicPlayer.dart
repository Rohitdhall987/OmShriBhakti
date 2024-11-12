import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class MusicPlayerPage extends ConsumerWidget {
  const MusicPlayerPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",BoxFit.fitHeight),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(child: Text("musicPlayer.songName",
                    style: TextStyle(
                      color: Colors.white54
                    ),
                  )),
                ],
              ),
            ),
            Slider.adaptive(
              thumbColor: AppTheme.primary,
              activeColor: AppTheme.primary,
              value: 50.0,
              max: 100.0,
              onChanged: (value) {
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(Duration(minutes: 3)),
                    style: TextStyle(
                        color: Colors.white54
                    ),),
                  Text(_formatDuration(Duration(minutes: 6)),
                    style: TextStyle(
                        color: Colors.white54
                    ),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.shuffle,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.fast_rewind, color: Colors.white),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: GestureDetector(
                      child: Icon(
                        Icons.play_arrow ,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.fast_forward, color: Colors.white),
                ),
                IconButton(
                  onPressed:(){},
                  icon: Icon(
                    Icons.repeat,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
