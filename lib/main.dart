import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/core/app_router.dart';
import 'package:certification_ecommerce_riverpod/l10n/app_localizations.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';

/// Provider de la locale courante (FR par défaut)
final localeProvider = StateProvider<Locale>((ref) => const Locale('fr'));

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// Widget racine de l'application
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    final theme = ref.watch(appThemeProvider);

    return MaterialApp.router(
      title: 'Boutique',
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      theme: theme,
      routerConfig: router,
    );
  }
}
