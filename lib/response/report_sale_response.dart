
import 'package:icon/model/report_sale_model.dart';

class ReportSaleResponse {
  final List<ReportSaleModel> listRep;

  int statuecode;
String message;
  ReportSaleResponse(this.listRep,this.message, this.statuecode);

  ReportSaleResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
  message =json['message'],
        listRep = json['data'] != null
            ? List<ReportSaleModel>.from(
            json["data"].map((x) => ReportSaleModel.fromJson(x)))
            : [];

  ReportSaleResponse.withError(Map<String, dynamic> json, int statueCode)
      : listRep = [],
  message= json['message'],
        statuecode = statueCode;
}
