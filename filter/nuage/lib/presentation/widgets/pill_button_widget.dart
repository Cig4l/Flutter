import 'package:flutter/material.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';

class PillButton extends StatelessWidget {
  final String label;

  final VoidCallback? onPressed;

  final Color background;

  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.background = LevelUpUi.primaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: Colors.white,
          disabledBackgroundColor: background.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
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
        child: Text(label),
      ),
    );
  }
}