import 'dart:typed_data';

import 'package:flutter/material.dart';

class BrandModelList {
  String id;
  String name, code, image, slug, description;
  Uint8List imgfile;

  BrandModelList({
    required this.name,
    required this.imgfile,
    required this.id,
    required this.code,
    required this.image,
    required this.description,
    required this.slug,
  });

  factory BrandModelList.fromJson(Map<String, dynamic> json) {
    return BrandModelList(
      name: json['name'].toString(),
      id: json['id'].toString(),
      code: json['code'].toString(),
      image: json['image'].toString(),
      description: json['description'].toString(),
      slug: json['slug'].toString(),        imgfile:Uint8List(0)

    );
  }
}
