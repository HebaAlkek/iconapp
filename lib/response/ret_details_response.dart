import 'package:flutter/material.dart';
import 'package:icon/model/product_details_model.dart';
import 'package:icon/model/product_retrive_model.dart';

class REtPurchasesDetails {
  final List<ProductDetailsModelList> students;

  String message;
  int statuecodew;
  String invId;

  REtPurchasesDetails(this.message, this.students, this.statuecodew,this.invId);

  REtPurchasesDetails.fromJson(Map<String, dynamic> json, int statueCode)
      : message = json['message'],
        invId = json['data']['id'],
        statuecodew = statueCode,
        students = json["data"]['inv_items'] != null
            ? List<ProductDetailsModelList>.from(json["data"]['inv_items']
            .map((x) => ProductDetailsModelList.fromJson(x)))
            : [];

  REtPurchasesDetails.withError(Map<String, dynamic> json, int statueCode)
      : students = [],
        message = json['message'],
        invId='',
        statuecodew = statueCode;
}
