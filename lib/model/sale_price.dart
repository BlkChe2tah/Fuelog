class SalePrice {
  static const String tableName = 'sale_prices';
  static const String columnId = 'id';
  static const String columnPrice = 'price';
  static const String columnCreatedAt = 'created_at';

  final int? id;
  final int price;
  final int createdAt;

  SalePrice({
    this.id,
    required this.price,
    required this.createdAt,
  });

  static Map<String, dynamic> toMap(SalePrice salePrice) {
    return {
      SalePrice.columnId: salePrice.id,
      SalePrice.columnPrice: salePrice.price,
      SalePrice.columnCreatedAt: salePrice.createdAt,
    };
  }

  static SalePrice fromMap(Map<String, dynamic> data) {
    return SalePrice(
      id: data[SalePrice.columnId],
      price: data[SalePrice.columnPrice],
      createdAt: data[SalePrice.columnCreatedAt],
    );
  }

  @override
  String toString() {
    return 'SalePrice{${SalePrice.columnId}: $id, ${SalePrice.columnPrice}: $price, ${SalePrice.columnCreatedAt}: $createdAt}';
  }
}
