import 'package:icon/model/category_model.dart';

class SubCategoryResponse {
  final List<CategoryModelList> subCategories;

  int statuecode;
  String message;

  SubCategoryResponse(this.subCategories, this.statuecode,this.message);

  SubCategoryResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
        subCategories = json['data'] != null
            ? List<CategoryModelList>.from(
                json["data"].map((x) => CategoryModelList.fromJson(x)))
            : [],
  message=json['message'];

  SubCategoryResponse.withError(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
  message = json['message'],
        subCategories = [];
}
