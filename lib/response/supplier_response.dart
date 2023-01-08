import 'package:icon/model/supplier_model.dart';

class SupplierResponse {
  final List<SupplierModelList> suppList;
  int statuecode;
  String message;

  SupplierResponse(this.suppList, this.statuecode, this.message);

  SupplierResponse.fromJson(Map<String, dynamic> json, int code)
      : suppList = List<SupplierModelList>.from(
            json["data"].map((x) => SupplierModelList.fromJson(x))),
        message = json['message'] != null ? json['message'] : '',
        statuecode = code;

  SupplierResponse.withError(Map<String, dynamic> json, int? code)
      : suppList = [],
        message = json['message'],
        statuecode = code!;
}
