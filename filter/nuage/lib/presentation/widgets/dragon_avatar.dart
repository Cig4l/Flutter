// lib/features/welcome/presentation/widgets/dragon_avatar.dart
import 'package:flutter/material.dart';

class DragonAvatar extends StatelessWidget {
  const DragonAvatar({super.key, this.size = 200});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.transparent,
        backgroundImage: const AssetImage('assets/images/dragon-avatar.jpg'),
      ),
    );
  }
}