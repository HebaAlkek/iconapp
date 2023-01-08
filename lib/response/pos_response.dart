import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/permission_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/setting_model.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/warehouse_model.dart';

class PosResponse {
  final WarehouseModel? wares;
  final CustomerModel? customers;
  final CustomerModel? billers;
  final List<TaxModelList> taxes;
  final List<CategoryModelList> categories;
  final List<CategoryModelList> subCategories;
  final List<BrandModelList> brands;
  final List<ProductModdelList> products;
  final String token;
  final String user_id;
  final String limit;
  final String start;
  final int totalp;
  final int code;
  final SettingModel? settingItem;
  final String message;
  final String status;

  PosResponse(
      this.start,
      this.settingItem,
      this.status,
      this.message,
      this.user_id,
      this.token,
      this.billers,
      this.products,
      this.categories,
      this.customers,
      this.limit,
      this.taxes,
      this.totalp,
      this.wares,
      this.code,
      this.subCategories,
      this.brands);

  PosResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : wares = json['data'] != null
            ? json['data']['warehouses'] != null
                ? WarehouseModel.fromJson(json['data']['warehouses'])
                : null
            : null,
        customers = json['data'] != null
            ? json['data']['customer'] != null
                ? CustomerModel.fromJson(json['data']['customer'])
                : null
            : null,
        billers = json['data'] != null
            ? json['data']['billers'] != null
                ? CustomerModel.fromJson(json['data']['billers'])
                : null
            : null,
        settingItem = json['data'] != null
            ? json['data']['DefaultSettings'] != null
                ? SettingModel.fromJson(json['data']['DefaultSettings'])
                : null
            : null,
        taxes = json['data'] != null
            ? List<TaxModelList>.from(
                json["data"]['tax_rates'].map((x) => TaxModelList.fromJson(x)))
            : [],
        categories = json['data'] != null
            ? List<CategoryModelList>.from(json["data"]['categories']
                .map((x) => CategoryModelList.fromJson(x)))
            : [],
        subCategories = json['data'] != null
            ? List<CategoryModelList>.from(json["data"]['subcategories']
                .map((x) => CategoryModelList.fromJson(x)))
            : [],
        products = json['data'] != null
            ? List<ProductModdelList>.from(json["data"]['products']
                .map((x) => ProductModdelList.fromJson(x)))
            : [],
        brands = json['data'] != null
            ? List<BrandModelList>.from(
                json["data"]['brands'].map((x) => BrandModelList.fromJson(x)))
            : [],
        start = json['start'] != null ? json['start'].toString() : '0',
        code = statueCode,
        totalp = json['Total Products'] != null ? json['Total Products'] : 0,
        user_id = json["data"] != null ? json["data"]['user_id'] : '',
        token = json["data"] != null ? json["data"]['token'] : json['token'],
        limit = json['limit'] != null ? json['limit'].toString() : '',
        status = json['status'] != null ? json['status'].toString() : '',
        message = json['message'] != null ? json['message'].toString() : '';

  PosResponse.withError(String mes, int statueCode)
      : start = '0',
        totalp = 0,
        user_id = '',
        limit = '0',
        message =  mes,
        status = '',
        settingItem = SettingModel(
            language: '',
            currency: '',Permission:null,
            dateformat: '',
            decimals: '',
            Invoice_Forms: '',
            Language_print_items: '',
            overselling: '',
            payment_prefix: '',
            qty_decimals: '',
            reference_format: '',
            return_prefix: '',
            sales_prefix: '',
            site_name: '',
            default_biller: '',
            default_customer: '',
            default_warehouse: ''),
        token = '',
        taxes = [],
        customers = null,
        wares = null,
        code = statueCode,
        categories = [],
        subCategories = [],
        products = [],
        billers = null,
        brands = [];
}
