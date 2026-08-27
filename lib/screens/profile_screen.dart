import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/providers/providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
      ),
      body: profileAsync == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 32),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(profileAsync.avatarUrl),
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Nom'),
                  subtitle: Text(profileAsync.name),
                ),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Email'),
                  subtitle: Text(profileAsync.email),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text('Telephone'),
                  subtitle: Text(profileAsync.phone),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Adresse'),
                  subtitle: Text(profileAsync.address),
                ),
              ],
            ),
    );
  }
}
