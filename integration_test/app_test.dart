// Tests d'intégration — navigation et flux utilisateur complets
import 'package:certification_ecommerce_riverpod/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ── Test 1 : Navigation via la BottomNavigationBar ─────────────────────
  testWidgets('Navigation entre les 5 onglets de la BottomNavigationBar',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // L'app démarre sur l'accueil
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Naviguer vers Favoris (index 1)
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Naviguer vers Panier (index 2)
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Votre panier est vide'), findsOneWidget);

    // Naviguer vers Commandes (index 3)
    await tester.tap(find.byIcon(Icons.receipt_long_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Aucune commande pour le moment'), findsOneWidget);

    // Naviguer vers Profil (index 4)
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
  });

  // ── Test 2 : Panier vide → message affiché ─────────────────────────────
  testWidgets('Le panier vide affiche le bon message', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Aller au panier
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();

    // Vérifier le message panier vide
    expect(find.text('Votre panier est vide'), findsOneWidget);
    // Vérifier que le bouton Commander est désactivé (panier vide)
    final btn = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Commander'),
    );
    expect(btn.onPressed, isNull);
  });
}
