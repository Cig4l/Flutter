import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nuage/core/app_images.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';
import 'package:nuage/presentation/widgets/pill_button_widget.dart';

class HatchingDragonPage extends StatefulWidget {
  final VoidCallback? onHatched; // next => meet the baby dragon

  final int tapsToHatch;

  const HatchingDragonPage({super.key, this.onHatched, this.tapsToHatch = 3});

  @override
  State<HatchingDragonPage> createState() => _HatchingPageState();
}

class _HatchingPageState extends State<HatchingDragonPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shake;
  int _taps = 0;
  bool _hatched = false;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  void _help() {
    if (_hatched) return;

    _shake.forward(from: 0); // egg trembles when tapped
    setState(() => _taps++);

    if (_taps >= widget.tapsToHatch) {
      _hatched = true;
      widget.onHatched?.call();
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
              const Spacer(flex: 2),
              const Text(
                'Your egg is hatching!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const Spacer(flex: 2),

              GestureDetector(
                onTap: _help,
                child: AnimatedBuilder(
                  animation: _shake,
                  builder: (context, child) {
                    // right-left shaking egg
                    final angle =
                        sin(_shake.value * pi * 4) * (1 - _shake.value) * 0.12;
                    return Transform.rotate(angle: angle, child: child);
                  },
                  child: Image.asset(AppImages.crackedEgg, height: 240),
                ),
              ),

              const Spacer(flex: 3),

              SizedBox(
                width: double.infinity,
                child: PillButton(label: 'Tap to help it', onPressed: _help),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
