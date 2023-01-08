import 'package:flutter/material.dart';



class TaxModelList {
  String id;
  String name, code, rate, type;

  TaxModelList(
      {required this.name,
      required this.id,
      required this.code,
      required this.rate,
      required this.type});

  factory TaxModelList.fromJson(Map<String, dynamic> json) {
    return TaxModelList(
      name: json['name'].toString(),
      id: json['id'].toString(),
      code: json['code'].toString(),
      rate: json['rate'].toString(),
      type: json['type'].toString(),
    );
  }
  static Map<String, dynamic> toMap(TaxModelList music) => {
    'id': music.id,
    'name': music.name,
    'code': music.code,
    'rate': music.rate,
    'type': music.type,


  };

}
