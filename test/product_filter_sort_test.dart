import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final products = [
    const Product(
      id: 'p1',
      name: 'Wireless Headphones',
      price: 59.99,
      description: '',
      imageUrl: '',
      category: 'Electronique',
      rating: 4.5,
    ),
    const Product(
      id: 'p2',
      name: 'Running Shoes',
      price: 89.99,
      description: '',
      imageUrl: '',
      category: 'Mode',
      rating: 4.2,
    ),
    const Product(
      id: 'p3',
      name: 'Smart Watch',
      price: 129.99,
      description: '',
      imageUrl: '',
      category: 'Electronique',
      rating: 4.7,
    ),
    const Product(
      id: 'p4',
      name: 'Backpack',
      price: 39.99,
      description: '',
      imageUrl: '',
      category: 'Accessoires',
      rating: 4.0,
    ),
  ];

  group('Filter logic', () {
    test('filter by category returns matching products only', () {
      final filtered =
          products.where((p) => p.category == 'Electronique').toList();
      expect(filtered.length, 2);
      expect(filtered.every((p) => p.category == 'Electronique'), true);
    });

    test('filter by price range (min and max)', () {
      final filtered =
          products.where((p) => p.price >= 50.0 && p.price <= 100.0).toList();
      expect(filtered.length, 2);
      expect(filtered.every((p) => p.price >= 50.0 && p.price <= 100.0), true);
    });

    test('filter by price min only', () {
      final filtered = products.where((p) => p.price >= 80.0).toList();
      expect(filtered.length, 2);
    });

    test('no filter returns all products', () {
      final filtered = products.where((p) => true).toList();
      expect(filtered.length, 4);
    });
  });

  group('Sort logic', () {
    test('sort by price ascending', () {
      final sorted = List<Product>.from(products)
        ..sort((a, b) => a.price.compareTo(b.price));
      expect(sorted.first.price, 39.99);
      expect(sorted.last.price, 129.99);
    });

    test('sort by price descending', () {
      final sorted = List<Product>.from(products)
        ..sort((a, b) => b.price.compareTo(a.price));
      expect(sorted.first.price, 129.99);
      expect(sorted.last.price, 39.99);
    });

    test('sort by rating descending', () {
      final sorted = List<Product>.from(products)
        ..sort((a, b) => b.rating.compareTo(a.rating));
      expect(sorted.first.rating, 4.7);
      expect(sorted.last.rating, 4.0);
    });

    test('relevance sort keeps original order', () {
      final sorted = List<Product>.from(products);
      expect(sorted.length, 4);
      expect(sorted[0].id, 'p1');
    });
  });

  group('Product model', () {
    test('copyWith returns same product when no fields provided', () {
      const product = Product(
        id: 'p1',
        name: 'Test',
        price: 10.0,
        description: 'Desc',
        imageUrl: 'url',
        category: 'Cat',
      );
      final copied = product.copyWith();
      expect(copied, equals(product));
    });

    test('copyWith updates rating and isFavorite', () {
      const product = Product(
        id: 'p1',
        name: 'Test',
        price: 10.0,
        description: 'Desc',
        imageUrl: 'url',
        category: 'Cat',
      );
      final updated = product.copyWith(rating: 5.0, isFavorite: true);
      expect(updated.rating, 5.0);
      expect(updated.isFavorite, true);
    });
  });
}
