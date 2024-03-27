import 'dart:async';
import 'dart:io';

import 'package:petrol_ledger/core/filte_storage/storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileStorage extends Storage<File> {
  @override
  String get defaultFileName => "${DateTime.now().millisecondsSinceEpoch}.csv";

  Future<Directory?> _getStorageDir() async {
    return Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
  }

  @override
  Future<File> create({required String fileName}) async {
    try {
      final dir = await _getStorageDir();
      if (dir == null) {
        throw Exception("Couldn't find the directory in the system.");
      }
      final csvStorageDir = Directory(p.join(dir.path, "CSV", fileName));
      if (!(await csvStorageDir.exists())) {
        await csvStorageDir.create(recursive: true);
      }
      return File(csvStorageDir.path);
    } catch (e) {
      throw Exception("Couldn't create the file in the system.");
    }
  }
}
