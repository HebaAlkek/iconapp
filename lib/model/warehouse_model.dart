import 'package:flutter/material.dart';

class WarehouseModel {
  List<WarehouseModelList> wareList;

  WarehouseModel({required this.wareList});

  factory WarehouseModel.fromJson(List<dynamic> json) {
    return WarehouseModel(
        wareList: json.map((i) => WarehouseModelList.fromJson(i)).toList());
  }
}

class WarehouseModelList {
  String id;
  String name;

  WarehouseModelList({required this.name, required this.id});

  factory WarehouseModelList.fromJson(Map<String, dynamic> json) {
    return WarehouseModelList(
      name: json['name'].toString(),
      id: json['id'].toString(),
    );
  }
}
