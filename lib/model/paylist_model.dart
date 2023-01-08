import 'package:flutter/material.dart';



class PayMOdelList {
  String id;
  String name, namear,namren;
  bool check =false;

  PayMOdelList(
      {required this.name, required this.id,required this.namear,required this.namren});

  factory PayMOdelList.fromJson(Map<String, dynamic> json) {
    return PayMOdelList(
      name: json['name'].toString(),

      namear: json['namear'].toString(),
      namren: json['namren'].toString(),
      id: json['id'].toString(),
    );
  }
}
