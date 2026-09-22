import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/l10n/app_localizations.dart';
import 'package:certification_ecommerce_riverpod/main.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profileAsync = ref.watch(userProfileProvider);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: profileAsync == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 32),
                // Avatar avec label d'accessibilité
                Center(
                  child: Semantics(
                    label: 'Avatar de ${profileAsync.name}',
                    image: true,
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(profileAsync.avatarUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Infos profil
                Semantics(
                  label: '${l10n.name}: ${profileAsync.name}',
                  child: ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(l10n.name),
                    subtitle: Text(profileAsync.name),
                  ),
                ),
                Semantics(
                  label: '${l10n.email}: ${profileAsync.email}',
                  child: ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text(l10n.email),
                    subtitle: Text(profileAsync.email),
                  ),
                ),
                Semantics(
                  label: '${l10n.phone}: ${profileAsync.phone}',
                  child: ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: Text(l10n.phone),
                    subtitle: Text(profileAsync.phone),
                  ),
                ),
                Semantics(
                  label: '${l10n.address}: ${profileAsync.address}',
                  child: ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(l10n.address),
                    subtitle: Text(profileAsync.address),
                  ),
                ),
                const Divider(height: 32),
                // Sélecteur de langue
                Semantics(
                  label: '${l10n.language}: ${currentLocale.languageCode == 'fr' ? 'Français' : 'English'}',
                  button: true,
                  child: ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(l10n.language),
                    subtitle: Text(
                      currentLocale.languageCode == 'fr'
                          ? 'Français'
                          : 'English',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showLanguagePicker(context, ref, l10n),
                  ),
                ),
              ],
            ),
    );
  }

  /// Affiche le sélecteur de langue et applique la locale immédiatement
  void _showLanguagePicker(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.chooseLanguage,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          for (final entry in const {
            'Français': Locale('fr'),
            'English': Locale('en'),
          }.entries)
            Semantics(
              label: entry.key,
              button: true,
              child: ListTile(
                title: Text(entry.key),
                trailing: ref.watch(localeProvider) == entry.value
                    ? const Icon(Icons.check, color: Color(0xFF6C63FF))
                    : null,
                onTap: () {
                  ref.read(localeProvider.notifier).state = entry.value;
                  Navigator.pop(context);
                },
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
