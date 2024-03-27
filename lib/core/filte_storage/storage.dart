abstract class Storage<T> {
  Future<T> create({required String fileName});
  String get defaultFileName;
}
