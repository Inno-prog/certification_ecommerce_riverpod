import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/repositories/favorites_repository.dart';
import 'package:certification_ecommerce_riverpod/data/data_sources/local_favorites_data_source.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(LocalFavoritesDataSource());
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this.repository) : super({}) {
    load();
  }

  final FavoritesRepository repository;

  Future<void> load() async {
    state = await repository.getFavorites();
  }

  Future<void> toggle(String productId) async {
    await repository.toggleFavorite(productId, state);
    final updated = Set<String>.from(state);
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    state = updated;
  }

  bool isFavorite(String productId) => state.contains(productId);
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  final repo = ref.watch(favoritesRepositoryProvider);
  return FavoritesNotifier(repo);
});
