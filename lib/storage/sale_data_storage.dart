abstract class SaleDataStorage<T> {
  Future<void> create({required String fileName});
  void write(String data);
  void close();
}
