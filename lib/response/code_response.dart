import 'dart:io';
import 'dart:typed_data';

import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/unit_model.dart';

class CodeResponse {
  final ProductModdelList productItem;
  final String message;
  final bool status;
  final int code;

  CodeResponse(this.productItem, this.message, this.status,this.code);

  CodeResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : productItem = ProductModdelList.fromJson(json),
        message = json['message'] != null ? json['message'] : 'Success',
        code=statueCode,

      status = json['status'] != null ? json['status'] : true;

  CodeResponse.withError(Map<String, dynamic> json, int? statueCode)
      : status = false,
        message = '',
  code=statueCode!,
        productItem = ProductModdelList(
            slug: '',
            second_name: '',
            code: '',
            id: '',
            net_price_sel: '',
            name: '',
            quantity: 0,
            net_price: '',
            image_url: '',
            tax_method: '',
            unit_price: '',
            type: '',
            brandItem: BrandModelList(
                name: '',
                id: '',
                code: '',    imgfile:Uint8List(0),
                slug: '',
                description: '',
                image: ''),
            mainCat: CategoryModelList(
                image: '',
                description: '',imgfile: Uint8List(0),
                slug: '',
                code: '',
                id: '',
                name: '',
                IsDefault: '',
                parent_id: '', catName: ''),
            price: '',
            texes: TaxModelList(name: '', id: '', code: '', type: '', rate: ''),
            unitItem: UnitModelList(
                code: '',
                id: '',
                name: '',
                base_unit: '',
                operation_value: '',
                operator: '',
                unit_value: ''));
}
