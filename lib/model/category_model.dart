import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CategoryModelList {
  String id;
  String name, code, image, parent_id, slug, description, IsDefault,catName;
  Uint8List imgfile;
  CategoryModelList(
      {required this.name,
      required this.id,required this.catName,
      required this.code,
      required this.image,
      required this.description,
      required this.parent_id,
      required this.slug,
        required this.imgfile,
      required this.IsDefault});

  factory CategoryModelList.fromJson(Map<String, dynamic> json) {
    return CategoryModelList(
      name: json['name'].toString(),
      id: json['id'].toString(),
      IsDefault: json['IsDefault'].toString(),
      code: json['code'].toString(),
      catName: '',
      image: json['image'].toString(),
      description: json['description'].toString(),
      parent_id: json['parent_id'].toString(),
      slug: json['slug'].toString(),
        imgfile:Uint8List(0)
    );
  }
}
