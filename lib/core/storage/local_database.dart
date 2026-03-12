import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'isar_game.dart';

class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  late final Isar isar;

  Future<void> init() async {
    if (_initialized) return;
    final directory = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [IsarGameSchema],
      directory: directory.path,
    );
    _initialized = true;
  }

  bool _initialized = false;
}
