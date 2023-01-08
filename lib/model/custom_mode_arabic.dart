import 'package:flutter/material.dart';

class CustomerModelAra {
  List<CustomerModelAraList> customerListara;

  CustomerModelAra({required this.customerListara});

  factory CustomerModelAra.fromJson(List<dynamic> json) {
    return CustomerModelAra(
        customerListara: json.map((i) => CustomerModelAraList.fromJson(i)).toList());
  }
}

class CustomerModelAraList {
  String id;
  String name,nameAr, company;
  bool check =false;

  CustomerModelAraList(
      {required this.name,required this.nameAr, required this.id, required this.company});

  factory CustomerModelAraList.fromJson(Map<String, dynamic> json) {
    return CustomerModelAraList(
      name: json['name'].toString(),
      nameAr: json['nameAr'].toString(),

      id: json['id'].toString(),
      company: json['company'].toString(),
    );
  }
}
