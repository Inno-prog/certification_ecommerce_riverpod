# Boutique — Flutter E-commerce App

[![CI — Lint, Tests & Build](https://github.com/YOUR_USERNAME/certification_ecommerce_riverpod/actions/workflows/flutter.yml/badge.svg)](https://github.com/YOUR_USERNAME/certification_ecommerce_riverpod/actions/workflows/flutter.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.44.2-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-blue?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Application e-commerce Flutter production-ready avec Riverpod, go_router, internationalisation FR/EN et suite de tests complète.

---

## Fonctionnalités

- **5 écrans** : Accueil, Détail produit, Panier, Favoris, Commandes, Profil
- **Catalogue** : grille de produits avec filtres (catégorie, prix) et tri (pertinence, prix, note)
- **Panier** : ajout, suppression, modification de quantité, total dynamique
- **Favoris** : persistance locale via SharedPreferences
- **Commandes** : historique des commandes passées avec statut
- **Profil** : informations utilisateur + sélecteur de langue
- **Internationalisation** : Français 🇫🇷 et Anglais 🇬🇧
- **Accessibilité** : labels `Semantics` sur tous les éléments interactifs
- **Performance** : `const` widgets, images lazy-loaded avec `loadingBuilder`, `FutureProvider.autoDispose`

---

## Architecture

```
lib/
├── core/
│   └── app_router.dart          # Routes go_router (6 routes)
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
│   ├── app_fr.arb               # Traductions françaises
│   └── app_en.arb               # Traductions anglaises
├── providers/
│   ├── cart_provider.dart       # CartNotifier (StateNotifier)
│   ├── favorites_provider.dart  # FavoritesNotifier (StateNotifier)
│   ├── filter_sort_provider.dart
│   ├── orders_provider.dart     # OrdersNotifier (StateNotifier)
│   ├── product_providers.dart   # FutureProvider.autoDispose
│   └── user_profile_provider.dart
├── screens/
│   ├── home_screen.dart         # Accueil + BottomNav
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   ├── favorites_screen.dart
│   ├── orders_screen.dart       # Historique commandes
│   └── profile_screen.dart
├── widgets/
│   ├── product_card.dart
│   └── filter_sort_bar.dart
└── main.dart                    # ProviderScope + l10n + localeProvider

test/
├── cart_provider_test.dart      # 3 tests
├── favorites_provider_test.dart # 1 test
├── filter_sort_provider_test.dart # 1 test
├── filter_sort_logic_test.dart  # 1 test
├── mock_product_data_source_test.dart # 1 test
├── models_test.dart             # 2 tests
├── orders_provider_test.dart    # 5 tests  ← nouveau
├── product_providers_test.dart  # 1 test
├── user_profile_provider_test.dart # 1 test
└── widget_test.dart             # 5 tests widget ← nouveau

integration_test/
└── app_test.dart                # 2 tests d'intégration ← nouveau
```

**State management** : Riverpod (`StateNotifierProvider`, `FutureProvider.autoDispose`)  
**Navigation** : go_router avec routes nommées  
**Persistance** : SharedPreferences pour les favoris  
**Performance** : `const` constructors, `autoDispose`, images lazy-loaded

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
# Tous les tests unitaires et widget (10 unit + 5 widget)
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
| *(à venir)* | *(à venir)* | *(à venir)* | *(à venir)* | *(à venir)* |

---

## Licence

MIT © 2025
