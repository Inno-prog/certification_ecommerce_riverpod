import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/data/data_sources/mock_product_data_source.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product?> getProductById(String id);
}

class ProductRepositoryImpl implements ProductRepository {
  final MockProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts() => dataSource.getProducts();

  @override
  Future<Product?> getProductById(String id) => dataSource.getProductById(id);
}
