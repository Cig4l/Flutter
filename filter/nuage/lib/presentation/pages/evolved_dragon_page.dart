import 'package:flutter/material.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';
import 'package:nuage/presentation/stage/dragon_stage.dart';

class EvolvedDragonPage extends StatelessWidget {
  final Dragon dragon;
  final VoidCallback onBackToHome;

  const EvolvedDragonPage({
    super.key,
    required this.dragon,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LevelUpUi.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'Thanks to your efforts,\n ${dragon.name} has grown up!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    dragon.stage.dragonAsset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onBackToHome,
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
                  child: const Text('Go home with them'),
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
