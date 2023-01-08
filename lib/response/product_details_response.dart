import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/combo_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/product_details_model.dart';

class ProductDetailsResponse {
  final ProductDetailsModelList products;
  final List<ComboModel> comboList;
String message;
  final int code;

  ProductDetailsResponse(this.products,this.message, this.code,this.comboList);

  ProductDetailsResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : products = ProductDetailsModelList.fromJson(json["data"]["product"]),
        comboList = json["data"]['combo_items']!=null?List<ComboModel>.from(
            json["data"]['combo_items'].map((x) => ComboModel.fromJson(x))):[],
        code = statueCode,
  message=json['message'];

  ProductDetailsResponse.withError(Map<String, dynamic> json,int? code)
      : code = code!,
  message = json['message'],
        comboList=[],
        products = ProductDetailsModelList(
            tax_rate: '',
            cost: '',
            valRet: 0,
qty: '',
            lastPrice:'',
            supplier1price: '',
            qtybase:'',
            cf4: '',
            cf1: '',
            alert_quantity: '',
            supplier5: '',
            supplier5_part_no: '',
            supplier4: '',
            weight: '',
            hsn_code: '',
            supplier1_part_no: '',
            slug: '',
            code: '',
            end_date: '',
            views: '',
            sale_unit: '',
            unit: '',
            id: '',
            supplier3: '',
            featured: '',
            hide_pos: '',
            supplier2price: '',
            cf6: '',
            barcode_symbology: '',
            supplier4_part_no: '',
            supplier1: '',
            type: '',
            price: '',
            track_quantity: '',
            brand: '',
            tax_method: '',
            cf5: '',
            supplier3_part_no: '',
            image: '',
            second_name: '',
            supplier2_part_no: '',
            supplier5price: '',
            subcategory_id: '',
            product_details: '',
            promo_price: '',
            start_date: '',
            supplier3price: '',
            name: '',
            warehouse: '',
            hide: '',
            cf3: '',
            supplier4price: '',
            file: '',
            cf2: '',
            category_id: '',
            promotion: '',
            quantity: '',
            purchase_unit: '',
            supplier2: '',
            details: '', unit_price: '');
}
