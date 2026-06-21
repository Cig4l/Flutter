import 'package:flutter/material.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';
import 'package:nuage/presentation/widgets/pill_button_widget.dart';

class EvolvingDragonPage extends StatelessWidget {
  final VoidCallback onContinue;

  const EvolvingDragonPage({super.key, required this.onContinue});

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
                'Your dragon is evolving!', // TODO replace by name
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const Spacer(flex: 3),

              const Text(
                '?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 160,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0x33000000),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 4),

              SizedBox(
                width: double.infinity,
                child: PillButton(label: 'Next', onPressed: onContinue),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
