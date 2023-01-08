import 'package:icon/model/reference_model.dart';

class REturnPurchasesREsponse {
  final String retPurId;
  int code;
  String message;
  REturnPurchasesREsponse(this.retPurId, this.code,this.message);

  REturnPurchasesREsponse.fromJson(Map<String, dynamic> json, int statueCode)
      : retPurId =
      json["data"][0]['id'],
        message = json['message'],
        code = statueCode;

  REturnPurchasesREsponse.withError(Map<String, dynamic> json, int statueCode)
      : code = 0,
        message='',
        retPurId = '';
}
