import 'package:hive/hive.dart';

abstract class IHiveService {
  Future<void> put<T>({
    required String boxName,
    required String key,
    required T value,
  });

  Future<void> add<T>({required String boxName, required T value});

  Future<T?> get<T>({required String boxName, required String key});

  Future<List<T>> getAll<T>({required String boxName});

  Future<void> delete({required String boxName, required String key});

  Future<void> clear({required String boxName});
}

class HiveService implements IHiveService {
  @override
  Future<void> put<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, value);
  }

  @override
  Future<void> add<T>({required String boxName, required T value}) async {
    final box = await Hive.openBox<T>(boxName);
    await box.add(value);
  }

  @override
  Future<T?> get<T>({required String boxName, required String key}) async {
    final box = await Hive.openBox<T>(boxName);
    return box.get(key);
  }

  @override
  Future<List<T>> getAll<T>({required String boxName}) async {
    final box = await Hive.openBox<T>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> delete({required String boxName, required String key}) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clear({required String boxName}) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
