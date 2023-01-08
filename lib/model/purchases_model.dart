import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class PurchasesModel {
  String date;
  String reference_no, supplier, payment_status, status, grand_total, paid;

  PurchasesModel(
      {required this.supplier,
      required this.status,
      required this.reference_no,
      required this.paid,
      required this.date,
      required this.grand_total,
      required this.payment_status});

  factory PurchasesModel.fromJson(Map<String, dynamic> json) {
    return PurchasesModel(
      paid: json['paid'].toString(),
      date: json['date'].toString(),
      payment_status: json['payment_status'].toString(),
      grand_total: json['grand_total'].toString(),
      reference_no: json['reference_no'].toString(),
      status: json['status'].toString(),
      supplier: json['supplier'].toString(),
    );
  }
}
