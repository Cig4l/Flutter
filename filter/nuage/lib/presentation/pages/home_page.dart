import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/task.dart';
import 'package:nuage/domain/entities/task_category.dart';
import 'package:nuage/presentation/pages/home_notifier.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------
class _C {
  static const banner = Color(0xFFF47B3D);
  static const background = Color(0xFFF6854B);
  static const card = Colors.white;
  static const title = Color(0xFF3D2B22);
  static const expText = Color(0xFF9E9E9E);
  static const amber = Color(0xFFFFC23C);
  static const fab = Color(0xFF4CAF50);
}

// ---------------------------------------------------------------------------
// Assets
// ---------------------------------------------------------------------------

String _backgroundAsset(Dragon dragon) {
  switch (dragon.level.index) {
    case 0:
      return 'assets/images/dragon/egg-bg.jpg';
    case 1:
      return 'assets/creatures/baby-bg.jpg';
    case 2:
      return 'assets/creatures/adult-bg.jpg';
    default:
      return 'assets/images/dragon/egg-bg.jpg';
  }
}

// ---------------------------------------------------------------------------
// Colors
// ---------------------------------------------------------------------------
const _categoryPalette = [
  Color(0xFFF48FB1),
  Color(0xFF5B9BD5),
  Color(0xFF81C784),
  Color(0xFFFFB74D),
  Color(0xFFBA68C8),
];

Color _categoryColor(TaskCategory c) =>
    _categoryPalette[c.index % _categoryPalette.length];

String _categoryLabel(TaskCategory c) {
  final spaced = c.name.replaceAllMapped(
    RegExp(r'(?<=[a-z])(?=[A-Z])'),
    (_) => ' ',
  );
  return spaced.toUpperCase();
}

// ---------------------------------------------------------------------------
// Page (ConsumerWidget => car read providers through `ref`)
// ---------------------------------------------------------------------------
class HomePage extends ConsumerWidget {
  /// Appelé par le bouton +. Branche-y ta navigation vers l'écran de création.
  final VoidCallback? onCreateTask;

  const HomePage({super.key, this.onCreateTask});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: _C.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _C.fab,
        elevation: 4,
        onPressed: onCreateTask,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: homeAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (error, stack) => _CenteredMessage(
          emoji: '😵',
          title: 'Impossible to load the creature',
          subtitle: '$error',
        ),
        data: (data) => SingleChildScrollView(
          child: Column(
            children: [
              _CreatureHeader(dragon: data.dragon),
              _GrowBanner(dragon: data.dragon),
              _TaskArea(data: data),
              const SizedBox(height: 88),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header : landscape + creature
// ---------------------------------------------------------------------------
class _CreatureHeader extends StatelessWidget {
  final Dragon dragon;

  const _CreatureHeader({required this.dragon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_backgroundAsset(dragon), fit: BoxFit.cover),
          Align(
            alignment: const Alignment(0, 0.55),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Banner "Help your creature to grow!" + exp gauge
// ---------------------------------------------------------------------------
class _GrowBanner extends StatelessWidget {
  final Dragon dragon;

  const _GrowBanner({required this.dragon});

  @override
  Widget build(BuildContext context) {
    final current = dragon.currentExp;
    final max = dragon.level.maxExp;
    final fraction = max == 0 ? 0.0 : (current / max).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      color: _C.banner,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Help your creature to grow!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.bolt, color: Colors.white, size: 34),
              const SizedBox(width: 10),
              Expanded(
                child: _ExpBar(fraction: fraction, label: '$current/$max'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpBar extends StatelessWidget {
  final double fraction;
  final String label;

  const _ExpBar({required this.fraction, required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 34,
        child: Stack(
          children: [
            Container(color: Colors.white),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(color: _C.amber),
            ),
            Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: _C.banner,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tasks Area
// ---------------------------------------------------------------------------
class _TaskArea extends StatelessWidget {
  final HomeData data;

  const _TaskArea({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.hasNoTasks) {
      return const _CenteredMessage(
        emoji: '🥚',
        title: 'No task for the moment',
        subtitle:
            'Press the + button to create a task and help your companion to grow',
      );
    }

    final grouped = data.groupedTasks;
    if (grouped.isEmpty) {
      return const _CenteredMessage(
        emoji: '🎉',
        title: 'All done!',
        subtitle: 'Your tasks will reappear tomorrow. Great job!',
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          for (final entry in grouped.entries)
            _CategorySection(category: entry.key, tasks: entry.value),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Category Section
// ---------------------------------------------------------------------------
class _CategorySection extends StatefulWidget {
  final TaskCategory category;
  final List<Task> tasks;

  const _CategorySection({required this.category, required this.tasks});

  @override
  State<_CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<_CategorySection> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Text(
                _categoryLabel(widget.category),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 2,
                  color: Colors.white.withOpacity(0.45),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_expanded)
          ...widget.tasks.map((t) => _DismissibleTaskCard(task: t)),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Task Card
// ---------------------------------------------------------------------------
class _DismissibleTaskCard extends ConsumerWidget {
  final Task task;

  const _DismissibleTaskCard({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accent = _categoryColor(task.category);
    void complete() => ref.read(homeProvider.notifier).completeTask(task);

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart, // swipe left
      onDismissed: (_) => complete(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
      ),
      child: _TaskCard(task: task, accent: accent, onComplete: complete),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final Color accent;
  final VoidCallback onComplete;

  const _TaskCard({
    required this.task,
    required this.accent,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.drag_indicator, color: Color(0xFFCFCFCF), size: 18),
          const SizedBox(width: 6),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.22),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                color: _C.title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '1',
            style: const TextStyle(
              color: _C.expText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 3),
          const Icon(Icons.bolt, color: _C.amber, size: 18),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onComplete,
            child: Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.16),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent, width: 2),
              ),
              child: Icon(Icons.check_rounded, color: accent, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Centered Message
// ---------------------------------------------------------------------------
class _CenteredMessage extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _CenteredMessage({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 280),
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
