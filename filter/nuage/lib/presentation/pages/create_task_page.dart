import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nuage/domain/entities/task_category.dart';
import 'package:nuage/presentation/pages/home_notifier.dart';
import 'package:nuage/presentation/themes/create_task_ui.dart';
import 'package:nuage/presentation/themes/task_category_ui.dart';

class CreateTaskPage extends ConsumerStatefulWidget {
  const CreateTaskPage({super.key});

  @override
  ConsumerState<CreateTaskPage> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends ConsumerState<CreateTaskPage> {
  final _titleController = TextEditingController();

  late TaskCategory _selected = TaskCategory.values.firstWhere(
    (category) => category.name == 'unknown',
    orElse: () => TaskCategory.values.first,
  );

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _create() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    ref.read(homeProvider.notifier).addTask(title: title, category: _selected);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: CreateTaskUi.sheetBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête : titre + bouton fermer
              Row(
                children: [
                  const Text(
                    'Create A Task',
                    style: TextStyle(
                      color: CreateTaskUi.title,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: CreateTaskUi.pink,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Champ "Enter a new goal..."
              TextField(
                controller: _titleController,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _create(),
                decoration: InputDecoration(
                  hintText: 'Enter a new goal...',
                  hintStyle: const TextStyle(color: CreateTaskUi.hint),
                  filled: true,
                  fillColor: CreateTaskUi.card,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Choose a category',
                style: TextStyle(
                  color: CreateTaskUi.title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Liste des catégories (construite à partir de l'enum)
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    for (final category in TaskCategory.values)
                      _CategoryTile(
                        category: category,
                        selected: category == _selected,
                        onTap: () => setState(() => _selected = category),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _titleController,
                builder: (context, value, _) {
                  final canSave = value.text.trim().isNotEmpty;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: canSave
                          ? _create
                          : null, // null = disabled button
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CreateTaskUi.pink,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: CreateTaskUi.pink.withValues(alpha: 0.4),
                        disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
                        minimumSize: const Size.fromHeight(56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Create task'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final TaskCategory category;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: CreateTaskUi.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? CreateTaskUi.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: CreateTaskUi.categoryCircleColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                TaskCategoryUi.categoryEmoji(category),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                TaskCategoryUi.categoryLabel(category),
                style: const TextStyle(
                  color: CreateTaskUi.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (selected)
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: CreateTaskUi.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
