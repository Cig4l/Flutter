import 'package:flutter/material.dart';
import 'package:nuage/domain/entities/task_category.dart';

const _emojiByName = <String, String>{
  'unknown': '✨', 
  'productivity': '🎯',
  'calm': '😌',
  'sleep': '😴',
  'selfKindness': '💗',
  'gratitude': '🙏',
  'nutrition': '🍎',
  'connection': '💞',
  'hygiene': '🪥',
};

const categoryCircleColor = Color(0xFFF8BBD0);

String categoryEmoji(TaskCategory c) => _emojiByName[c.name] ?? '✨';

String categoryLabel(TaskCategory c) {
  if (c.name == 'unknown') return 'Default';
  final spaced = c.name.replaceAllMapped(
    RegExp(r'(?<=[a-z])([A-Z])'),
    (m) => '-${m[1]!.toLowerCase()}',
  );
  return spaced[0].toUpperCase() + spaced.substring(1);
}