
class ReportSaleModel {
  String id;
  String date,
      reference_no,
      payment_status,
      customer,
      biller,
      iname,
      paid,
      balance,
      grand_total,sale_status,return_sale_ref;

  ReportSaleModel(
      {required this.balance,required this.sale_status,required this.return_sale_ref,
      required this.id,
      required this.date,
      required this.customer,
      required this.grand_total,
      required this.reference_no,
      required this.biller,
      required this.iname,
      required this.paid,
      required this.payment_status});

  factory ReportSaleModel.fromJson(Map<String, dynamic> json) {
    return ReportSaleModel(
      balance: json['balance'].toString(),
      sale_status: json['sale_status'].toString(),

      id: json['id'].toString(),
      date: json['date'].toString(),
      return_sale_ref: json['return_sale_ref']!=null?json['return_sale_ref'].toString():'',

      grand_total: json['grand_total'].toString(),
      customer: json['customer'].toString(),
      reference_no: json['reference_no'].toString(),
      biller: json['biller'].toString(),
      iname: json['iname'].toString(),
      paid: json['paid'].toString(),
      payment_status: json['payment_status'].toString(),
    );
  }
}
