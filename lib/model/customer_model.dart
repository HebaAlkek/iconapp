import 'package:flutter/material.dart';

class CustomerModel {
  List<CustomerModelList> customerList;

  CustomerModel({required this.customerList});

  factory CustomerModel.fromJson(List<dynamic> json) {
    return CustomerModel(
        customerList: json.map((i) => CustomerModelList.fromJson(i)).toList());
  }
}

class CustomerModelList {
  String id;
  String name, company;
  bool check =false;

  CustomerModelList(
      {required this.name, required this.id, required this.company});

  factory CustomerModelList.fromJson(Map<String, dynamic> json) {
    return CustomerModelList(
      name: json['name'].toString(),
      id: json['id'].toString(),
      company: json['company'].toString(),
    );
  }
}
