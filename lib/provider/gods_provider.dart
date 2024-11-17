import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/GodsModel.dart';
import 'package:omshribhakti/model/Video.dart';
import 'package:omshribhakti/services/VideoServices.dart';
import 'package:omshribhakti/services/gods_services.dart';
import 'package:omshribhakti/utils/ImageCacheManger.dart';

// State class to hold the state of videos
class GodsState {
  final List<AllGod> allGod;
  final bool isLoading;
  final bool hasMore;

  GodsState({
    required this.allGod,
    required this.isLoading,
    required this.hasMore,
  });

  GodsState copyWith({
    List<AllGod>? allGod,
    bool? isLoading,
    bool? hasMore,
  }) {
    return GodsState(
      allGod: allGod ?? this.allGod,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// StateNotifier to manage video state
class GodsNotifier extends StateNotifier<GodsState> {
  final Ref _ref;

  GodsNotifier(this._ref)
      : super(GodsState(allGod: [], isLoading: false, hasMore: true));

  int? lastGodId;
  Future<void> fetchGods({bool isInitialLoad = false}) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final godsService = _ref.read(godsServiceProvider);
      final newGogs = await godsService.fetchGods(lastGodId);
      if (newGogs.isNotEmpty) {
        lastGodId = newGogs.last.id;
        state = state.copyWith(
          allGod: [...state.allGod, ...newGogs],
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
final godsProvider =
StateNotifierProvider<GodsNotifier, GodsState>((ref) => GodsNotifier(ref));
