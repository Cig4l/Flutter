import 'package:flutter/material.dart';
import 'package:nuage/core/app_images.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';

class HatchedDragonPage extends StatelessWidget {
  final VoidCallback onGreet;

  const HatchedDragonPage({super.key, required this.onGreet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LevelUpUi.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const Text(
                'You hatched a baby dragon!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const Spacer(flex: 2),

              Image.asset(AppImages.dragon.baby, height: 260),

              const Spacer(flex: 3),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onGreet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LevelUpUi.primaryButton,
                    foregroundColor: Colors.white,
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
                  child: const Text('Greet them'),
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