class InvModel {
  String date, reference_no, delivery_date, total, product_tax, grand_total,id,return_sale_ref,note;

  InvModel(
      {required this.date,
      required this.reference_no,
      required this.delivery_date,required this.id,
      required this.total,required this.return_sale_ref,
      required this.product_tax,
        required this.note,
      required this.grand_total});

  factory InvModel.fromJson(Map<String, dynamic> json) {
    return InvModel(
        date: json['date'].toString(),
        id: json['id'].toString(),
        note: json['note'].toString(),

        return_sale_ref:json['return_sale_ref'].toString(),
        reference_no: json['reference_no'].toString(),
        delivery_date: json['delivery_date'].toString(),
        total: json['total'].toString(),
        grand_total: json['grand_total'].toString(),
        product_tax: json['product_tax'].toString());
  }
}
