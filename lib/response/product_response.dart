import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/produce_model.dart';

class ProductResponse {
  final List<ProductModdelList> products;
  final List<CategoryModelList> subList;
String message;
  final String limit;
  final String start;
  final int totalp;
  final int code;

  ProductResponse(this.start,this.message, this.products, this.limit, this.totalp, this.code,
       this.subList);

  ProductResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : products = json["data"]['products'] != null
            ? List<ProductModdelList>.from(json["data"]['products']
                .map((x) => ProductModdelList.fromJson(x)))
            : [],
  message = json['message'],
        subList = json["data"]['subcategory'] != null
            ? List<CategoryModelList>.from(json["data"]['subcategory']
                .map((x) => CategoryModelList.fromJson(x)))
            : [],

        start = json['start'].toString(),
        code = statueCode,
        totalp = json['total'],
        limit = json['limit'].toString();

  ProductResponse.withError(Map<String, dynamic> json,int? code)
      : start = '0',
message = json['message'],
        totalp = 0,
        limit = '0',
        code = code!,
        products = [],
        subList = [];
}
