import 'package:certification_ecommerce_riverpod/providers/user_profile_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('UserProfileNotifier loads a non-null profile', () async {
    final container = ProviderContainer();
    final notifier = container.read(userProfileProvider.notifier);

    notifier.loadMockProfile();
    final profile = container.read(userProfileProvider);

    expect(profile, isNotNull);
    expect(profile!.name, 'Inno Seck');
    expect(profile.email, 'inno@example.com');
  });
}
