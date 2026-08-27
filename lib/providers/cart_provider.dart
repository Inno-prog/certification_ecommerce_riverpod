import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product product) {
    final existing = state.indexWhere((item) => item.product.id == product.id);
    if (existing >= 0) {
      state = [
        ...state.sublist(0, existing),
        state[existing].copyWith(
            quantity: state[existing].quantity + 1),
        ...state.sublist(existing + 1),
      ];
    } else {
      state = [...state, CartItem(id: product.id, product: product)];
    }
  }

  void remove(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    state = state
        .map((item) =>
            item.product.id == productId ? item.copyWith(quantity: quantity) : item)
        .toList();
  }

  void clear() {
    state = [];
  }

  double get total =>
      state.fold(0, (sum, item) => sum + item.total);

  int get itemCount =>
      state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
