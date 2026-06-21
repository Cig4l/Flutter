import 'package:flutter/material.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';
import 'package:nuage/presentation/stage/dragon_stage.dart';
import 'package:nuage/presentation/widgets/pill_button_widget.dart';

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
                child: PillButton( label: 'Go home with them', onPressed: onBackToHome),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
