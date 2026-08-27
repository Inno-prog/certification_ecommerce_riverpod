# Certification E-Commerce Flutter App

A Flutter e-commerce application built with **Riverpod** for state management. This project fulfills the certification requirements: product catalog, shopping cart, favorites (persisted locally), filtering/sorting, mock profile, loading/error handling with `AsyncValue`, layered architecture, and cart animations.

## Architecture

The project follows a layered architecture with clear separation between data, business logic, and presentation layers.

```
lib/
├── main.dart                 # Entrypoint + Riverpod provider scope + GoRouter
├── core/
│   └── app_router.dart       # Centralized navigation routes using go_router
├── data/
│   ├── models/               # Entities: Product, CartItem, UserProfile, FilterSortState
│   ├── repositories/         # Repository interfaces and implementations
│   ├── data_sources/         # Mock API and local persistence (SharedPreferences)
│   └── data.dart             # Barrel export
├── providers/                # Riverpod providers and state notifiers
│   ├── product_providers.dart
│   ├── cart_provider.dart
│   ├── favorites_provider.dart
│   ├── filter_sort_provider.dart
│   ├── user_profile_provider.dart
│   └── providers.dart        # Barrel export
├── screens/                  # Presentation layer (widgets)
│   ├── home_screen.dart
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   ├── favorites_screen.dart
│   ├── profile_screen.dart
│   └── screens.dart          # Barrel export
└── widgets/                  # Reusable UI components
    ├── product_card.dart
    └── filter_sort_bar.dart
```

## Data Flow

The application follows a unidirectional data flow pattern:

1. **UI Layer (Screens/Widgets)**: Watches providers and renders UI based on state changes.
2. **Provider Layer**: Exposes state via Riverpod providers. `FutureProvider` handles async data, `StateNotifierProvider` handles mutable state.
3. **Repository Layer**: Abstracts data operations behind interfaces (`ProductRepository`, `FavoritesRepository`).
4. **Data Source Layer**: Implements actual data fetching (`MockProductDataSource` reads from JSON assets) and local persistence (`LocalFavoritesDataSource` uses `SharedPreferences`).

### Example: Product Catalog Flow

```
HomeScreen
  └─ watches productsProvider (FutureProvider)
       └─ reads productRepositoryProvider
            └─ ProductRepositoryImpl.getProducts()
                 └─ MockProductDataSource.getProducts()
                      └─ loads assets/data/products.json
                           └─ returns List<Product>
```

### Example: Cart Flow

```
ProductCard / ProductDetailScreen
  └─ reads cartProvider.notifier
       └─ CartNotifier.add(product)
            └─ updates state (List<CartItem>)
                 └─ UI rebuilds with new cart count and items
```

## Providers Used

1. **productsProvider** (`FutureProvider<List<Product>>`)
   - Fetches the product catalog from the mock data source.
   - Returns `AsyncValue<List<Product>>` with loading, data, and error states.

2. **productDetailProvider** (`FutureProvider.family<Product?, String>`)
   - Fetches a single product by ID.
   - Parameterized by product ID for efficient caching.

3. **cartProvider** (`StateNotifierProvider<CartNotifier, List<CartItem>>`)
   - Manages shopping cart state (add, remove, update quantity, clear).
   - Computes `total` and `itemCount` getters.

4. **favoritesProvider** (`StateNotifierProvider<FavoritesNotifier, Set<String>>`)
   - Manages favorite product IDs, persisted via `SharedPreferences`.
   - Loads favorites on initialization.

5. **filterSortProvider** (`StateNotifierProvider<FilterSortNotifier, FilterSortState>`)
   - Manages filter and sort options (category, sort order, price range).
   - State is applied in `HomeScreen` to transform the product list.

6. **userProfileProvider** (`StateNotifierProvider<UserProfileNotifier, UserProfile?>`)
   - Manages mock user profile data.

## Filtering & Sorting

The `FilterSortState` model holds the current filter and sort configuration:

```dart
class FilterSortState extends Equatable {
  final String? selectedCategory;  // e.g., 'Electronique', 'Mode'
  final SortOption sortOption;      // relevance, priceAsc, priceDesc, rating
  final double? minPrice;           // minimum price filter
  final double? maxPrice;           // maximum price filter
}
```

### How Filtering Works

In `HomeScreen`, the raw product list from `productsProvider` is transformed:

1. **Category filter**: `products.where((p) => p.category == selectedCategory)`
2. **Price range filter**: `products.where((p) => p.price >= minPrice && p.price <= maxPrice)`
3. **Sorting**: Applied via `List.sort()` based on `SortOption`:
   - `priceAsc`: ascending price
   - `priceDesc`: descending price
   - `rating`: highest rating first
   - `relevance`: no sorting (original order)

The `FilterSortBar` widget provides UI controls for selecting category and sort option.

## Features

- **Product catalog**: grid view with images, prices, ratings, and favorite toggle.
- **Product detail**: full details with add-to-cart action and `AsyncValue` loading/error states.
- **Shopping cart**: add/remove items, update quantities, total calculation, checkout placeholder.
- **Favorites**: persisted locally via `SharedPreferences`.
- **Filtering & sorting**: by category, price range, price order, and rating.
- **User profile**: mock profile with avatar, name, email, phone, and address.
- **Loading & error states**: all async screens use `AsyncValue` with loading spinners and error messages.
- **Cart animations**: scale and shake animations on add-to-cart button; slide and fade animations for cart items.

## Tech Stack

- Flutter 3.44+
- Riverpod 2.6+ (`flutter_riverpod`, `hooks_riverpod`, `riverpod_annotation`)
- go_router 14+ for navigation
- SharedPreferences for local persistence
- flutter_animate 4.5+ for animations
- Equatable for value comparison

## CI/CD

A GitHub Actions workflow is configured to run `flutter analyze` and `flutter test` on every push and pull request to `main`.

## Getting Started

```bash
cd certification_ecommerce_riverpod
flutter pub get
flutter run
```

## Testing

Run the test suite:

```bash
flutter test
```

Tests cover:
- Cart provider (add, remove, total calculation)
- Favorites provider (toggle with fake repository)
- Filter/Sort provider (state updates)
- Product providers (fetching with fake repository)
- Model copyWith and computed properties
- User profile provider
