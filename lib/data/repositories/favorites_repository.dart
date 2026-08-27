import 'package:certification_ecommerce_riverpod/data/data_sources/local_favorites_data_source.dart';

abstract class FavoritesRepository {
  Future<Set<String>> getFavorites();
  Future<void> toggleFavorite(String productId, Set<String> current);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocalFavoritesDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<Set<String>> getFavorites() => dataSource.getFavorites();

  @override
  Future<void> toggleFavorite(String productId, Set<String> current) =>
      dataSource.toggleFavorite(productId, current);
}
