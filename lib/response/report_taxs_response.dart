import 'package:icon/model/report_taxs_model.dart';

class ReportTaxsResponse {
  final List<ReportTaxsModel> listRep;

  int statuecode;
String message;
  ReportTaxsResponse(this.listRep, this.statuecode,this.message);

  ReportTaxsResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
  message = json['message'],
        listRep = json['data'] != null
            ? List<ReportTaxsModel>.from(
                json["data"].map((x) => ReportTaxsModel.fromJson(x)))
            : [];

  ReportTaxsResponse.withError(Map<String, dynamic> json, int statueCode)
      : listRep = [],
  message = json['message'],
        statuecode = statueCode;
}
