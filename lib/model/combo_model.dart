class ComboModel {
  String id, code, name, qty, price;

  ComboModel(
      {required this.id,
      required this.code,
      required this.qty,
      required this.price,
      required this.name});

  factory ComboModel.fromJson(Map<String, dynamic> json) {
    return ComboModel(
        name: json['name'].toString(),
        id: json['id'].toString(),
        price: json['price'].toString(),
        qty: json['qty'].toString(),
        code: json['code'].toString());
  }
}
