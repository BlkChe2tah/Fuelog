import 'dart:io';

import 'package:petrol_ledger/storage/sale_data_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileStorage extends SaleDataStorage<File> {
  late final File _file;
  IOSink? _ioSink;

  Future<Directory?> _getDirectory() async {
    return Platform.isAndroid
        ? Directory('storage/emulated/0/Documents/Fuelog/')
        : await getApplicationDocumentsDirectory();
  }

  @override
  Future<void> create({required String fileName}) async {
    try {
      final dir = await _getDirectory();
      if (dir == null) {
        throw Exception("Couldn't find the directory in the system.");
      }
      var fileDir = await Directory(dir.path).create(recursive: true);
      _file = File(p.join(fileDir.path, fileName));
    } catch (e) {
      throw Exception("Something went wrong when creating the CSV file.");
    }
  }

  @override
  void write(String data) {
    _ioSink ??= _file.openWrite();
    _ioSink!.writeln(data);
  }

  @override
  void close() {
    _ioSink?.close();
  }
}
