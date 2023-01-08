class ReferenceModel {
  String refNo;

  ReferenceModel({required this.refNo});

  factory ReferenceModel.fromJson(Map<String, dynamic> json) {
    return ReferenceModel(refNo: json['reference_no'].toString());
  }
}
