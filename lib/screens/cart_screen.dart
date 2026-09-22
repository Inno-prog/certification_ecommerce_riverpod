import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:certification_ecommerce_riverpod/l10n/app_localizations.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cart),
        actions: [
          // Bouton vider le panier
          if (cartItems.isNotEmpty)
            Semantics(
              label: l10n.clearCart,
              button: true,
              child: IconButton(
                icon: const Icon(Icons.delete_sweep_outlined),
                tooltip: l10n.clearCart,
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(l10n.clearCart),
                      content: Text(l10n.clearCartConfirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(l10n.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(l10n.confirm,
                              style: const TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) cartNotifier.clear();
                },
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(l10n.emptyCart,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Semantics(
                        label:
                            '${item.product.name} — ${l10n.quantity}: ${item.quantity}',
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item.product.imageUrl,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                // Image lazy-loadée avec indicateur de progression
                                loadingBuilder: (_, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    width: 56,
                                    height: 56,
                                    color: Colors.grey[100],
                                    child: const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (_, __, ___) => Container(
                                  width: 56,
                                  height: 56,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            title: Text(item.product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
                            subtitle: Text(
                                '${item.total.toStringAsFixed(2)} €'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Semantics(
                                  label: 'Diminuer quantité',
                                  button: true,
                                  child: IconButton(
                                    icon: const Icon(
                                        Icons.remove_circle_outline),
                                    onPressed: () =>
                                        ref.read(cartProvider.notifier)
                                            .updateQuantity(item.product.id,
                                                item.quantity - 1),
                                  ),
                                ),
                                Text('${item.quantity}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Semantics(
                                  label: 'Augmenter quantité',
                                  button: true,
                                  child: IconButton(
                                    icon: const Icon(
                                        Icons.add_circle_outline),
                                    onPressed: () =>
                                        ref.read(cartProvider.notifier)
                                            .updateQuantity(item.product.id,
                                                item.quantity + 1),
                                  ),
                                ),
                                Semantics(
                                  label: 'Supprimer ${item.product.name}',
                                  button: true,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.redAccent),
                                    onPressed: () =>
                                        ref.read(cartProvider.notifier)
                                            .remove(item.product.id),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().slideX(begin: 0.1).fadeIn(duration: 200.ms),
                      );
                    },
                  ),
                ),
                // Récapitulatif total + bouton commander
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${l10n.total}:',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${cartNotifier.total.toStringAsFixed(2)} €',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF6C63FF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Semantics(
                          label: l10n.checkout,
                          button: true,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: cartItems.isEmpty
                                  ? null
                                  : () {
                                      // Créer la commande et vider le panier
                                      ref
                                          .read(ordersProvider.notifier)
                                          .placeOrder(cartItems);
                                      cartNotifier.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(l10n.orderPlaced),
                                          action: SnackBarAction(
                                            label: l10n.orders,
                                            onPressed: () =>
                                                context.push('/orders'),
                                          ),
                                        ),
                                      );
                                    },
                              child: Text(l10n.checkout),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
