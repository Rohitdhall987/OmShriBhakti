import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/MantraModel.dart';
import 'package:omshribhakti/services/mantra_services.dart';
// State class to hold the state of videos
class MantrasState {
  final List<Mantras> mantras;
  final bool isLoading;
  final bool hasMore;

  MantrasState({
    required this.mantras,
    required this.isLoading,
    required this.hasMore,
  });

  MantrasState copyWith({
    List<Mantras>? mantras,
    bool? isLoading,
    bool? hasMore,
  }) {
    return MantrasState(
      mantras: mantras ?? this.mantras,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// StateNotifier to manage video state
class MantrasNotifier extends StateNotifier<MantrasState> {
  final Ref _ref;

  MantrasNotifier(this._ref)
      : super(MantrasState(mantras: [], isLoading: false, hasMore: true));

  int? lastVideoId;
  Future<void> fetchMantras({bool isInitialLoad = false}) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final mantrasService = _ref.read(mantrasServiceProvider);
      final newMantras = await mantrasService.fetchMantras(lastVideoId);
      if (newMantras.isNotEmpty) {
        lastVideoId = newMantras.last.catId;
        state = state.copyWith(
          mantras: [...state.mantras, ...newMantras],
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
final mantrasProvider =
StateNotifierProvider<MantrasNotifier, MantrasState>((ref) => MantrasNotifier(ref));
