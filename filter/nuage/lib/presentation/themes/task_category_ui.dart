import 'package:flutter/material.dart';
import 'package:nuage/domain/entities/task_category.dart';

class TaskCategoryUi {
  static const categoryPalette = [
    Color.fromARGB(255, 142, 142, 142),
    Color(0xFFFFB74D),
    Color.fromARGB(255, 74, 169, 153),
    Color(0xFF5B9BD5),
    Color.fromARGB(255, 176, 98, 255),
    Color.fromARGB(255, 215, 97, 182),
    Color.fromARGB(255, 91, 168, 95),
    Color.fromARGB(255, 152, 83, 255),
    Color.fromARGB(255, 93, 91, 213),
    Color.fromARGB(255, 223, 121, 48),
    Color.fromARGB(255, 220, 120, 120),
    Color.fromARGB(255, 217, 190, 11),
  ];

  static const emojiByName = <String, String>{
    'unknown': '✨',
    'productivity': '🎯',
    'calm': '😌',
    'sleep': '😴',
    'selfKindness': '💗',
    'gratitude': '🙏',
    'nutrition': '🍎',
    'connection': '💞',
    'hygiene': '🪥',
    'housework': '🧹',
    'pets': '🐶',
    'sports': '🏀',
  };

  static String categoryEmoji(TaskCategory c) => emojiByName[c.name] ?? '✨';

  static String categoryLabel(TaskCategory c) {
    if (c.name == 'unknown') return 'Default';
    final spaced = c.name.replaceAllMapped(
      RegExp(r'(?<=[a-z])([A-Z])'),
      (m) => '-${m[1]!.toLowerCase()}',
    );
    return spaced[0].toUpperCase() + spaced.substring(1);
  }
}
