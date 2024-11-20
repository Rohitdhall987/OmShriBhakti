import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/PodcastSeriesModel.dart';
import 'package:omshribhakti/services/podcast_service.dart';

class SingleSeriesState {
  final PodcastSeriesModel? podcast;
  final bool isLoading;

  SingleSeriesState({required this.podcast, required this.isLoading});

  SingleSeriesState copyWith({
    PodcastSeriesModel? podcast,
    bool? isLoading,
  }) {
    return SingleSeriesState(
      podcast: podcast ?? this.podcast,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SingleSeriesNotifier extends StateNotifier<SingleSeriesState> {
  final Ref _ref;

  SingleSeriesNotifier(this._ref)
      : super(SingleSeriesState(podcast: PodcastSeriesModel(audio: Audio(title: "", image: ""), audioSeason: []), isLoading: false));

  Future<void> fetchSingleSeries(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      final podcastService = _ref.read(podcastServiceProvider);
      final series = await podcastService.fetchSingleSeries(id);
      state = state.copyWith(podcast: series, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

final singleSeriesProvider =
StateNotifierProvider<SingleSeriesNotifier, SingleSeriesState>(
        (ref) => SingleSeriesNotifier(ref));
