import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';

/// Statuts possibles d'une commande
enum OrderStatus { pending, shipped, delivered }

/// Modèle d'une commande passée
class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    this.status = OrderStatus.pending,
  });

  @override
  List<Object?> get props => [id, items, total, date, status];
}

/// Notifier qui gère la liste des commandes
class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier() : super([]);

  /// Crée une commande à partir des articles du panier
  void placeOrder(List<CartItem> cartItems) {
    if (cartItems.isEmpty) return;
    final total = cartItems.fold(0.0, (sum, item) => sum + item.total);
    final order = Order(
      id: const Uuid().v4(),
      items: List.unmodifiable(cartItems),
      total: total,
      date: DateTime.now(),
    );
    state = [order, ...state];
  }
}

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  return OrdersNotifier();
});
