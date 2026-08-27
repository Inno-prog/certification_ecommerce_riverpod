import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier() : super(null) {
    loadMockProfile();
  }

  void loadMockProfile() {
    state = const UserProfile(
      name: 'Inno Seck',
      email: 'inno@example.com',
      phone: '+221 77 123 45 67',
      address: 'Dakar, Sénégal',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
    );
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  return UserProfileNotifier();
});
