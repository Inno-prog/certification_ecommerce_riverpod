import 'package:certification_ecommerce_riverpod/data/data_sources/mock_product_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MockProductDataSource', () {
    late MockProductDataSource dataSource;

    setUp(() {
      dataSource = MockProductDataSource();
    });

    test('getProducts returns a non-empty list from assets', () async {
      final products = await dataSource.getProducts();
      expect(products, isNotEmpty);
      expect(products.first.id, isA<String>());
      expect(products.first.name, isA<String>());
    });

    test('getProductById returns matching product', () async {
      final products = await dataSource.getProducts();
      final firstId = products.first.id;

      final product = await dataSource.getProductById(firstId);
      expect(product, isNotNull);
      expect(product!.id, firstId);
    });

    test('getProductById returns null for unknown id', () async {
      final product = await dataSource.getProductById('unknown-id');
      expect(product, isNull);
    });
  });
}
