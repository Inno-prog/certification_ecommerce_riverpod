import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/providers/cart_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  const product1 = Product(
    id: 'p1',
    name: 'Headphones',
    price: 59.99,
    description: '',
    imageUrl: '',
    category: 'Electronics',
    rating: 4.5,
  );

  const product2 = Product(
    id: 'p2',
    name: 'Shoes',
    price: 89.99,
    description: '',
    imageUrl: '',
    category: 'Fashion',
    rating: 4.2,
  );

  group('CartNotifier', () {
    test('add: adds new product when cart is empty', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      expect(container.read(cartProvider).length, 1);
      expect(container.read(cartProvider).first.quantity, 1);
    });

    test('add: adds different products separately', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).add(product2);
      expect(container.read(cartProvider).length, 2);
    });

    test('remove: does nothing when product not found', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).remove('nonexistent');
      expect(container.read(cartProvider).length, 1);
    });

    test('updateQuantity: updates quantity correctly', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).updateQuantity('p1', 5);
      expect(container.read(cartProvider).first.quantity, 5);
    });

    test('updateQuantity: removes item when quantity is 0', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).updateQuantity('p1', 0);
      expect(container.read(cartProvider).isEmpty, true);
    });

    test('clear: empties the cart', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).add(product2);
      container.read(cartProvider.notifier).clear();
      expect(container.read(cartProvider).isEmpty, true);
    });

    test('total: calculates correct total for multiple items', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).add(product2);
      final total = container.read(cartProvider.notifier).total;
      expect(total, closeTo(59.99 * 2 + 89.99, 0.01));
    });

    test('itemCount: counts all quantities', () {
      final container = ProviderContainer();
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).add(product1);
      container.read(cartProvider.notifier).add(product2);
      expect(container.read(cartProvider.notifier).itemCount, 3);
    });
  });
}
