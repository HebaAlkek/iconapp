import 'package:icon/model/customer_group_model.dart';
import 'package:icon/model/price_group_model.dart';

class CustomerResponse {
  final List<CustomerGroupList> customerList;
  final List<PriceGroupList> priceList;
  int statuecode;
String message;
  CustomerResponse(this.customerList, this.priceList, this.statuecode,this.message);

  CustomerResponse.fromJson(Map<String, dynamic> json, int code)
      : customerList = List<CustomerGroupList>.from(json["data"]
                ['customer_groups']
            .map((x) => CustomerGroupList.fromJson(x))),
  message =json['message'],
        priceList = List<PriceGroupList>.from(json["data"]['price_groups']
            .map((x) => PriceGroupList.fromJson(x))),
        statuecode = code;

  CustomerResponse.withError(Map<String, dynamic> json,int? code)
      : customerList = [],
  message = json['message'],
        priceList = [],
        statuecode = code!;
}
