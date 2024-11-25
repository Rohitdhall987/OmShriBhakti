import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/YogaByCategory.dart';
import 'package:omshribhakti/services/yoga_services.dart';

// State class to hold the state of videos
class YogaBYCategoryState {
  final List<AllYoga> allYoga;
  final bool isLoading;

  YogaBYCategoryState({
    required this.allYoga,
    required this.isLoading,
  });

  YogaBYCategoryState copyWith({
    List<AllYoga>? allYoga,
    bool? isLoading,
  }) {
    return YogaBYCategoryState(
      allYoga: allYoga ?? this.allYoga,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// StateNotifier to manage video state
class YogaByCategoryNotifier extends StateNotifier<YogaBYCategoryState> {
  final Ref _ref;

  YogaByCategoryNotifier(this._ref)
      : super(YogaBYCategoryState(allYoga: [], isLoading: false));

  Future<void> fetchYogaByCategory({bool isInitialLoad = false,required String token,required int id}) async {
    if (state.isLoading ) return;

    state = state.copyWith(isLoading: true);

    try {
      final yogaCategoryService = _ref.read(yogaCategoryServiceProvider);
      final newYogaCategory = await yogaCategoryService.fetchYogaByCategory(token,id);

        state = state.copyWith(
          allYoga: newYogaCategory,
          isLoading: false,
        );


    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}


final yogaByCategoryProvider =
StateNotifierProvider<YogaByCategoryNotifier, YogaBYCategoryState>((ref) => YogaByCategoryNotifier(ref));