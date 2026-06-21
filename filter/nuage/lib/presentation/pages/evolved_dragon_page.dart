import 'package:flutter/material.dart';
import 'package:nuage/core/app_images.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/level.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';

class EvolvedDragonPage extends StatelessWidget {
  final Dragon dragon;
  final VoidCallback onBackToHome;

  const EvolvedDragonPage({
    super.key,
    required this.dragon,
    required this.onBackToHome,
  });

  String _dragonAsset(Level level) {
  switch (level.index) {
    case 0:
      return AppImages.dragon.egg;
    case 1:
      return AppImages.dragon.baby;
    case 2:
      return AppImages.dragon.teen;
    case 3:
      return AppImages.dragon.adult;
    default:
      return AppImages.dragon.egg;
  }
}

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
                  child: Image.asset(_dragonAsset(dragon.level), fit: BoxFit.contain),
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