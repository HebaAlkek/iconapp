import 'package:flutter/material.dart';

class ReportTaxsModel {
  String id;
  String date,
      reference_no,
      sale_status,return_sale_ref,
      warehouse,
      biller,
      product_tax,
      order_tax,
      grand_total;

  ReportTaxsModel(
      {required this.warehouse,
      required this.id,required this.return_sale_ref,
      required this.date,
      required this.product_tax,
      required this.grand_total,
      required this.reference_no,
      required this.biller,
      required this.order_tax,
      required this.sale_status});

  factory ReportTaxsModel.fromJson(Map<String, dynamic> json) {
    return ReportTaxsModel(
      warehouse: json['warehouse'].toString(),
      id: json['id'].toString(),
      date: json['date'].toString(),
        return_sale_ref:json['return_sale_ref'].toString(),
      grand_total: json['grand_total'].toString(),
      product_tax: json['product_tax'].toString(),
      reference_no: json['reference_no'].toString(),
      biller: json['biller'].toString(),
      order_tax: json['order_tax'].toString(),
      sale_status: json['sale_status'].toString(),
    );
  }
}
