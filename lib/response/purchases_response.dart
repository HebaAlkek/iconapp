import 'package:icon/model/purchases_model.dart';

class PurchasesResponse {
  final List<PurchasesModel> purList;
  int statuecode;
  String message;

  PurchasesResponse(this.purList, this.statuecode, this.message);

  PurchasesResponse.fromJson(Map<String, dynamic> json, int code)
      : purList = List<PurchasesModel>.from(
            json["data"].map((x) => PurchasesModel.fromJson(x))),
        message = json['message'] != null ? json['message'] : '',
        statuecode = code;

  PurchasesResponse.withError(Map<String, dynamic> json, int? code)
      : purList = [],
        message = json['message'],
        statuecode = code!;
}
