import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/data/repositories/product_repository.dart';
import 'package:certification_ecommerce_riverpod/providers/product_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository implements ProductRepository {
  final List<Product> _products = const [
    Product(
      id: 'p1',
      name: 'Wireless Headphones',
      price: 59.99,
      description: 'High quality wireless headphones.',
      imageUrl: 'https://example.com/img1.png',
      category: 'Electronique',
      rating: 4.5,
    ),
    Product(
      id: 'p2',
      name: 'Running Shoes',
      price: 89.99,
      description: 'Comfortable running shoes.',
      imageUrl: 'https://example.com/img2.png',
      category: 'Mode',
      rating: 4.2,
    ),
  ];

  @override
  Future<List<Product>> getProducts() async => List.from(_products);

  @override
  Future<Product?> getProductById(String id) async {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

void main() {
  group('ProductProviders', () {
    test('productsProvider returns list of products', () async {
      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(FakeProductRepository()),
        ],
      );

      final result = await container.read(productsProvider.future);

      expect(result.length, 2);
      expect(result[0].id, 'p1');
      expect(result[0].name, 'Wireless Headphones');
      expect(result[1].id, 'p2');
    });

    test('productDetailProvider returns product by id', () async {
      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(FakeProductRepository()),
        ],
      );

      final result = await container.read(productDetailProvider('p1').future);

      expect(result, isNotNull);
      expect(result!.id, 'p1');
      expect(result.name, 'Wireless Headphones');
    });

    test('productDetailProvider returns null for unknown id', () async {
      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(FakeProductRepository()),
        ],
      );

      final result = await container.read(productDetailProvider('unknown').future);

      expect(result, isNull);
    });
  });
}
