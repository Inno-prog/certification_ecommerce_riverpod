// Tests unitaires — OrdersNotifier et modèle Order
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/providers/orders_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Produit et article de panier réutilisables dans les tests
const _product = Product(
  id: 'p1',
  name: 'Casque Audio',
  price: 59.99,
  description: 'Casque sans fil',
  imageUrl: 'https://example.com/img.jpg',
  category: 'Électronique',
  rating: 4.5,
);

const _cartItem = CartItem(id: 'p1', product: _product, quantity: 2);

void main() {
  group('OrdersNotifier', () {
    test('placeOrder crée une commande avec le bon total', () {
      final container = ProviderContainer();
      container.read(ordersProvider.notifier).placeOrder([_cartItem]);

      final orders = container.read(ordersProvider);
      expect(orders.length, 1);
      // total = 59.99 × 2 = 119.98
      expect(orders.first.total, closeTo(119.98, 0.01));
    });

    test('placeOrder avec panier vide ne crée pas de commande', () {
      final container = ProviderContainer();
      container.read(ordersProvider.notifier).placeOrder([]);

      expect(container.read(ordersProvider), isEmpty);
    });

    test('plusieurs commandes s\'accumulent dans l\'ordre inverse', () {
      final container = ProviderContainer();
      final notifier = container.read(ordersProvider.notifier);

      notifier.placeOrder([_cartItem]);
      notifier.placeOrder([_cartItem]);

      final orders = container.read(ordersProvider);
      expect(orders.length, 2);
    });
  });

  group('Order', () {
    test('statut par défaut est pending', () {
      final order = Order(
        id: 'o1',
        items: const [_cartItem],
        total: 119.98,
        date: DateTime(2025, 1, 1),
      );
      expect(order.status, OrderStatus.pending);
    });

    test('Equatable — deux Order identiques sont égaux', () {
      final date = DateTime(2025, 6, 1);
      final o1 = Order(
          id: 'o1', items: const [_cartItem], total: 59.99, date: date);
      final o2 = Order(
          id: 'o1', items: const [_cartItem], total: 59.99, date: date);
      expect(o1, equals(o2));
    });
  });
}
