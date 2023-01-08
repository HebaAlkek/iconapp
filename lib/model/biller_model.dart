import 'package:flutter/material.dart';

class BillerModel {
  String billerName, address,invoicefooter;
  String companeName, country, city, tel;

  BillerModel(
      {required this.billerName,
      required this.address,
        required this.invoicefooter,
      required this.city,
      required this.companeName,
      required this.country,
      required this.tel});

  factory BillerModel.fromJson(Map<String, dynamic> json) {
    return BillerModel(
      billerName: json['name'].toString(),
        invoicefooter:json['invoice_footer'].toString(),
      companeName: json['company'].toString(),
      address: json['address'].toString(),
      city: json['city'].toString(),
      country: json['country'].toString(),
      tel: json['phone'].toString(),
    );
  }
}
