class SaleUserModel {
  String first_name, last_name;

  SaleUserModel(
      {required this.first_name,
        required this.last_name,
   });

  factory SaleUserModel.fromJson(Map<String, dynamic> json) {
    return SaleUserModel(
        first_name: json['first_name'].toString(),
        last_name: json['last_name'].toString());
  }
}
