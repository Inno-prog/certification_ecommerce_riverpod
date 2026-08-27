import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Filtering and sorting logic', () {
    const products = [
      Product(
        id: 'p1',
        name: 'Headphones',
        price: 59.99,
        description: '',
        imageUrl: '',
        category: 'Electronics',
        rating: 4.5,
      ),
      Product(
        id: 'p2',
        name: 'Shoes',
        price: 89.99,
        description: '',
        imageUrl: '',
        category: 'Fashion',
        rating: 4.2,
      ),
      Product(
        id: 'p3',
        name: 'Watch',
        price: 129.99,
        description: '',
        imageUrl: '',
        category: 'Electronics',
        rating: 4.7,
      ),
    ];

    test('filter by category returns only matching products', () {
      final filtered = products.where((p) => p.category == 'Electronics').toList();
      expect(filtered.length, 2);
      expect(filtered.every((p) => p.category == 'Electronics'), true);
    });

    test('sort by price ascending orders correctly', () {
      final sorted = List<Product>.from(products);
      sorted.sort((a, b) => a.price.compareTo(b.price));
      expect(sorted.first.price, 59.99);
      expect(sorted.last.price, 129.99);
    });

    test('sort by price descending orders correctly', () {
      final sorted = List<Product>.from(products);
      sorted.sort((a, b) => b.price.compareTo(a.price));
      expect(sorted.first.price, 129.99);
      expect(sorted.last.price, 59.99);
    });

    test('sort by rating descending orders correctly', () {
      final sorted = List<Product>.from(products);
      sorted.sort((a, b) => b.rating.compareTo(a.rating));
      expect(sorted.first.rating, 4.7);
      expect(sorted.last.rating, 4.2);
    });
  });
}
