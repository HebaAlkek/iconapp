

class CustomerDetailsModelList {
  String id;
  String
      cf1,
      cf2,
      cf3,
      cf4,
      cf5,
      cf6,
      gst_no,
      price_group_name,
      price_group_id,
      deposit_amount,
      award_points,
      logo,
      payment_term,
      invoice_footer,
      email,
      phone,
      country,
      postal_code,
      state,
      city,
      address,
      vat_no,
      company,
      name,
      customer_group_name,
      group_name,
      customer_group_id,
      group_id;





  CustomerDetailsModelList(
      {required this.name,
        required this.company,
        required this.email,
        required this.city,
        required this.address,
        required this.state,
        required this.phone,
        required this.country,
        required this.id,
        required this.award_points,
        required this.customer_group_id,
        required this.customer_group_name,
        required this.deposit_amount,
        required this.group_id,
        required this.group_name,
        required this.gst_no,
        required this.invoice_footer,
        required this.cf1,
        required this.cf2,
        required this.cf3,
        required this.cf4,
        required this.cf5,
        required this.cf6,
        required this.logo,
        required this.payment_term,
        required this.postal_code,
        required this.price_group_id,
        required this.price_group_name,
        required this.vat_no});

  factory CustomerDetailsModelList.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModelList(
        name: json['name'] != null ? json['name'].toString() : '',
        country:  json['country'] != null ? json['country'].toString() : '',
        city:  json['city'] != null ? json['city'].toString() : '',
        address:  json['address'] != null ? json['address'].toString() : '',
        award_points:  json['award_points'] != null ? json['award_points'].toString() : '',
        company:  json['company'] != null ? json['company'].toString() : '',
        customer_group_id:  json['customer_group_id'] != null
            ? json['customer_group_id'].toString()
            : '',
        customer_group_name:  json['customer_group_name'] != null ? json['customer_group_name'].toString() : '',
        id: json['id'] != null ? json['id'].toString() : '',
        deposit_amount:  json['deposit_amount'] != null ? json['deposit_amount'].toString() : '',
        email:  json['email'] != null ? json['email'].toString() : '',
        group_id:  json['group_id'] != null
            ? json['group_id'].toString()
            : '',
        group_name:  json['group_name'] != null ? json['group_name'].toString() : '',
        gst_no:
        json['gst_no'] != null ? json['gst_no'].toString() : '',
        invoice_footer:
        json['invoice_footer'] != null ? json['invoice_footer'].toString() : '',
        logo:
        json['logo'] != null ? json['logo'].toString() : '',
        payment_term:  json['payment_term'] != null ? json['payment_term'].toString() : '',
        cf1: json['cf1'] != null ? json['cf1'].toString() : '',
        cf2: json['cf2'] != null ? json['cf2'].toString() : '',
        cf3: json['cf3'] != null ? json['cf3'].toString() : '',
        cf4: json['cf4'] != null ? json['cf4'].toString() : '',
        cf5: json['cf5'] != null ? json['cf5'].toString() : '',
        cf6: json['cf6'] != null ? json['cf6'].toString() : '',
        phone:  json['phone'] != null ? json['phone'].toString() : '',
        postal_code:  json['postal_code'] != null ? json['postal_code'].toString() : '',
        price_group_name:  json['price_group_name'] != null ? json['price_group_name'].toString() : '',
        price_group_id:  json['price_group_id'] != null ? json['price_group_id'].toString() : '',
        state:  json['state'] != null ? json['state'].toString() : '',
        vat_no:  json['vat_no'] != null ? json['vat_no'].toString() : '',
     );
  }
}
