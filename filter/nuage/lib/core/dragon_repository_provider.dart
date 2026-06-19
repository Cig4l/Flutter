import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nuage/domain/repositories/dragon_repository.dart';
import 'package:nuage/data/repositories/dragon_repository_impl.dart';
import 'package:nuage/core/providers.dart';

final dragonRepositoryProvider = Provider<DragonRepository>((ref) {
  return DragonRepositoryImpl(ref.read(supabaseClientProvider));
});
