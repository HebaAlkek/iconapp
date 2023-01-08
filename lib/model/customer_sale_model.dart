import 'package:flutter/material.dart';

class CustomerSaleModel {
  String name, phone, address, city, state, country;

  CustomerSaleModel(
      {required this.name,
      required this.city,
      required this.country,
      required this.address,
      required this.phone,
      required this.state});

  factory CustomerSaleModel.fromJson(Map<String, dynamic> json) {
    return CustomerSaleModel(
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      address: json['address'].toString(),
      city: json['city'].toString(),
      state: json['state'].toString(),
      country: json['country'].toString(),
    );
  }
}
