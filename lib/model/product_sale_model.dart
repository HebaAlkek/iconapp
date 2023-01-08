import 'package:flutter/material.dart';

class ProductSaleModel {
  String product_name,second_name,id;
  String net_unit_price, quantity, tax, item_tax, subtotal;

  ProductSaleModel({
    required this.product_name,
    required this.net_unit_price,
    required this.quantity,required this.id,
    required this.tax,
    required this.subtotal,
    required this.item_tax,required this.second_name
  });

  factory ProductSaleModel.fromJson(Map<String, dynamic> json) {
    return ProductSaleModel(
      product_name: json['product_name'].toString(),
      second_name: json['second_name'].toString(),
      id: json['id'].toString(),

      net_unit_price: json['net_unit_price'].toString(),
      quantity: json['quantity'].toString(),
      tax: json['tax'].toString(),
      subtotal: json['subtotal'].toString(),
      item_tax: json['item_tax'].toString(),
    );
  }
}
