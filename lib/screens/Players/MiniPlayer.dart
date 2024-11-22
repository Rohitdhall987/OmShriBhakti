import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/screens/Players/MusicPlayer.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/provider/music_player_provider.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listening to the player state
    final playerState = ref.watch(playerProvider);

    return Container(
      padding: EdgeInsets.all(8),
      color: AppTheme.background,
      width: double.maxFinite,
      height: 60,
      child: Row(
        children: [
          // Displaying the song image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 40,
              width: 40,
              child: cachedNetworkImage(playerState.image, BoxFit.fitHeight),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          // Displaying the song name
          Expanded(
            child: Text(
              playerState.songName.isEmpty ? 'No Song Playing' : playerState.songName,
              style: TextStyle(color: Colors.white,
                overflow: TextOverflow.ellipsis
              ),
            ),
          ),
          // Play/Pause Button
          IconButton(
            icon: Icon(
              !playerState.isPaused ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              // Play or Pause the song based on current state
              if (!playerState.isPaused) {
                ref.read(playerProvider.notifier).pause();
              } else {
                // You may want to specify the song to play when it's not playing
                ref.read(playerProvider.notifier).resume();
              }
            },
          ),
          SizedBox(
            width: 8,
          ),
          // Close Button
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              // Stop the player and hide the mini player
              ref.read(playerProvider.notifier).stop();
              
            },
          ),
        ],
      ),
    );
  }
}
