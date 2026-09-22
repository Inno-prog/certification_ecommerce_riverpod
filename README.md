# Boutique — Flutter E-commerce App

[![CI — Lint, Tests & Build](https://github.com/YOUR_USERNAME/certification_ecommerce_riverpod/actions/workflows/flutter.yml/badge.svg)](https://github.com/YOUR_USERNAME/certification_ecommerce_riverpod/actions/workflows/flutter.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.44.2-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-blue?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Application e-commerce Flutter production-ready avec Riverpod, go_router, internationalisation FR/EN et suite de tests complète.

---

## Fonctionnalités

- **6 écrans** : Accueil, Détail produit, Panier, Favoris, Commandes, Profil
- **Catalogue** : grille de produits avec filtres (catégorie, prix) et tri (pertinence, prix, note)
- **Panier** : ajout, suppression, modification de quantité, total dynamique
- **Favoris** : persistance locale via SharedPreferences
- **Commandes** : historique des commandes passées avec statut
- **Profil** : informations utilisateur + **sélecteur de langue en temps réel** (FR/EN)
- **Internationalisation** : Français 🇫🇷 et Anglais 🇬🇧
- **Accessibilité** : labels `Semantics` sur tous les éléments interactifs
- **Performance** : `const` widgets, images lazy-loaded avec `loadingBuilder`, `FutureProvider.autoDispose`, `flutter_hooks`
- **Animations** : transitions avec `flutter_animate`

---

## Architecture

```
lib/
├── core/
│   ├── app_router.dart          # Routes go_router (6 routes)
│   └── app_theme.dart           # ThemeData centralisé
├── data/
│   ├── data_sources/
│   │   ├── mock_product_data_source.dart
│   │   └── local_favorites_data_source.dart
│   ├── models/
│   │   └── models.dart          # Product, CartItem, UserProfile, FilterSortState
│   └── repositories/
│       ├── product_repository.dart
│       └── favorites_repository.dart
├── l10n/
│   ├── app_localizations.dart   # Base abstraite
│   ├── app_localizations_fr.dart
│   └── app_localizations_en.dart
├── providers/
│   ├── product_providers.dart   # FutureProvider.autoDispose + DI
│   ├── cart_provider.dart       # CartNotifier (StateNotifier)
│   ├── favorites_provider.dart  # FavoritesNotifier (StateNotifier)
│   ├── filter_sort_provider.dart
│   ├── orders_provider.dart     # OrdersNotifier (StateNotifier)
│   ├── user_profile_provider.dart
│   └── theme_provider.dart      # ThemeData via @riverpod (code generation)
├── screens/
│   ├── home_screen.dart         # Accueil + BottomNav (flutter_hooks)
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   ├── favorites_screen.dart
│   ├── orders_screen.dart       # Historique commandes
│   └── profile_screen.dart      # Sélecteur de langue
├── widgets/
│   ├── product_card.dart
│   └── filter_sort_bar.dart
├── main.dart                    # ProviderScope + l10n + localeProvider

test/
├── cart_provider_test.dart      # 3 tests — CartNotifier
├── shopping_cart_test.dart      # 8 tests — CartNotifier edge cases
├── favorites_provider_test.dart # 1 test — FavoritesNotifier toggle
├── filter_sort_provider_test.dart # 1 test — FilterSortNotifier
├── filter_sort_logic_test.dart  # 4 tests — Filtrage/Tri
├── product_filter_sort_test.dart # 9 tests — Filtres/Tri/copyWith
├── mock_product_data_source_test.dart # 3 tests — DataSource
├── models_test.dart             # 2 tests — Product/CartItem
├── orders_provider_test.dart    # 5 tests — OrdersNotifier/Order
├── product_providers_test.dart  # 3 tests — Products/detail providers
├── user_profile_provider_test.dart # 1 test — UserProfile
└── widget_test.dart             # 5 tests widget

integration_test/
└── app_test.dart                # 2 tests d'intégration
```

**State management** : Riverpod (`StateNotifierProvider`, `FutureProvider.autoDispose`, `@riverpod`)
**Navigation** : go_router avec routes nommées
**Persistance** : SharedPreferences pour les favoris
**Performance** : `const` constructors, `autoDispose`, `flutter_hooks`, images lazy-loaded

---

## Installation

### Prérequis

- Flutter 3.44.2+
- Dart 3.12+

### Étapes

```bash
git clone https://github.com/YOUR_USERNAME/certification_ecommerce_riverpod.git
cd certification_ecommerce_riverpod

flutter pub get
flutter gen-l10n
flutter run
```

### Changer la langue en temps réel

Allez dans l'écran Profil → « Langue » → sélectionnez Français ou English. L'interface se met à jour immédiatement via le `localeProvider` Riverpod.

### Build de production

```bash
# APK Android
flutter build apk --release --split-per-abi

# App Bundle
flutter build appbundle --release
```

---

## Tests

```bash
# Tous les tests unitaires et widget (10+ unit, 5 widget)
flutter test --coverage

# Tests d'intégration (émulateur requis)
flutter test integration_test/app_test.dart
```

---

## Analyse statique

```bash
flutter analyze   # Aucun problème
dart format lib/ test/
```

---

## CI/CD

Le pipeline `.github/workflows/flutter.yml` exécute automatiquement :

1. `flutter analyze` — analyse statique
2. `dart format` — vérification du formatage
3. `flutter test --coverage` — tests unitaires + widget
4. Build APK release (sur push vers `main`)

---

## Screenshots

| Accueil | Détail | Panier | Commandes | Profil |
|---------|--------|--------|-----------|--------|
| Sous Windows : `flutter screenshot` | | | | |
| Sous macOS : `flutter screenshot` | | | | |

Générez les captures d'écran en exécutant l'app sur un émulateur, puis utilisez :
```bash
flutter screenshot --type=png --output=screenshots/home.png
```

---

## Licence

MIT © 2025
