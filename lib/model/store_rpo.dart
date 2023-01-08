import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:icon/model/produce_model.dart';

class ProStore {
  List<ProductModdelList> listStorePro;

  ProStore({required this.listStorePro});

  factory ProStore.fromJson(List<dynamic> json) {
    return ProStore(
        listStorePro: json.map((i) => ProductModdelList.fromJson(i)).toList());
  }
}
