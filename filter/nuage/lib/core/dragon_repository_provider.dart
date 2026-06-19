import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:nuage/domain/repositories/dragon_repository.dart';
import 'package:nuage/data/repositories/dragon_repository_impl.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final dragonRepositoryProvider = Provider<DragonRepository>((ref) {
  return DragonRepositoryImpl(ref.read(supabaseClientProvider));
});