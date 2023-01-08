import 'package:flutter/material.dart';

class PriceGroupList {
  String id;
  String name;

  PriceGroupList({required this.name, required this.id});

  factory PriceGroupList.fromJson(Map<String, dynamic> json) {
    return PriceGroupList(
        name: json['name'].toString(), id: json['id'].toString());
  }
}
