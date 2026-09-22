// Tests widget — rendu des composants UI principaux
import 'package:certification_ecommerce_riverpod/data/models/models.dart';
import 'package:certification_ecommerce_riverpod/l10n/app_localizations.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';
import 'package:certification_ecommerce_riverpod/screens/cart_screen.dart';
import 'package:certification_ecommerce_riverpod/screens/favorites_screen.dart';
import 'package:certification_ecommerce_riverpod/screens/orders_screen.dart';
import 'package:certification_ecommerce_riverpod/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Enveloppe un widget avec ProviderScope + MaterialApp + l10n
Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr'), Locale('en')],
      locale: const Locale('fr'),
      home: child,
    ),
  );
}

// Produit de test
const _product = Product(
  id: 'p1',
  name: 'Chaussures Sport',
  price: 89.99,
  description: 'Confortables',
  imageUrl: 'https://picsum.photos/200',
  category: 'Mode',
  rating: 4.2,
);

void main() {
  // ── Test 1 : ProductCard affiche le nom et le prix ──────────────────────
  testWidgets('ProductCard affiche le nom et le prix du produit',
      (tester) async {
    await tester.pumpWidget(_wrap(
      Scaffold(
        body: ProductCard(
          product: _product,
          isFavorite: false,
          onTap: () {},
        ),
      ),
    ));

    expect(find.text('Chaussures Sport'), findsOneWidget);
    expect(find.text('89.99 €'), findsOneWidget);
  });

  // ── Test 2 : ProductCard favori affiche l'icône remplie ─────────────────
  testWidgets('ProductCard favori affiche Icons.favorite', (tester) async {
    await tester.pumpWidget(_wrap(
      Scaffold(
        body: ProductCard(
          product: _product,
          isFavorite: true,
          onTap: () {},
        ),
      ),
    ));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  // ── Test 3 : CartScreen vide affiche le message approprié ───────────────
  testWidgets('CartScreen vide affiche "Votre panier est vide"',
      (tester) async {
    await tester.pumpWidget(_wrap(const CartScreen()));
    await tester.pump();

    expect(find.text('Votre panier est vide'), findsOneWidget);
  });

  // ── Test 4 : OrdersScreen vide affiche le message approprié ────────────
  testWidgets('OrdersScreen vide affiche "Aucune commande pour le moment"',
      (tester) async {
    await tester.pumpWidget(_wrap(const OrdersScreen()));
    await tester.pump();

    expect(find.text('Aucune commande pour le moment'), findsOneWidget);
  });

  // ── Test 5 : FavoritesScreen vide affiche le message approprié ─────────
  testWidgets('FavoritesScreen vide affiche "Aucun favori pour le moment"',
      (tester) async {
    // Override productsProvider pour éviter le chargement réseau
    await tester.pumpWidget(_wrap(
      const FavoritesScreen(),
      overrides: [
        productsProvider.overrideWith(
          (ref) async => const [],
        ),
      ],
    ));
    await tester.pumpAndSettle();

    expect(find.text('Aucun favori pour le moment'), findsOneWidget);
  });
}
