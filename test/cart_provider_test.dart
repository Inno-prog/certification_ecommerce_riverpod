import 'package:certification_ecommerce_riverpod/providers/cart_provider.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  const testProduct = Product(
    id: 'p1',
    name: 'Headphones',
    price: 59.99,
    description: '',
    imageUrl: '',
    category: 'Electronics',
    rating: 4.5,
  );

  test('CartNotifier add increments quantity for same product', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);

    notifier.add(testProduct);
    notifier.add(testProduct);

    expect(container.read(cartProvider).length, 1);
    expect(container.read(cartProvider).first.quantity, 2);
  });

  test('CartNotifier remove deletes item', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);

    notifier.add(testProduct);
    notifier.remove('p1');

    expect(container.read(cartProvider).length, 0);
  });

  test('CartNotifier total computes correctly', () {
    final container = ProviderContainer();
    final notifier = container.read(cartProvider.notifier);

    notifier.add(testProduct);

    expect(container.read(cartProvider.notifier).total, 59.99);
  });
}
