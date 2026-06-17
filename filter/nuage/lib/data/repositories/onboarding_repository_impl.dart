// lib/data/repositories/onboarding_repository_impl.dart
import 'package:nuage/domain/repositories/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'has_completed_onboarding';

  @override
  Future<bool> hasCompletedOnboarding() async => _prefs.getBool(_key) ?? false;

  @override
  Future<void> completeOnboarding() async => _prefs.setBool(_key, true);
}