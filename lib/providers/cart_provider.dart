import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product product) {
    state = [
      for (final item in state)
        if (item.product.id == product.id)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
      if (state.every((item) => item.product.id != product.id))
        CartItem(id: product.id, product: product),
    ];
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

  @override
  void dispose() {
    // No resources to clean up for now, but kept for future extensibility
    super.dispose();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
