import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/core/dragon_repository_provider.dart';
import 'package:nuage/presentation/pages/home_page.dart';
import 'package:nuage/presentation/pages/onboarding_page.dart';
import 'package:nuage/presentation/themes/start_ui.dart';
import 'package:nuage/presentation/widgets/dragon_avatar.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  Future<void> _onStartPressed(BuildContext context, WidgetRef ref) async {
    final hasDragon = await ref.read(dragonRepositoryProvider).hasDragon();

    if (!context.mounted) return;

    if (!context.mounted) return;
    if (hasDragon) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const OnboardingPage()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: StartUi.launchBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              const DragonAvatar(size: 200),
              const SizedBox(height: 36),
              const Text(
                'Nuage',
                style: TextStyle(
                  color: StartUi.titleText,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your self-care companions',
                style: TextStyle(
                  color: StartUi.subtitleText,
                  fontSize: 18,
                ),
              ),
              const Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onStartPressed(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StartUi.buttonBackground,
                    foregroundColor: StartUi.buttonText,
                    minimumSize: const Size.fromHeight(60),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Start'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'By using the app, you agree to the\nTerms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(color: StartUi.footerText, fontSize: 13),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
