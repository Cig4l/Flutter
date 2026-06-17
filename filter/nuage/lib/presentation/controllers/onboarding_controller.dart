import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/data/repositories/onboarding_repository_impl.dart';
import 'package:nuage/domain/repositories/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override dans main()'),
);

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl(ref.watch(sharedPreferencesProvider));
});