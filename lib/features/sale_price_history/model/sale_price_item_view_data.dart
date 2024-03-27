import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SalePriceItemViewData extends Equatable {
  final int id;
  final String date;
  final String salePrice;
  final String diffPrice;
  final Color color;

  const SalePriceItemViewData({
    required this.id,
    required this.date,
    required this.salePrice,
    required this.diffPrice,
    required this.color,
  });

  @override
  List<Object?> get props => [
        id
      ];
}
