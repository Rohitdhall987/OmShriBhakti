import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/video_provider.dart';
import 'package:omshribhakti/utils/ImageCacheManger.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class Videos extends ConsumerStatefulWidget {
  const Videos({super.key});

  @override
  ConsumerState<Videos> createState() => _VideosState();
}

class _VideosState extends ConsumerState<Videos> {
  final ScrollController _scrollController = ScrollController();
  // final ImageCacheManager _cacheManager =ImageCacheManager();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(videoProvider.notifier).reset();
      ref.read(videoProvider.notifier).fetchVideos(isInitialLoad: true);
      // _preloadImages();
    });
    // ref.read(videoProvider.notifier).fetchVideos(isInitialLoad: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(videoProvider.notifier).fetchVideos();
        // _preloadImages();
      }
    });
  }



  // void _preloadImages() {
  //
  //   final videoState = ref.read(videoProvider);
  //
  //   // Preload images using custom ImageCacheManager
  //   for (final video in videoState.videos) {
  //     final imageUrl = video.image;
  //     _cacheManager.getImage(imageUrl).then((file) {
  //       if (file != null && _cacheManager.isValidImage(file)) {
  //         // Successfully cached the image
  //         print("Preloaded image for URL: $imageUrl");
  //       } else {
  //         // Fallback if image could not be preloaded
  //         print("Failed to preload image for URL: $imageUrl");
  //       }
  //     });
  //   }
  // }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoProvider);

    return Scaffold(
      body: SafeArea(
        child: videoState.isLoading && videoState.videos.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          controller: _scrollController,
          itemCount: videoState.videos.length +
              (videoState.hasMore ? 1 : 0), // Add 1 for the loader
          itemBuilder: (context, index) {
            if (index == videoState.videos.length) {
              // Loader at the bottom
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final video = videoState.videos[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () =>
                    GoRouter.of(context).pushNamed("VideoPlayer"),
                child: thumbnailCard(
                  MediaQuery.sizeOf(context).height * 0.3,
                  MediaQuery.sizeOf(context).width,
                  video.title,
                  video.image,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}