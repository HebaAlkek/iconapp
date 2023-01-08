import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class SupplierModelList {
  String address,id;
  String city, company, country, email, gst_no, person, phone, postal_code;
  String state, vat_no;

  SupplierModelList(
      {required this.state,
      required this.email,required this.id,
      required this.city,
      required this.country,
      required this.address,
      required this.postal_code,
      required this.phone,
      required this.gst_no,
      required this.vat_no,
      required this.company,
      required this.person});

  factory SupplierModelList.fromJson(Map<String, dynamic> json) {
    return SupplierModelList(
      country: json['country'].toString(),
      id: json['id'].toString(),

      vat_no: json['vat_no'].toString(),
      state: json['state'].toString(),
      postal_code: json['postal_code'].toString(),
      phone: json['phone'].toString(),
      gst_no: json['gst_no'].toString(),
      email: json['email'].toString(),
      company: json['company'].toString(),
      address: json['address'].toString(),
      city: json['city'].toString(),
      person: json['person'].toString(),
    );
  }
}
