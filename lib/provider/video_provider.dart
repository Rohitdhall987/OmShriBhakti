import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/Video.dart';
import 'package:omshribhakti/services/VideoServices.dart';
import 'package:omshribhakti/utils/ImageCacheManger.dart';

// State class to hold the state of videos
class VideoState {
  final List<Video> videos;
  final bool isLoading;
  final bool hasMore;

  VideoState({
    required this.videos,
    required this.isLoading,
    required this.hasMore,
  });

  VideoState copyWith({
    List<Video>? videos,
    bool? isLoading,
    bool? hasMore,
  }) {
    return VideoState(
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// StateNotifier to manage video state
class VideoNotifier extends StateNotifier<VideoState> {
  final Ref _ref;

  VideoNotifier(this._ref)
      : super(VideoState(videos: [], isLoading: false, hasMore: true));

  int? lastVideoId;
  Future<void> fetchVideos({bool isInitialLoad = false}) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final videoService = _ref.read(videoServiceProvider);
      final newVideos = await videoService.fetchVideos(lastVideoId);
      if (newVideos.isNotEmpty) {
        lastVideoId = newVideos.last.id;
        state = state.copyWith(
          videos: [...state.videos, ...newVideos],
          isLoading: false,
        );

      } else {
        state = state.copyWith(isLoading: false, hasMore: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

// // Method to reset the state of the provider
//   void reset() {
//     print("callingggg");
//     state = VideoState(videos: [], isLoading: false, hasMore: true); // Reset the state to its initial state
//   }



}

// Riverpod provider for the VideoNotifier
final videoProvider =
StateNotifierProvider<VideoNotifier, VideoState>((ref) => VideoNotifier(ref));
