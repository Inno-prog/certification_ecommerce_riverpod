import 'package:certification_ecommerce_riverpod/providers/filter_sort_provider.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('FilterSortNotifier updates category and sort option', () {
    final container = ProviderContainer();
    final notifier = container.read(filterSortProvider.notifier);

    notifier.setCategory('Electronics');
    expect(container.read(filterSortProvider).selectedCategory, 'Electronics');

    notifier.setSortOption(SortOption.priceAsc);
    expect(container.read(filterSortProvider).sortOption, SortOption.priceAsc);

    notifier.reset();
    expect(container.read(filterSortProvider).selectedCategory, isNull);
    expect(container.read(filterSortProvider).sortOption, SortOption.relevance);
  });
}
