import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/yoga_category_model.dart';
import 'package:omshribhakti/services/yoga_services.dart';

// State class to hold the state of videos
class YogaCategoryState {
  final List<AllYogaCategories> allCategory;
  final bool isLoading;

  YogaCategoryState({
    required this.allCategory,
    required this.isLoading,
  });

  YogaCategoryState copyWith({
    List<AllYogaCategories>? allCategory,
    bool? isLoading,
  }) {
    return YogaCategoryState(
      allCategory: allCategory ?? this.allCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// StateNotifier to manage video state
class YogaCategoryNotifier extends StateNotifier<YogaCategoryState> {
  final Ref _ref;

  YogaCategoryNotifier(this._ref)
      : super(YogaCategoryState(allCategory: [], isLoading: false));

  int? lastGodId;
  Future<void> fetchYogaCategory({bool isInitialLoad = false,required String token}) async {
    if (state.isLoading ) return;

    state = state.copyWith(isLoading: true);

    try {
      final yogaCategoryService = _ref.read(yogaCategoryServiceProvider);
      final newYogaCategory = await yogaCategoryService.fetchAllYogaCategory(token);
      if (newYogaCategory.isNotEmpty) {
        state = state.copyWith(
          allCategory: newYogaCategory,
          isLoading: false,
        );

      } else {
        state = state.copyWith(isLoading: false,);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}


final yogaAllCategoryProvider =
StateNotifierProvider<YogaCategoryNotifier, YogaCategoryState>((ref) => YogaCategoryNotifier(ref));