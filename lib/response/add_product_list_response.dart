import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/unit_model.dart';
import 'package:icon/model/warehouse_model.dart';

class GetListAddProductResponse {
  final List<TaxModelList> taxes;
  final List<CategoryModelList> categories;
  final List<BrandModelList> brands;
  final List<UnitModelList> unitList;
  final List<WarehouseModelList> warehousesList;
  final List<WarehouseModelList> supList;

  int statuecode;
String message;
  GetListAddProductResponse(this.taxes, this.categories, this.brands,
      this.unitList, this.warehousesList, this.statuecode,this.supList,this.message);

  GetListAddProductResponse.fromJson(Map<String, dynamic> json, int statueCode)
      : statuecode = statueCode,
  message = json['message'],
        taxes = json['data'] != null
            ? List<TaxModelList>.from(
                json["data"]['tax_rates'].map((x) => TaxModelList.fromJson(x)))
            : [],
        categories = json['data'] != null
            ? List<CategoryModelList>.from(json["data"]['categories']
                .map((x) => CategoryModelList.fromJson(x)))
            : [],
        brands = json['data'] != null
            ? List<BrandModelList>.from(
                json["data"]['brands'].map((x) => BrandModelList.fromJson(x)))
            : [],
        unitList = json['data'] != null
            ? List<UnitModelList>.from(json["data"]['base_units']
                .map((x) => UnitModelList.fromJson(x)))
            : [],
        warehousesList = json['data'] != null
            ? List<WarehouseModelList>.from(json["data"]['warehouses']
                .map((x) => WarehouseModelList.fromJson(x)))
            : [],
        supList = json['data'] != null
            ? List<WarehouseModelList>.from(json["data"]['Supplier']
            .map((x) => WarehouseModelList.fromJson(x)))
            : [];

  GetListAddProductResponse.withError(Map<String, dynamic> json, int statueCode)
      : taxes = [],
        statuecode = statueCode,
  message = json['message'],
        categories = [],
        warehousesList = [],
        unitList = [],
        brands = [],supList=[];
}
