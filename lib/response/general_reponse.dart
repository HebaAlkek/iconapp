import 'package:icon/model/biller_model.dart';
import 'package:icon/model/creatUser_model.dart';
import 'package:icon/model/customer_sale_model.dart';
import 'package:icon/model/inv_model.dart';
import 'package:icon/model/pos_model.dart';
import 'package:icon/model/product_sale_model.dart';

class GeneralResponse {
  final String message;
  final bool status;
  final BillerModel billerItem;
  final PosModel posItem;
  final SaleUserModel saleUsesr;
  final CustomerSaleModel customerSale;
  final InvModel invItem;
  final List<ProductSaleModel> productList;

  GeneralResponse(this.message, this.status, this.billerItem, this.posItem,
      this.saleUsesr, this.customerSale, this.invItem, this.productList);

  GeneralResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : billerItem = BillerModel.fromJson(json['Data']['biller']),
        posItem = PosModel.fromJson(json['Data']['pos']),
        customerSale = CustomerSaleModel.fromJson(json['Data']['customer']),
        saleUsesr = SaleUserModel.fromJson(json['Data']['created_by']),
        invItem = InvModel.fromJson(json['Data']['inv']),
        productList = List<ProductSaleModel>.from(
            json["Data"]['rows'].map((x) => ProductSaleModel.fromJson(x))),
        message = json['message'] != null ? json['message'] : 'Success',
        status = json['status'] != null ? json['status'] : true;

  GeneralResponse.withError(Map<String, dynamic> json)
      : status = false,
        productList = [],
        saleUsesr = SaleUserModel(first_name: '', last_name: ''),
        billerItem = BillerModel(
            address: '',
            invoicefooter: '',
            billerName: '',
            city: '',
            companeName: '',
            country: '',
            tel: ''),
        posItem = PosModel(
            cf_title1: '',
            cf_title2: '',
            cf_value1: '',
            cf_value2: '',
            customer_details: ''),
        invItem = InvModel(
            date: '',
            delivery_date: '',note:'',
            reference_no: '',
            grand_total: '',
            total: '',return_sale_ref: '',
            product_tax: '', id: ''),
        customerSale = CustomerSaleModel(
            name: '', address: '', country: '', state: '', city: '', phone: ''),
        message = '';
}
