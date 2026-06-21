import 'package:flutter/material.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/presentation/pages/evolved_dragon_page.dart';
import 'package:nuage/presentation/pages/evolving_dragon_page.dart';
import 'package:nuage/presentation/pages/hatched_dragon_page.dart';
import 'package:nuage/presentation/pages/hatching_page.dart';
import 'package:nuage/presentation/pages/naming_dragon_page.dart';
import 'package:nuage/presentation/stage/dragon_stage.dart';

void showLevelUpFlow(
  BuildContext context, {
  required Dragon from,
  required Dragon to,
  required void Function(String name) onRename, // callback name
}) {
  final isHatching = from.stage.isHatching;
  final intro = isHatching
      ? HatchingDragonPage(onHatched: () => _showHatchedDragon(context, onRename))
      : EvolvingDragonPage(onContinue: () => _showEvolvedDragon(context, to));
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => intro));
}

void _showHatchedDragon(
  BuildContext context,
  void Function(String name) onRename,
) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => HatchedDragonPage(
        onGreet: () => _showNamingDragon(context, onRename),
      ),
    ),
  );
}

void _showNamingDragon(
  BuildContext context,
  void Function(String name) onRename,
) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => NamingDragonPage(
        onSubmit: (name) {
          onRename(name);
          _goHome(context);
        },
      ),
    ),
  );
}

void _showEvolvedDragon(BuildContext context, Dragon dragon) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => EvolvedDragonPage(
        dragon: dragon,
        onBackToHome: () => _goHome(context),
      ),
    ),
  );
}

void _goHome(BuildContext context) {
  Navigator.of(context).pop();
}