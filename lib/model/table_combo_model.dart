import 'package:flutter/material.dart';
import 'package:icon/model/produce_model.dart';

class TableComboModel {
  TextEditingController quan;
  TextEditingController pric;

  ProductModdelList itemPro;

  TableComboModel({required this.quan, required this.pric,required this.itemPro});
}