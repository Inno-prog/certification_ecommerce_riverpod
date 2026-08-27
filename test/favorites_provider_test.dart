import 'package:certification_ecommerce_riverpod/providers/favorites_provider.dart';
import 'package:certification_ecommerce_riverpod/data/repositories/favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeFavoritesRepository implements FavoritesRepository {
  final Set<String> _ids = {};

  @override
  Future<Set<String>> getFavorites() async => Set.from(_ids);

  @override
  Future<void> toggleFavorite(String productId, Set<String> current) async {
    final updated = Set<String>.from(current);
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    _ids.clear();
    _ids.addAll(updated);
  }
}

void main() {
  test('FavoritesNotifier toggle adds and removes id', () async {
    final container = ProviderContainer(
      overrides: [
        favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
      ],
    );

    final notifier = container.read(favoritesProvider.notifier);

    await notifier.toggle('p1');
    expect(container.read(favoritesProvider).contains('p1'), true);

    await notifier.toggle('p1');
    expect(container.read(favoritesProvider).contains('p1'), false);
  });
}
