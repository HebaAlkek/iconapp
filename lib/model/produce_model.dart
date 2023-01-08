import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/unit_model.dart';

class ProductModdelList {
  String id;
  String name,
      second_name,
      code,
      image_url,
      net_price,
      net_price_sel,
      slug,
      tax_method,
      unit_price,
      type,
      price;
  bool select = false;
  int quantity = 0;
  int quantitySel = 1;
  final GlobalKey imageGlobalKey = GlobalKey();
  TextEditingController quanText = TextEditingController();

  final CategoryModelList mainCat;
  final BrandModelList brandItem;
  final UnitModelList unitItem;
  final TaxModelList texes;

  ProductModdelList(
      {required this.name,
      required this.unitItem,
      required this.price,
      required this.texes,
      required this.net_price_sel,
      required this.brandItem,
      required this.mainCat,
      required this.quantity,
      required this.id,
      required this.code,
      required this.slug,
      required this.image_url,
      required this.net_price,
      required this.tax_method,
      required this.unit_price,
      required this.second_name,
      required this.type});

  factory ProductModdelList.fromJson(Map<String, dynamic> json) {
    return ProductModdelList(
        name: json['name'].toString(),
        id: json['id'].toString(),
        type: json['type'].toString(),
        price: json['price'].toString(),
        second_name: json['second_name'].toString(),
        code: json['code'].toString(),
        image_url: json['image_url'].toString(),
        net_price: json['net_price'].toString(),
        net_price_sel: json['net_price'].toString(),
        slug: json['slug'].toString(),
        brandItem: json['brand'] != null
            ? BrandModelList.fromJson(json['brand'])
            : BrandModelList(
                name: '',
                id: '',
                code: '',    imgfile:Uint8List(0),
                slug: '',
                description: '',
                image: ''),
        unitItem: json['unit'] != null
            ? UnitModelList.fromJson(json['unit'])
            : UnitModelList(
                code: '',
                id: '',
                name: '',
                unit_value: '',
                operator: '',
                operation_value: '',
                base_unit: ''),
        texes: json['tax_rate'] != null
            ? TaxModelList.fromJson(json['tax_rate'])
            : TaxModelList(name: '', id: '', code: '', rate: '', type: ''),
        mainCat: json['category'] != null
            ? CategoryModelList.fromJson(json['category'])
            : CategoryModelList(
                code: '',
                id: '',
                name: '',
                image: '',
                description: '',
                slug: '',imgfile:Uint8List(0),
                parent_id: '',
                IsDefault: '', catName: ''),
        tax_method: json['tax_method'].toString(),
        unit_price: json['unit_price'].toString(),
        quantity: json['quantity'] != null ? json['quantity'] : 0);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"]= this.id;
    data["name"]= this.name;
    data["unit_price"]=this.unit_price;
    data["tax_method"]= this.tax_method;
    data["slug"]=this.slug;
    data["net_price"]=this.net_price;
    data["net_price_sel"]= this.net_price_sel;
    data["image_url"]= this.image_url;
    data["code"]=  this.code;
    data["type"]= this.type;
    data["second_name"]= this.second_name;
    data["price"]=  this.price;
    data["quantity"]= this.quantity;
    data["tax_rate"] = TaxModelList.toMap(this.texes);
    return data;
  }
  static Map<String, dynamic> toMavp(ProductModdelList music) => {
        'id': music.id,
        'name': music.name,
        'unit_price': music.unit_price,
        'tax_method': music.tax_method,
        'slug': music.slug,
        'net_price': music.net_price,
        'net_price': music.net_price_sel,
        'image_url': music.image_url,
        'code': music.code,
        'type': music.type,
    'second_name':music.second_name,
        'price': music.price,
        'quantity': music.quantity,
        'tax_rate': TaxModelList.toMap(music.texes),
      };
}
