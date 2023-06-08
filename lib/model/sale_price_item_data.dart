class SalePriceItemData {
  final String date;
  final String price;
  final String diffPrice;
  final bool isIncreased;

  SalePriceItemData(
      {required this.date,
      required this.price,
      required this.diffPrice,
      required this.isIncreased});
}
