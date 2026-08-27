import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail du produit'),
        actions: [
          productAsync.maybeWhen(
            data: (product) {
              if (product == null) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(
                  favorites.contains(product.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggle(product.id);
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return const Center(child: Text('Produit introuvable'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product_${product.id}',
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 320,
                        color: const Color(0xFFF1F3FF),
                        child: const Center(
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        Container(height: 320, color: const Color(0xFFF1F3FF), child: const Icon(Icons.broken_image)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, color: Colors.amber[600]),
                          const SizedBox(width: 6),
                          Text(
                            '${product.rating} / 5',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          Text(
                            '${product.price.toStringAsFixed(2)} €',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: const Color(0xFF6C63FF),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(cartProvider.notifier).add(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} ajoute au panier'),
                                action: SnackBarAction(
                                  label: 'Voir',
                                  onPressed: () => context.push('/cart'),
                                ),
                              ),
                            );
                          },
                          child: const Text('Ajouter au panier'),
                        ),
                      )
                          .animate()
                          .scale(duration: 200.ms, curve: Curves.easeInOut)
                          .then()
                          .shake(duration: 400.ms, hz: 4, curve: Curves.easeInOut),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}
