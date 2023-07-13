import 'package:petrol_ledger/model/sale.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/core/utils/extension.dart';

class SaleQuery {
  static const String _columns =
      '${Sale.tableName}.${Sale.columnCreatedAt}, ${Sale.columnAmount}, ${Sale.columnLiter}, ${SalePrice.columnPrice}, ${Sale.columnName}';

  static const String _foreginKey =
      '${Sale.tableName}.${Sale.columnSalePriceId} = ${SalePrice.tableName}.${SalePrice.columnId}';

  static String all() {
    return 'SELECT $_columns FROM ${Sale.tableName} LEFT JOIN ${SalePrice.tableName} ON $_foreginKey';
  }

  static String byDate(DateTime date) {
    return '${all()} WHERE ${getDateFilter(date)}';
  }

  static String getDateFilter(DateTime date) {
    final DateTime endDate = date.getDateLimit();
    return '${Sale.tableName}.${Sale.columnCreatedAt} >= ${date.millisecondsSinceEpoch} AND ${Sale.tableName}.${Sale.columnCreatedAt} <= ${endDate.millisecondsSinceEpoch}';
  }
}
