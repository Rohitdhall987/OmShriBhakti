import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key,});


  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;


  void changeOrientation(DeviceOrientation newOrientation) {
    SystemChrome.setPreferredOrientations([newOrientation]);
  }

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=t4qPBsXjCZk");

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    _controller.addListener(_youtubePlayerListener);
  }



  @override
  void dispose() {
    changeOrientation(DeviceOrientation.portraitUp);
    _controller.removeListener(_youtubePlayerListener);
    _controller.dispose();

    super.dispose();
  }

  void _youtubePlayerListener() {
    if (_controller.value.isFullScreen != _isFullScreen) {
      setState(() {
        _isFullScreen = _controller.value.isFullScreen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                _controller.addListener(_youtubePlayerListener);
              },
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                ),
                PlaybackSpeedButton(),
                FullScreenButton(),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
