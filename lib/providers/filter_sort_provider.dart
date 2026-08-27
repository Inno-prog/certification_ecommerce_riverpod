import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';

class FilterSortNotifier extends StateNotifier<FilterSortState> {
  FilterSortNotifier() : super(const FilterSortState());

  void setCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSortOption(SortOption option) {
    state = state.copyWith(sortOption: option);
  }

  void setPriceRange(double? min, double? max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }

  void reset() {
    state = const FilterSortState();
  }
}

final filterSortProvider =
    StateNotifierProvider<FilterSortNotifier, FilterSortState>((ref) {
  return FilterSortNotifier();
});
