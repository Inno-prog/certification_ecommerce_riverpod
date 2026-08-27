# Certification E-Commerce Flutter App

A Flutter e-commerce application built with **Riverpod** for state management. This project fulfills the certification requirements: product catalog, shopping cart, favorites (persisted locally), filtering/sorting, mock profile, loading/error handling with `AsyncValue`, layered architecture, and cart animations.

## Architecture

The project follows a layered architecture with clear separation between data, business logic, and presentation layers.

```
lib/
├── main.dart                 # Entrypoint + Riverpod provider scope + GoRouter
├── core/
│   └── app_router.dart       # Navigation routes using go_router
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

## Providers Used

1. **productsProvider** (`FutureProvider<List<Product>>`)
   - Fetches the product catalog from the mock data source.

2. **productDetailProvider** (`FutureProvider.family<Product?, String>`)
   - Fetches a single product by ID.

3. **cartProvider** (`StateNotifierProvider<CartNotifier, List<CartItem>>`)
   - Manages shopping cart state (add, remove, update quantity, clear).

4. **favoritesProvider** (`StateNotifierProvider<FavoritesNotifier, Set<String>>`)
   - Manages favorite product IDs, persisted via `SharedPreferences`.

5. **filterSortProvider** (`StateNotifierProvider<FilterSortNotifier, FilterSortState>`)
   - Manages filter and sort options (category, sort order, price range).

6. **userProfileProvider** (`StateNotifierProvider<UserProfileNotifier, UserProfile?>`)
   - Manages mock user profile data.

## Features

- **Product catalog**: grid view with images, prices, ratings, and favorite toggle.
- **Product detail**: full details with add-to-cart action.
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
# certification_ecommerce_riverpod
