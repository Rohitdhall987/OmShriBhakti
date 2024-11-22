import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/provider/music_player_provider.dart'; // Import the provider

class MusicPlayerPage extends ConsumerWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the player state from the provider
    final playerState = ref.watch(playerProvider);

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
                child: cachedNetworkImage(
                  playerState.image, // Use the player's image
                  BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      playerState.songName, // Use the song name from the player state
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
            Slider.adaptive(
              thumbColor: AppTheme.primary,
              activeColor: AppTheme.primary,
              value: playerState.currentPosition.inSeconds.toDouble(), // Current position
              max: playerState.totalDuration.inSeconds.toDouble(), // Total duration
              onChanged: (value) {
                // Optionally update UI while dragging
                ref.read(playerProvider.notifier).updateCurrentPosition(Duration(seconds: value.toInt()));
              },
              onChangeEnd: (value) {
                // Seek to the new position when dragging ends
                ref.read(playerProvider.notifier).seek(Duration(seconds: value.toInt()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(playerState.currentPosition),
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    _formatDuration(playerState.totalDuration),
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    // Shuffle action (toggle shuffle state)
                    ref.read(playerProvider.notifier).toggleShuffle();
                  },
                  icon: Icon(
                    Icons.shuffle,
                    color:playerState.shuffle?AppTheme.primary: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Previous track action
                    ref.read(playerProvider.notifier).playPrevious();
                  },
                  icon:  Icon(Icons.fast_rewind, color:ref.read(playerProvider.notifier).hasPrevious? Colors.white:Colors.grey),
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
                      onTap: () {
                        // Toggle play/pause based on current state
                        if (!playerState.isPaused) {
                          ref.read(playerProvider.notifier).pause();
                        } else {
                          ref.read(playerProvider.notifier).resume();
                        }
                      },
                      child: Icon(
                        !playerState.isPaused ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Next track action
                    ref.read(playerProvider.notifier).playNext();
                  },
                  icon: Icon(Icons.fast_forward, color:ref.read(playerProvider.notifier).hasNext? Colors.white:Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                    // Repeat action (toggle repeat state)
                    ref.read(playerProvider.notifier).toggleRepeat();
                  },
                  icon: Icon(
                    Icons.repeat,
                    color:playerState.shouldRepeat?AppTheme.primary: Colors.white,
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
