import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';
import 'package:certification_ecommerce_riverpod/widgets/product_card.dart';
import 'package:certification_ecommerce_riverpod/widgets/filter_sort_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    final filterSortState = ref.watch(filterSortProvider);
    final cartItems = ref.watch(cartProvider);
    final favorites = ref.watch(favoritesProvider);
    final cartCount = cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Ecommerce',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => context.push('/cart'),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          var filtered = products;

          if (filterSortState.selectedCategory != null) {
            filtered = filtered
                .where((p) => p.category == filterSortState.selectedCategory)
                .toList();
          }

          if (filterSortState.minPrice != null) {
            filtered = filtered
                .where((p) => p.price >= filterSortState.minPrice!)
                .toList();
          }
          if (filterSortState.maxPrice != null) {
            filtered = filtered
                .where((p) => p.price <= filterSortState.maxPrice!)
                .toList();
          }

          switch (filterSortState.sortOption) {
            case SortOption.priceAsc:
              filtered.sort((a, b) => a.price.compareTo(b.price));
              break;
            case SortOption.priceDesc:
              filtered.sort((a, b) => b.price.compareTo(a.price));
              break;
            case SortOption.rating:
              filtered.sort((a, b) => b.rating.compareTo(a.rating));
              break;
            case SortOption.relevance:
              break;
          }

          if (filtered.isEmpty) {
            return const Center(
              child: Text('Aucun produit trouve'),
            );
          }

          return Column(
            children: [
              const FilterSortBar(),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return ProductCard(
                      product: product,
                      isFavorite: favorites.contains(product.id),
                      onTap: () => context.push('/product/${product.id}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              break;
            case 1:
              context.push('/favorites');
              break;
            case 2:
              context.push('/cart');
              break;
            case 3:
              context.push('/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
