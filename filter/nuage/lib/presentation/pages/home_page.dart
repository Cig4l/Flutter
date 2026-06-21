import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/entities/task.dart';
import 'package:nuage/domain/entities/task_category.dart';
import 'package:nuage/presentation/pages/create_task_page.dart';
import 'package:nuage/presentation/pages/home_notifier.dart';
import 'package:nuage/presentation/pages/update_task_page.dart';
import 'package:nuage/presentation/themes/home_ui.dart';
import 'package:nuage/presentation/themes/task_category_ui.dart';

// ---------------------------------------------------------------------------
// Dragon Assets
// ---------------------------------------------------------------------------
String _backgroundAsset(Dragon dragon) {
  switch (dragon.level.index) {
    case 0:
      return 'assets/images/dragon/egg-bg.jpg';
    case 1:
      return 'assets/dragon/baby-bg.jpg';
    case 2:
      return 'assets/dragon/teen-bg.jpg';
    case 3:
      return 'assets/dragon/adult-bg.jpg';
    default:
      return 'assets/images/dragon/egg-bg.jpg';
  }
}

Color CategoryColor(TaskCategory c) =>
    TaskCategoryUi.categoryPalette[c.index % TaskCategoryUi.categoryPalette.length];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: HomeUi.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: HomeUi.fab,
        elevation: 4,
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const CreateTaskPage(),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: homeAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (_, __) => const HomeUienteredMessage(
          emoji: '😵',
          title: 'Impossible to load your creature',
          subtitle: 'Check your connection and try again.',
        ),
        data: (data) => SingleChildScrollView(
          child: Column(
            children: [
              HomeUireatureHeader(dragon: data.dragon),
              _GrowBanner(dragon: data.dragon),
              _TaskArea(data: data),
              const SizedBox(height: 88), // space for FAB
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------
class HomeUireatureHeader extends StatelessWidget {
  final Dragon dragon;

  const HomeUireatureHeader({required this.dragon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_backgroundAsset(dragon), fit: BoxFit.cover),
          Align(alignment: const Alignment(0, 0.55)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Banner
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
      color: HomeUi.banner,
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
              child: Container(color: HomeUi.amber),
            ),
            Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: HomeUi.banner,
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
// Task Area
// ---------------------------------------------------------------------------
class _TaskArea extends StatelessWidget {
  final HomeData data;

  const _TaskArea({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.hasNoTasks) {
      return const HomeUienteredMessage(
        emoji: '🥚',
        title: 'Nothing to do for the moment',
        subtitle:
            'Press on + to create your fist task and help your creature to grow.',
      );
    }

    final grouped = data.groupedTasks;
    if (grouped.isEmpty) {
      return const HomeUienteredMessage(
        emoji: '🎉',
        title: 'All done!',
        subtitle: 'Your tasks will spawn again tomorrow. Great job!',
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          for (final entry in grouped.entries)
            HomeUiategorySection(category: entry.key, tasks: entry.value),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Category Section
// ---------------------------------------------------------------------------
class HomeUiategorySection extends StatefulWidget {
  final TaskCategory category;
  final List<Task> tasks;

  const HomeUiategorySection({required this.category, required this.tasks});

  @override
  State<HomeUiategorySection> createState() => HomeUiategorySectionState();
}

class HomeUiategorySectionState extends State<HomeUiategorySection> {
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
                TaskCategoryUi.categoryLabel(widget.category).toUpperCase(),
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
    final accent = CategoryColor(task.category);
    void complete() => ref.read(homeProvider.notifier).completeTask(task);

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart, // swipe vers la gauche
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
      child: GestureDetector(
        onLongPress: () => _showTaskOptions(context, ref),
        child: _TaskCard(task: task, accent: accent, onComplete: complete),
      ),
    );
  }

  void _showTaskOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit'),
              onTap: () {
                Navigator.of(sheetContext).pop(); // closes menu
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => UpdateTaskPage(task: task),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(sheetContext).pop();
                ref.read(homeProvider.notifier).deleteTask(task);
              },
            ),
          ],
        ),
      ),
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
        color: HomeUi.card,
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
          // Pastille : emoji dérivé de la catégorie (plus de task.icon)
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.22),
              shape: BoxShape.circle,
            ),
            child: Text(
              TaskCategoryUi.categoryEmoji(task.category),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              style: const TextStyle(
                color: HomeUi.title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
class HomeUienteredMessage extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const HomeUienteredMessage({
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
