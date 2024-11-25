import 'package:omshribhakti/model/QuatesCategoryModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/services/quotes_services.dart';

// State class to hold the state of videos
class QuotesCategoryState {
  final List<Category> allCategory;
  final bool isLoading;

  QuotesCategoryState({
    required this.allCategory,
    required this.isLoading,
  });

  QuotesCategoryState copyWith({
    List<Category>? allCategory,
    bool? isLoading,
  }) {
    return QuotesCategoryState(
      allCategory: allCategory ?? this.allCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// StateNotifier to manage video state
class QuotesCategoryNotifier extends StateNotifier<QuotesCategoryState> {
  final Ref _ref;

  QuotesCategoryNotifier(this._ref)
      : super(QuotesCategoryState(allCategory: [], isLoading: false));

  int? lastGodId;
  Future<void> fetchQuotesCategory({bool isInitialLoad = false}) async {
    if (state.isLoading ) return;

    state = state.copyWith(isLoading: true);

    try {
      final quotesCategoryService = _ref.read(quotesCategoryServiceProvider);
      final newQuotesCategory = await quotesCategoryService.fetchAllQuotesCategory();
      if (newQuotesCategory.isNotEmpty) {
        state = state.copyWith(
          allCategory: newQuotesCategory,
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

// Riverpod provider for the VideoNotifier
final quotesAllCategoryProvider =
StateNotifierProvider<QuotesCategoryNotifier, QuotesCategoryState>((ref) => QuotesCategoryNotifier(ref));