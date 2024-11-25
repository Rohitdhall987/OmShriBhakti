import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/PodcastModel.dart';
import 'package:omshribhakti/services/podcast_service.dart';

// State class to hold the state of videos
class podcastState {
  final List<Sanatanpodcat> sanatanPodcat;
  final bool isLoading;
  final bool hasMore;

  podcastState({
    required this.sanatanPodcat,
    required this.isLoading,
    required this.hasMore,
  });

  podcastState copyWith({
    List<Sanatanpodcat>? sanatanPodcat,
    bool? isLoading,
    bool? hasMore,
  }) {
    return podcastState(
      sanatanPodcat: sanatanPodcat ?? this.sanatanPodcat,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// StateNotifier to manage video state
class PodcastNotifier extends StateNotifier<podcastState> {
  final Ref _ref;

  PodcastNotifier(this._ref)
      : super(podcastState(sanatanPodcat: [], isLoading: false, hasMore: true));

  int? lastPodcastId;
  Future<void> fetchPodcast({bool isInitialLoad = false}) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final podcastService = _ref.read(podcastServiceProvider);
      final newPodcasts = await podcastService.fetchPodcast(lastPodcastId);
      if (newPodcasts.isNotEmpty) {
        lastPodcastId = newPodcasts.last.id;
        state = state.copyWith(
          sanatanPodcat: [...state.sanatanPodcat, ...newPodcasts],
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
}

// Riverpod provider for the VideoNotifier
final podcastProvider =
StateNotifierProvider<PodcastNotifier, podcastState>((ref) => PodcastNotifier(ref));
