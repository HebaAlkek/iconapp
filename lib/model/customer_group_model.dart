import 'package:flutter/material.dart';

class CustomerGroupList {
  String id;
  String name, percent, discount;

  CustomerGroupList(
      {required this.name,
      required this.id,
      required this.discount,
      required this.percent});

  factory CustomerGroupList.fromJson(Map<String, dynamic> json) {
    return CustomerGroupList(
      name: json['name'].toString(),
      id: json['id'].toString(),
      discount: json['discount'] != null ? json['discount'].toString() : '',
      percent: json['percent'] != null ? json['percent'].toString() : '',
    );
  }
}
