import 'package:nuage/domain/entities/dragon.dart';

abstract interface class DragonRepository {
  Future<bool> hasDragon();
  Future<Dragon> getDragon();
  Future<void> createDragon(Dragon dragon);
  Future<void> updateDragon(Dragon dragon);
}
