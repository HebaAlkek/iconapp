class PosModel {
  String cf_title1, cf_title2;
  String cf_value1, cf_value2, customer_details;

  PosModel(
      {required this.cf_title1,
      required this.cf_title2,
      required this.cf_value1,
      required this.cf_value2,
      required this.customer_details});

  factory PosModel.fromJson(Map<String, dynamic> json) {
    return PosModel(
        cf_title1: json['cf_title1'].toString(),
        customer_details:
            json['customer_details'] == null ? '0' : json['customer_details'],
        cf_title2: json['cf_title2'].toString(),
        cf_value1: json['cf_value1'].toString(),
        cf_value2: json['cf_value2'].toString());
  }
}
