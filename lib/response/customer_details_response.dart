import 'package:icon/model/customer_details_model.dart';
import 'package:icon/model/customer_group_model.dart';
import 'package:icon/model/price_group_model.dart';

class CustomerDetailsResponse {
  final List<CustomerGroupList> customerGroupList;
  final List<PriceGroupList> priceList;
  int statuecode;
  final CustomerDetailsModelList customerDe;
String message;
  CustomerDetailsResponse(this.message,
      this.customerGroupList, this.priceList, this.statuecode, this.customerDe);

  CustomerDetailsResponse.fromJson(Map<String, dynamic> json, int code)
      : customerGroupList = List<CustomerGroupList>.from(json["data"]
                ['customer_groups']
            .map((x) => CustomerGroupList.fromJson(x))),
  message=json['message'],
        priceList = List<PriceGroupList>.from(json["data"]['price_groups']
            .map((x) => PriceGroupList.fromJson(x))),
        customerDe =
            CustomerDetailsModelList.fromJson(json["data"]["customer"]),
        statuecode = code;

  CustomerDetailsResponse.withError(Map<String, dynamic> json,int? code)
      : customerGroupList = [],
        priceList = [],
        customerDe = CustomerDetailsModelList(
            cf3: '',
            name: '',
            customer_group_name: '',
            country: '',
            cf2: '',
            group_name: '',
            gst_no: '',
            deposit_amount: '',
            price_group_id: '',
            state: '',
            cf6: '',
            logo: '',
            group_id: '',
            vat_no: '',
            price_group_name: '',
            city: '',
            cf5: '',
            invoice_footer: '',
            customer_group_id: '',
            cf1: '',
            company: '',
            postal_code: '',
            id: '',
            award_points: '',
            cf4: '',
            phone: '',
            address: '',
            email: '',
            payment_term: ''),
        statuecode = code!,
  message=json['message'];
}
