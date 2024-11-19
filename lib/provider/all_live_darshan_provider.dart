import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/LiveDarshanModel.dart';
import 'package:omshribhakti/services/live_darshan_service.dart';

// State class to hold the state of videos
class AllLiveDarshanState {
  final List<LiveDarshan> liveDarshans;
  final bool isLoading;
  final bool hasMore;

  AllLiveDarshanState({
    required this.liveDarshans,
    required this.isLoading,
    required this.hasMore,
  });

  AllLiveDarshanState copyWith({
    List<LiveDarshan>? liveDarshans,
    bool? isLoading,
    bool? hasMore,
  }) {
    return AllLiveDarshanState(
      liveDarshans: liveDarshans ?? this.liveDarshans,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// StateNotifier to manage video state
class AllLiveDarshanNotifier extends StateNotifier<AllLiveDarshanState> {
  final Ref _ref;

  AllLiveDarshanNotifier(this._ref)
      : super(AllLiveDarshanState(liveDarshans: [], isLoading: false, hasMore: true));

  int? lastGodId;
  Future<void> fetchAllLiveDarshan({bool isInitialLoad = false}) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final allLiveDarshanService = _ref.read(liveDarshanServiceProvider);
      final newAllLiveDarshans = await allLiveDarshanService.fetchAllLiveDarshans(lastGodId);
      if (newAllLiveDarshans.isNotEmpty) {
        lastGodId = newAllLiveDarshans.last.id;
        state = state.copyWith(
          liveDarshans: [...state.liveDarshans, ...newAllLiveDarshans],
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
final allLiveDarshanProvider =
StateNotifierProvider<AllLiveDarshanNotifier, AllLiveDarshanState>((ref) => AllLiveDarshanNotifier(ref));
