import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:icon/model/product_retrive_model.dart';

class REtriveSaveModel {
  var students;
  String invId;
  double grandTotal;
  int total_items;

  REtriveSaveModel(
      {required this.students,
      required this.grandTotal,
      required this.total_items,
      required this.invId});

  factory REtriveSaveModel.fromJson(Map<String, dynamic> jsonData) {
    return REtriveSaveModel(
      students:
      (json.decode(jsonData['students'])
      as List<dynamic>)
          .map<ProductRetriveModel>((item) =>
          ProductRetriveModel.fromJsuon(item))
          .toList()

,
      grandTotal: jsonData['grandTotal'],
      total_items: jsonData['total_items'],
      invId: jsonData['invId'],
    );
  }

  static Map<String, dynamic> toMap(REtriveSaveModel music) => {
        'students':json.encode(
  music.students
      .map<Map<String, dynamic>>(
  (music) =>
      ProductRetriveModel.toMap(music))
      .toList()),
        'invId': music.invId,
        'total_items': music.total_items,
        'grandTotal': music.grandTotal,
      };

  static String encode(List<REtriveSaveModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => REtriveSaveModel.toMap(music))
            .toList(),
      );

  static List<REtriveSaveModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<REtriveSaveModel>((item) => REtriveSaveModel.fromJson(item))
          .toList();
}
