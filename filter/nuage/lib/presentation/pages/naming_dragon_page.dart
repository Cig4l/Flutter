import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nuage/core/app_images.dart';
import 'package:nuage/presentation/themes/level_up_ui.dart';

class NamingDragonPage extends StatefulWidget {
  final void Function(String name) onSubmit;

  const NamingDragonPage({super.key, required this.onSubmit});

  @override
  State<NamingDragonPage> createState() => _NameDragonPageState();
}

class _NameDragonPageState extends State<NamingDragonPage> {  // TODO notifier ajout nom
  static const _randomNames = [
    'Téméraire',
    'Smaug',
    'Mushu',
    'Shenron',
    'Thorn',
    'Fafnir',
    'Klauth',
    'Tiamat',
    'Meleys',
  ];

  final _controller = TextEditingController();
  final _random = Random();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit => _controller.text.trim().isNotEmpty;

  

  void _pickRandom() {
    final name = _randomNames[_random.nextInt(_randomNames.length)];
    _controller.text = name;
    _controller.selection = TextSelection.collapsed(offset: name.length);
    setState(() {});
  }

  void _submit() {
    if (!_canSubmit) return;
    widget.onSubmit(_controller.text.trim());
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
                'The dragon likes you!\nThey want you to give them a name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const Spacer(flex: 2),


              SizedBox(
                height: 240,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppImages.dragon.baby,
                      height: 220,
                    ),
                    const Positioned(
                      top: 4,
                      right: 70,
                      child: _HeartBubble(),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              TextField(
                controller: _controller,
                onChanged: (_) => setState(() {}),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Please enter...',
                  hintStyle: const TextStyle(color: Color(0xFF8A8D99)),
                  filled: true,
                  fillColor: LevelUpUi.fieldFill,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const Spacer(flex: 3),

              Row(
                children: [
                  Expanded(
                    child: _PillButton(
                      label: 'Random',
                      background: LevelUpUi.secondaryButton,
                      onPressed: _pickRandom,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PillButton(
                      label: 'Next',
                      background: LevelUpUi.primaryButton,
                      onPressed: _canSubmit ? _submit : null, // null = disabled
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final Color background;
  final VoidCallback? onPressed;

  const _PillButton({
    required this.label,
    required this.background,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFF8E9AD8),
        disabledForegroundColor: Colors.white70,
        minimumSize: const Size.fromHeight(60),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: Text(label),
    );
  }
}

class _HeartBubble extends StatelessWidget {
  const _HeartBubble();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.favorite,
            color: Color(0xFFE53935),
            size: 22,
          ),
        ),
        SizedBox(
          width: 16,
          height: 9,
          child: CustomPaint(painter: _TailPainter()),
        ),
      ],
    );
  }
}

class _TailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}