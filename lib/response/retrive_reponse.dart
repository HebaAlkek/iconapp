import 'package:flutter/material.dart';
import 'package:icon/model/product_retrive_model.dart';

class RetriveResponse {
  Map<String, ProductRetriveModel> students;

  int statuecode;
  String grandTotal, total_items;
  String invId;
  String message;

  RetriveResponse(this.message, this.students, this.statuecode, this.grandTotal,
      this.total_items, this.invId);

  RetriveResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
        grandTotal = json['data']['inv']['grand_total'],
        invId = json['data']['inv']['id'],
        message = json['message'],
        total_items = json['data']['inv']['total_items'],
        students = Map.from(json['data']["inv_items"]).map((k, v) =>
            MapEntry<String, ProductRetriveModel>(
                k, ProductRetriveModel.fromJson(v)));

  RetriveResponse.withError(Map<String, dynamic> json, int statueCode)
      : students = Map<String, ProductRetriveModel>(),
        grandTotal = '',
        total_items = '',
        invId = '',
        message = json['message'],
        statuecode = statueCode;
}
