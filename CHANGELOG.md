# Changelog

Format basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

---

## [1.3.0] — 2025-09-15

### Ajouté
- Internationalisation complète FR 🇫🇷 et EN 🇬🇧 via `flutter_localizations`
- `localeProvider` (Riverpod) pour changer la langue en temps réel depuis le Profil
- Écran **Commandes** (`OrdersScreen`) — 5ème écran avec historique et statuts
- `OrdersNotifier` + `ordersProvider` pour gérer les commandes
- Labels `Semantics` sur tous les éléments interactifs (boutons, images, listes)
- `flutter_hooks` ajouté aux dépendances pour optimiser les rebuilds
- Suite de tests complète : 10 tests unitaires, 5 tests widget, 2 tests d'intégration
- Pipeline CI/CD GitHub Actions amélioré (lint + tests + build APK)
- `CHANGELOG.md` et `README.md` professionnels

### Modifié
- `main.dart` : ajout `localizationsDelegates` et `localeProvider`
- `home_screen.dart` : BottomNav à 5 onglets, l10n, `Semantics` sur les cartes produit
- `cart_screen.dart` : l10n, `Semantics`, bouton Commander crée un `Order` réel
- `profile_screen.dart` : l10n, `Semantics`, sélecteur de langue fonctionnel
- CI/CD : ajout build APK, upload artifact, badge README

---

## [1.2.0] — 2025-08-01

### Ajouté
- Filtres par catégorie et plage de prix (`FilterSortBar`)
- Tri par pertinence, prix croissant/décroissant, note
- Persistance des favoris via `SharedPreferences` (`LocalFavoritesDataSource`)
- Animations d'entrée sur les cartes produit (`flutter_animate`)
- Hero animation sur l'image du détail produit
- Chargement lazy des images avec `loadingBuilder`

### Modifié
- `ProductCard` : affichage de la note avec étoiles
- `ProductDetailScreen` : bouton "Ajouter au panier" avec animation shake
- Architecture data : séparation DataSource / Repository / Provider

---

## [1.1.0] — 2025-07-01

### Ajouté
- Navigation avec `go_router` (routes nommées)
- Écran détail produit (`ProductDetailScreen`) avec Hero animation
- Écran favoris (`FavoritesScreen`)
- Écran profil (`ProfileScreen`) avec données mock
- `CartNotifier` : add, remove, updateQuantity, clear, total
- `FavoritesNotifier` : toggle, isFavorite
- Données produits depuis `assets/data/products.json`

### Modifié
- Migration vers Riverpod `StateNotifierProvider`
- Thème Material 3 avec `ColorScheme.fromSeed`

---

## [1.0.0] — 2025-06-01

### Ajouté
- Version initiale de l'application e-commerce
- Écran d'accueil avec grille de produits
- Écran panier basique
- State management avec `flutter_riverpod`
- Modèles `Product`, `CartItem`, `UserProfile`
