import 'package:flutter/material.dart';
import 'package:icon/model/warehouse_model.dart';

class addSupp {
  TextEditingController supp;
  TextEditingController supn;

  List<WarehouseModelList> supAddList;
  WarehouseModelList? supItemAdd;

  addSupp({required this.supp, required this.supn,required this.supAddList,required this.supItemAdd});
}