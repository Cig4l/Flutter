import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuage/presentation/controllers/onboarding_controller.dart';
import 'package:nuage/presentation/themes/app_colors.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  Future<void> _onStartPressed(BuildContext context, WidgetRef ref) async {
    await ref.read(onboardingRepositoryProvider).completeOnboarding();
    if (!context.mounted) return;
    // TODO: enchaîner sur l'écran d'éclosion de l'œuf
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.launchBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Hello, adventurer! 🐉',
                          style: TextStyle(
                            color: AppColors.startTitleText,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'An egg has been entrusted to you. Complete your '
                          'tasks to nurture the creature growing inside, and '
                          'soon it will hatch into your very own companion.',
                          style: TextStyle(
                            color: AppColors.startSubtitleText,
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Image.asset(
                            'assets/images/dragon/egg.png',
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onStartPressed(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.startButtonBackground,
                    foregroundColor: AppColors.startButtonText,
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
                  child: const Text('Start the adventure'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
