# 🐉 Nuage

**Nuage** est une application de productivité *gamifiée* : on adopte un mystérieux œuf, et chaque tâche du quotidien accomplie lui fait gagner de l'expérience. À force de tâches, l'œuf éclôt en dragon, puis le dragon grandit (bébé → ado → adulte).

**Application 100 % gratuite.**

---

## 🎨 Design (Figma)

Maquettes du projet :
👉 [Figma — Flutter / Nuage](https://www.figma.com/design/YvtskiQeoB3O1ieW71dQct/Flutter?node-id=0-1&m=dev&t=fKT69ruHqE4HG5m9-1)

---

## 🛠️ Stack technique

| Couche | Technologie |
|---|---|
| Framework | **Flutter** (Dart 3) |
| Backend / BDD / Auth | **Supabase** (PostgreSQL + Auth anonyme + RLS) |
| State management & DI | **Riverpod** |
| Architecture | **Clean Architecture** (domain / data / presentation + core) |

---

## ▶️ Lancer le projet

L'app est pensée pour un format mobile (ratio iPhone). On la lance dans Chrome puis on simule un appareil.

```bash
cd filter/nuage
flutter run -d chrome -t lib/app/main.dart
```

Une fois Chrome ouvert :

1. Ouvrir les **DevTools** : `F12`
2. Activer la **toolbar appareil** : icône *Toggle device toolbar* (`Ctrl + Shift + M`)
3. Dans le menu **Devices**, sélectionner **iPhone 14 Pro Max**

L'application s'affiche alors au bon format.

---

## 🏛️ Architecture (Clean Architecture)

Le code respecte une séparation stricte en couches. La règle de dépendance est toujours dirigée vers le **domaine** : `presentation → domain ← data`, le dossier `core/` se chargeant de câbler le tout via Riverpod.

```
lib/
├── app/
│   └── main.dart                          # Point d'entrée + initialisation Supabase
│
├── core/                                  # Injection de dépendances (providers Riverpod)
│   ├── providers.dart                     # Barrel export des providers
│   ├── supabase_client_provider.dart
│   ├── task_repository_provider.dart
│   ├── dragon_repository_provider.dart
│   ├── complete_task_usecase_provider.dart
│   └── app_images.dart                    # Référencement centralisé des assets
│
├── domain/                                # ❤️ Cœur métier — Dart pur (zéro dépendance Flutter/Supabase)
│   ├── entities/
│   │   ├── dragon.dart                    # Entité Dragon (+ logique gainExp / level up)
│   │   ├── level.dart                     # Enum des niveaux (one → four)
│   │   ├── task.dart
│   │   └── task_category.dart
│   ├── repositories/                      # Interfaces (ports) — contrats abstraits
│   │   ├── task_repository.dart
│   │   ├── dragon_repository.dart
│   │   └── auth_repository.dart
│   └── usecases/
│       └── complete_task_usecase.dart     # Règle métier : compléter une tâche → gagner de l'exp
│
├── data/                                  # Implémentations concrètes (liées à Supabase)
│   ├── mappers/
│   │   ├── dragon_mapper.dart             # JSON Supabase ↔ entité Dragon
│   │   └── task_mapper.dart
│   └── repositories/
│       ├── task_repository_impl.dart
│       ├── dragon_repository_impl.dart
│       └── auth_repository_impl.dart
│
└── presentation/                          # 🖼️ UI (pages, état d'UI, navigation, thèmes)
    ├── pages/
    │   ├── start_page.dart
    │   ├── onboarding_page.dart
    │   ├── home_page.dart
    │   ├── home_notifier.dart             # AsyncNotifier Riverpod (état de l'écran d'accueil)
    │   ├── create_task_page.dart
    │   ├── update_task_page.dart
    │   ├── hatching_page.dart             # Éclosion de l'œuf
    │   ├── hatched_dragon_page.dart
    │   ├── naming_dragon_page.dart        # On nomme son dragon
    │   ├── evolving_dragon_page.dart      # Animation de montée de niveau
    │   └── evolved_dragon_page.dart
    ├── stage/
    │   └── dragon_stage.dart              # 🎯 Pattern State (stades de vie du dragon)
    ├── navigation/
    │   └── show_levelup_flow.dart         # Orchestration du flow d'évolution
    └── themes/
        ├── home_ui.dart
        ├── start_ui.dart
        ├── create_task_ui.dart
        ├── level_up_ui.dart
        └── task_category_ui.dart
    └── widgets/
        └── pill_button_widget.dart
```

**Pourquoi cette découpe ?**
- `domain/` ne connaît ni Flutter ni Supabase → il est testable de façon isolée et reste stable même si l'on change de backend ou d'UI.
- `data/` est la seule couche qui « sait » que les données viennent de Supabase.
- `presentation/` ne dépend que d'abstractions du domaine.
- `core/` injecte les implémentations dans ces abstractions au démarrage.

---

## 🧩 Design patterns

Le projet met en œuvre plusieurs patterns. Les deux **principaux** sont des patterns **GoF** réellement implémentés à la main ; deux patterns architecturaux complètent l'ensemble.

### 1. State — *(GoF, comportemental)* — `presentation/stage/dragon_stage.dart`

**Le contexte.** Le dragon est littéralement une machine à états : **œuf → bébé → ado → adulte**. Chaque stade a une apparence différente (fond d'écran, sprite du dragon, libellé) et un comportement différent (seul le stade « œuf » déclenche une *éclosion*).

**Le problème évité.** Sans pattern, cette logique « niveau → apparence » se retrouve dupliquée dans plusieurs `switch` éparpillés (le fond dans la page d'accueil, le visuel du dragon ailleurs, le cas particulier de l'éclosion dans la navigation). Difficile à maintenir et source de bugs.

**Mon implémentation.** Une `sealed class DragonStage` définit le contrat, et **chaque stade est une classe concrète** qui encapsule son propre rendu et son comportement :

```dart
sealed class DragonStage {
  String get backgroundAsset;
  String get dragonAsset;
  String get label;
  bool get isHatching => false;
}

final class EggStage extends DragonStage {
  @override String get dragonAsset => AppImages.dragon.egg;
  @override String get label => 'Egg';
  @override bool get isHatching => true;          // seul l'œuf éclôt
}

final class BabyStage  extends DragonStage { /* ... */ }
final class TeenStage  extends DragonStage { /* ... */ }
final class AdultStage extends DragonStage { /* ... */ }

// Transition d'état pilotée par le niveau (switch exhaustif)
extension LevelStage on Level {
  DragonStage get stage => switch (this) {
    Level.one   => const EggStage(),
    Level.two   => const BabyStage(),
    Level.three => const TeenStage(),
    Level.four  => const AdultStage(),
  };
}

// Raccourci : dragon.stage.backgroundAsset
extension DragonStageX on Dragon {
  DragonStage get stage => level.stage;
}
```

**En quoi c'est pertinent.**
- **Une seule source de vérité** : toute l'UID lit désormais `dragon.stage.xxx`, plus aucune duplication.
- **Ouvert/fermé (OCP)** : ajouter un stade = ajouter une classe, sans modifier le code existant.
- **Sûreté à la compilation** : grâce au `sealed` + `switch` exhaustif, oublier un stade ne compile pas.

---

### 2. Factory Method — *(GoF, créationnel)* — entités & mappers

**Mon implémentation.** Le pattern est utilisé via les **constructeurs `factory`** de Dart à deux endroits clés :

```dart
// 1) Créer un dragon « neuf » sans exposer son assemblage interne
factory Dragon.initial({required String dragonId}) => Dragon(
  id: dragonId, name: '', level: Level.one, currentExp: 0,
);

// 2) Construire une entité du domaine à partir d'une ligne JSON Supabase
class DragonMapper {
  static Dragon fromJson(Map<String, dynamic> json) => Dragon(
    id: json['id'] as String,
    name: json['name'] as String? ?? '',
    level: Level.values.byName(json['level'] as String),
    currentExp: json['current_exp'] as int? ?? 0,   // snake_case BDD → camelCase métier
  );
}
```

**En quoi c'est pertinent.**
- **Découplage** : l'appelant demande « un dragon initial » ou « un dragon depuis ce JSON » sans connaître le détail de construction.
- **Nommage intentionnel** : `Dragon.initial(...)` est bien plus lisible qu'un constructeur surchargé.
- **Frontière propre** : le mapper traduit le format brut de la base (`current_exp`) vers le modèle métier (`currentExp`), évitant toute fuite de la forme des données dans le domaine.

---

### Patterns architecturaux complémentaires

**Repository** *(Fowler / DDD)* — `domain/repositories/*` (ports) + `data/repositories/*` (implémentations).
Le domaine définit des **interfaces abstraites** (`TaskRepository`, `DragonRepository`, `AuthRepository`) ; la couche data les implémente avec Supabase (`TaskRepositoryImpl`…). Résultat : l'UI et le métier ignorent totalement Supabase — on pourrait basculer sur une API REST ou une base locale sans toucher au reste. C'est la **colonne vertébrale** de l'architecture.

**Data Mapper + Dependency Injection.**
Les *mappers* isolent la traduction JSON ↔ entités. L'injection de dépendances est assurée par les providers de `core/` (ex. `completeTaskUseCaseProvider` reçoit les deux repositories).

Riverpod fournit nativement le conteneur de **Dependency Injection** ainsi que le mécanisme **Observer** (`ref.watch` / `ref.listen`, utilisé ici pour déclencher l'écran d'évolution quand le niveau du dragon change). Ces deux patterns sont donc *consommés via le framework* plutôt qu'implémentés à la main.
