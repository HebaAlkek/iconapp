import 'package:flutter/material.dart';
import 'package:icon/model/permission_model.dart';

class SettingModel {
  String site_name, reference_format;
  PermissionModel? Permission;
  String language,
      currency,
      dateformat,
      sales_prefix,
      payment_prefix,
      return_prefix,
      overselling,
      decimals,
      qty_decimals,
      Invoice_Forms,
      Language_print_items,
      default_warehouse,
      default_biller,
      default_customer;

  SettingModel(
      {required this.language,
      required this.default_warehouse,
      required this.default_biller,
      required this.default_customer,
      required this.currency,
      required this.Permission,
      required this.dateformat,
      required this.decimals,
      required this.Invoice_Forms,
      required this.Language_print_items,
      required this.overselling,
      required this.payment_prefix,
      required this.qty_decimals,
      required this.reference_format,
      required this.return_prefix,
      required this.sales_prefix,
      required this.site_name});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      language: json['language'].toString(),
      Permission: json['Permission'].length != 0
          ? PermissionModel.fromJson(json['Permission'])
          : null,
      site_name: json['site_name'].toString(),
      reference_format: json['reference_format'].toString(),
      currency: json['currency'].toString(),
      dateformat: json['dateformat'].toString(),
      sales_prefix: json['sales_prefix'].toString(),
      payment_prefix: json['payment_prefix'].toString(),
      return_prefix: json['return_prefix'].toString(),
      overselling: json['overselling'].toString(),
      decimals: json['decimals'].toString(),
      qty_decimals: json['qty_decimals'].toString(),
      Invoice_Forms: json['Invoice_Forms'].toString(),
      Language_print_items: json['Language_print_items'].toString(),
      default_warehouse: json['default_warehouse'].toString(),
      default_biller: json['default_biller'].toString(),
      default_customer: json['default_customer'].toString(),
    );
  }
}
