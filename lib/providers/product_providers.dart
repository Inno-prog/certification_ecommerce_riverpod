import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/data/repositories/product_repository.dart';
import 'package:certification_ecommerce_riverpod/data/data_sources/mock_product_data_source.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(MockProductDataSource());
});

final productsProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getProducts();
});

final productDetailProvider =
    FutureProvider.autoDispose.family<Product?, String>((ref, id) {
  return ref.watch(productRepositoryProvider).getProductById(id);
});
