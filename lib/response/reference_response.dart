import 'package:icon/model/reference_model.dart';

class ReferenceResponse {
  final List<ReferenceModel> refList;
  int code;
String message;
  ReferenceResponse(this.refList, this.code,this.message);

  ReferenceResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : refList = List<ReferenceModel>.from(
            json["data"].map((x) => ReferenceModel.fromJson(x))),
        message = json['message'],
        code = statueCode;

  ReferenceResponse.withError(Map<String, dynamic> json, int statueCode)
      : code = 0,
        message='',
        refList = [];
}
