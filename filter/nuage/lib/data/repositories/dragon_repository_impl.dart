import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nuage/domain/entities/dragon.dart';
import 'package:nuage/domain/repositories/dragon_repository.dart';
import 'package:nuage/data/mappers/dragon_mapper.dart';

class DragonRepositoryImpl implements DragonRepository {
  final SupabaseClient _client;
  static const _table = 'dragons';

  DragonRepositoryImpl(this._client);

  @override
  Future<bool> hasDragon() async {
    final row = await _client.from('dragons').select('id').maybeSingle();
    return row != null; // grâce à la RLS, on ne voit que SON dragon
  }

  @override
  Future<Dragon> getDragon() async {
    final data = await _client.from(_table).select().single();
    return DragonMapper.fromJson(data);
  }

  @override
  Future<void> createDragon(Dragon dragon) async {
    await _client.from(_table).insert(DragonMapper.toJson(dragon));
  }

  @override
  Future<void> updateDragon(Dragon dragon) async {
    await _client
        .from(_table)
        .update(DragonMapper.toJson(dragon))
        .eq('id', dragon.id);
  }
}
