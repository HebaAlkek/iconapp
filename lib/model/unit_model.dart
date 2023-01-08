import 'package:flutter/material.dart';

class UnitModelList {
  String id;
  String name, code, base_unit, operator, unit_value,operation_value;
 
  UnitModelList({
    required this.name,
    required this.id,
    required this.code,
    required this.base_unit,
    required this.operator,
    required this.operation_value, required this.unit_value
  });

  factory UnitModelList.fromJson(Map<String, dynamic> json) {
    return UnitModelList(
      name: json['name'].toString(),
      id: json['id'].toString(),
      code: json['code'].toString(),
      base_unit: json['base_unit'].toString(),
      operator: json['operator'].toString(),
      operation_value: json['operation_value'].toString(),
      unit_value: json['unit_value'].toString(),

    );
  }
}
