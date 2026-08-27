import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product', () {
    test('copyWith updates specified fields', () {
      const product = Product(
        id: 'p1',
        name: 'Headphones',
        price: 59.99,
        description: 'Nice',
        imageUrl: 'https://example.com/img.png',
        category: 'Electronics',
        rating: 4.5,
        isFavorite: false,
      );

      final updated = product.copyWith(price: 49.99, isFavorite: true);

      expect(updated.id, 'p1');
      expect(updated.price, 49.99);
      expect(updated.isFavorite, true);
      expect(updated.name, 'Headphones');
    });
  });

  group('CartItem', () {
    test('total is price times quantity', () {
      const product = Product(
        id: 'p1',
        name: 'Shoes',
        price: 89.99,
        description: '',
        imageUrl: '',
        category: '',
        rating: 0,
      );

      const item = CartItem(id: 'c1', product: product, quantity: 2);

      expect(item.total, 179.98);
    });
  });
}
