import 'dart:convert';

import 'package:flutter/material.dart';

class ProductRetriveModel {
  ProductRetriveModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.alert_quantity,
    required this.track_quantity,
    required this.second_name,
    required this.sale_item_id,
    required this.qty,
    required this.qtybase,
    required this.oqty,
    required this.tax_rate,
    required this.code,
    required this.type_tax,
    required this.product_type,
    required this.discount,
    required this.lastPrice,
    required this.item_tax,
    required this.tax_method,
    required this.valRet,
    required this.item_discount,
    required this.unit_price,
    required this.real_unit_price,
    required this.base_quantity,
    required this.base_unit,
    required this.rate,
    required this.unit,
    required this.base_unit_price,
  });

  String id,
      name,
      qtybase,
      rate,
      quantity,
      tax_method,
      product_type,
      price,
      type_tax,
      alert_quantity,
      track_quantity,
      second_name,
      sale_item_id,
      qty,
      oqty,
      discount,
      item_tax,
      item_discount,
      unit_price,
      unit,
      base_unit_price,
      base_unit,
      base_quantity,
      tax_rate,
      code,
      real_unit_price;
  int valRet;

  String lastPrice;

  factory ProductRetriveModel.fromJson(Map<String, dynamic> json) =>
      ProductRetriveModel(
        id: json['row']["id"].toString(),
        valRet: 0,
        lastPrice: '0',
        rate: json['tax_rate']['rate'].toString(),
        tax_rate: json['row']['tax_rate'].toString(),
        product_type: json['row']['type'].toString(),
        type_tax: json['tax_rate']['type'],
        name: json['row']['name'].toString(),
        quantity: json['row']['quantity'].toString(),
        price: json['row']['price'].toString(),
        alert_quantity: json['row']['alert_quantity'].toString(),
        track_quantity: json['row']['track_quantity'].toString(),
        second_name: json['row']['second_name'].toString(),
        sale_item_id: json['row']['sale_item_id'].toString(),
        qty: json['row']['qty'].toString(),
        oqty: json['row']['oqty'].toString(),
        qtybase: json['row']['qty'].toString(),
        item_tax: json['row']['item_tax'].toString(),
        discount: json['row']['discount'].toString(),
        unit: json['row']['unit'].toString(),
        item_discount: json['row']['item_discount'].toString(),
        unit_price: json['row']['unit_price'].toString(),
        base_unit_price: json['row']['base_unit_price'].toString(),
        tax_method: json['row']['tax_method'].toString(),
        base_unit: json['row']['base_unit'].toString(),
        base_quantity: json['row']['base_quantity'].toString(),
        real_unit_price: json['row']['real_unit_price'].toString(),
        code: json['row']['code'].toString(),
      );

  factory ProductRetriveModel.fromJsuon(Map<String, dynamic> json) {
    return ProductRetriveModel(
      id: json["id"].toString(),
      valRet: 0,
      lastPrice: json['lastPrice'],
      rate: json['rate'].toString(),
      tax_rate: json['tax_rate'].toString(),
      product_type: json['product_type'].toString(),
      type_tax: json['type'],
      name: json['name'].toString(),
      quantity: json['quantity'].toString(),
      price: json['price'].toString(),
      alert_quantity: json['alert_quantity'].toString(),
      track_quantity: json['track_quantity'].toString(),
      second_name: json['second_name'].toString(),
      sale_item_id: json['sale_item_id'].toString(),
      qty: json['qty'].toString(),
      qtybase: json['qty'].toString(),
      oqty: json['oqty'].toString(),
      item_tax: json['item_tax'].toString(),
      discount: json['discount'].toString(),
      unit: json['unit'].toString(),
      item_discount: json['item_discount'].toString(),
      unit_price: json['unit_price'].toString(),
      base_unit_price: json['base_unit_price'].toString(),
      tax_method: json['tax_method'].toString(),
      base_unit: json['base_unit'].toString(),
      base_quantity: json['base_quantity'].toString(),
      real_unit_price: json['real_unit_price'].toString(),
      code: json['code'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "tax_method": tax_method,
        "rate": rate,
        "code": code,
        "name": name,
        "quantity": quantity,
        "lastPrice": lastPrice,
        "valRet": valRet,
        "price": price,
        "alert_quantity": alert_quantity,
        "track_quantity": track_quantity,
        "second_name": second_name,
        "sale_item_id": sale_item_id,
        "qty": qty,
        "qtybase": qtybase,
        "oqty": oqty,
        "product_type": product_type,
        "item_tax": item_tax,
        "discount": discount,
        "item_discount": item_discount,
        "unit_price": unit_price,
        "base_unit_price": base_unit_price,
        "base_unit": base_unit,
        "tax_rate": tax_rate,
        "base_quantity": base_quantity,
        "real_unit_price": real_unit_price,
    "type":type_tax,
    "unit":unit


      };

  static Map<String, dynamic> toMap(ProductRetriveModel music) => {
        "id": music.id,
        "tax_method": music.tax_method,
        "rate": music.rate,
        "code": music.code,
        "name": music.name,
        "quantity": music.quantity,
        "lastPrice": music.lastPrice,
        "valRet": music.valRet,
        "price": music.price,
        "alert_quantity": music.alert_quantity,
        "track_quantity": music.track_quantity,
        "second_name": music.second_name,
        "sale_item_id": music.sale_item_id,
        "qty": music.qty,
        "qtybase": music.qtybase,
        "oqty": music.oqty,
        "product_type": music.product_type,
        "item_tax": music.item_tax,
        "discount": music.discount,
        "item_discount": music.item_discount,
        "unit_price": music.unit_price,
        "base_unit_price": music.base_unit_price,
        "base_unit": music.base_unit,
        "tax_rate": music.tax_rate,
        "base_quantity": music.base_quantity,
        "real_unit_price": music.real_unit_price,
    "type":music.type_tax,
    "unit":music.unit
      };

  static String encode(List<ProductRetriveModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>(
                (music) => ProductRetriveModel.toMap(music))
            .toList(),
      );

  static List<ProductRetriveModel> decode(String musics) => (json.decode(musics)
          as List<dynamic>)
      .map<ProductRetriveModel>((item) => ProductRetriveModel.fromJson(item))
      .toList();
}
