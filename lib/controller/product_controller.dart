import 'dart:convert';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/product_api_provider.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/custom_mode_arabic.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/supModelAdd.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/unit_model.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/add_product_list_response.dart';
import 'package:icon/response/product_response.dart';
import 'package:icon/response/sub_cat_response.dart';
import 'package:icon/screen/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  final wareList = [].obs;
  List<WarehouseModelList> suplierList = [];
  PosController posController = Get.put(PosController());

  final taxList = [].obs;
  final catList = [].obs;
  final subCatList = [].obs;
  final unitList = [].obs;
  final brandList = [].obs;
  TextEditingController proDetails = TextEditingController();
  TextEditingController proDetailsP = TextEditingController();
  WarehouseModelList? wareItem;
  WarehouseModelList? supItem;
  ProductAllController proAllController = Get.put(ProductAllController());

  TaxModelList? taxItem;
  CategoryModelList? catItem;
  BrandModelList? brandItem;
  UnitModelList? unitItem;
  CategoryModelList? subItem;
  UnitModelList? unitSaleItem;
  PickedFile? imageFile;
  PickedFile? imageFileDig;

  UnitModelList? unitPurItem;
  TextEditingController productN = TextEditingController();
  TextEditingController nameAra = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController alert = TextEditingController();
  TextEditingController prop = TextEditingController();
  RxString dates = ''.obs;
  RxString datee = ''.obs;

  CustomerModelAraList? proItem;
  TextEditingController codeTexts = TextEditingController();
  RxInt currentStep = 1.obs;
  TextEditingController digi = TextEditingController();
  bool isCheckedHide = false;

  CustomerModelList? codeItel;
  List<CustomerModelList> codeListType = [
    CustomerModelList(id: '1', name: 'Code25', company: ''),
    CustomerModelList(id: '2', name: 'Code39', company: ''),
    CustomerModelList(id: '3', name: 'Code128', company: ''),
    CustomerModelList(id: '4', name: 'EAN8', company: ''),
    CustomerModelList(id: '5', name: 'EAN13', company: ''),
    CustomerModelList(id: '6', name: 'UPC_A', company: ''),
    CustomerModelList(id: '7', name: 'UPC_E', company: ''),
  ];

  CustomerModelAraList? taxMethodItem;
  List<CustomerModelAraList> taxMethodList = [
    CustomerModelAraList(
        id: '0', name: 'Inclusive', company: '', nameAr: 'شامل الضريبة'),
    CustomerModelAraList(
        id: '1', name: 'Exclusive', company: '', nameAr: 'غير شامل الضريبة'),
  ];
  List<CustomerModelAraList> proList = [
    CustomerModelAraList(
        id: '1', name: 'Standard', company: '', nameAr: 'معيار'),
    CustomerModelAraList(id: '2', name: 'Combo', company: '', nameAr: 'تجميعي'),
    CustomerModelAraList(id: '3', name: 'Digital', company: '', nameAr: 'رقمي'),
    CustomerModelAraList(id: '4', name: 'Service', company: '', nameAr: 'خدمة'),
  ];
  final supAdvdList = [].obs;
  final productList = [].obs;
  final productListSearch = [].obs;

  final productListSele = [].obs;
  bool check = false;
  String? lang = '';
  ProductModdelList? productItem;

  @override
  void onInit() {
    getProduct();
    getDropListAddPro();
    // TODO: implement onInit
    super.onInit();
  }

  void getProduct() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    lang = sharedPrefs.getString('lang');
    try {
      productList.clear();
      productListSearch.clear();
      ProductResponse res = await ProductApiProvider().getProduct();

      if (res.code == 200) {
        productList.clear();
        productListSearch.clear();

        productList.assignAll(res.products);
        productListSearch.assignAll(res.products);

      } else if(res.code==503 && res.message.toString()=='Api feature is disabled'){
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  void addItemSup(TextEditingController controllern,
      TextEditingController controllerp, WarehouseModelList? subI) {
    supAdvdList.add(addSupp(
        supAddList: suplierList,
        supn: controllern,
        supp: controllerp,
        supItemAdd: subI));
  }

  void getDropListAddPro() async {
    try {
      isLoading(true);
      unitList.clear();
      wareList.clear();
      suplierList.clear();

      catList.clear();
      brandList.clear();
      taxList.clear();
      subCatList.clear();
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      dio.FormData data = new dio.FormData.fromMap({"token": token});
      GetListAddProductResponse res =
          await ProductApiProvider().getDropListAddPro(data);

      if (res.statuecode == 200) {
        unitList.clear();
        wareList.clear();
        catList.clear();
        brandList.clear();
        suplierList.clear();

        taxList.clear();
        subCatList.clear();
        unitList.assignAll(res.unitList);
        wareList.assignAll(res.warehousesList);
        catList.assignAll(res.categories);
        brandList.assignAll(res.brands);
        taxList.assignAll(res.taxes);
        suplierList.assignAll(res.supList);
if(catList.length>0){
        getSubCat(catList[0].id);}
        isLoading(false);
      }
      else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void getSubCat(String catId) async {
    try {
      subCatList.clear();

      SubCategoryResponse res = await ProductApiProvider().GettSubCat(catId);

      if (res.statuecode == 200) {
        subCatList.clear();
        subCatList.assignAll(res.subCategories);
      }
      else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  Future<void> removeStep(BuildContext context) async {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  Future<void> nextStep(BuildContext context) async {
    if (currentStep.value == 1) {
      if (proItem == null) {
        Get.snackbar(S.of(context).Error, S.of(context).pleases,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        if (proItem!.id.toString() == '3') {
          if (imageFileDig == null) {
            Get.snackbar(S.of(context).Error, S.of(context).insetdata,
                backgroundColor: Colors.grey.withOpacity(0.6));
          } else {
            currentStep.value++;
          }
        } else {
          currentStep.value++;
        }
      }
    }
    else if (currentStep.value == 2) {
      if (proItem!.id.toString() == '1') {
        if (productN.text == '' ||
            nameAra.text == '' ||
            cost.text == '' ||
            price.text == '') {
          Get.snackbar(S.of(context).Error, S.of(context).insetdata,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          currentStep.value++;
        }
      } else if (proItem!.id.toString() == '3' ||
          proItem!.id.toString() == '4') {
        if (productN.text == '' || nameAra.text == '' || price.text == '') {
          Get.snackbar(S.of(context).Error, S.of(context).insetdata,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          currentStep.value++;
        }
      } else {
        currentStep.value++;
      }
    }
    else if (currentStep.value == 3) {
      if (proItem!.id.toString() == '1') {
        if (codeItel == null ||
            catItem == null ||
            unitItem == null ||
            taxMethodItem == null ||
            codeTexts.text == '' ||
            taxItem == null) {
          Get.snackbar(S.of(context).Error, S.of(context).insetdata,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          currentStep.value++;
        }
      } else if (proItem!.id.toString() == '3' ||
          proItem!.id.toString() == '4') {
        if (codeItel == null ||
            catItem == null ||
            taxMethodItem == null ||
            codeTexts.text == '') {
          Get.snackbar(S.of(context).Error, S.of(context).insetdata,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          currentStep.value++;
        }
      } else {
        currentStep.value++;
      }
    } else {
      AdProduct(context);
    }
  }

  void AdProduct(BuildContext context) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );
      dio.FormData? data;
      if (proItem!.id.toString() == '1') {
        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        data = new dio.FormData.fromMap({
          "token": token,
          "type": proItem!.name.toLowerCase(),
          "code": codeTexts.text,
          "name": productN.text,
          "second_name": nameAra.text,
          "cost": cost.text,
          "weight": weight.text,
          "barcode_symbology": codeItel!.name.toLowerCase(),
          "brand": brandItem == null ? null : brandItem!.id,
          "category": catItem!.id,
          "subcategory": subItem == null ? null : subItem!.id,
          "unit": unitItem!.id,
          "default_sale_unit": unitSaleItem == null ? null : unitSaleItem!.id,
          "default_purchase_unit": unitPurItem == null ? null : unitPurItem!.id,
          "promotion": isCheckedHide == false ? '' : '1',
          "promo_price": isCheckedHide == false ? '' : prop.text,
          "start_date": isCheckedHide == false ? '' : dates,
          "end_date": isCheckedHide == false ? '' : datee,
          "tax_rate": taxItem == null ? null : taxItem!.id,
          "tax_method": taxMethodItem == null ? null : taxMethodItem!.id,
          "alert_quantity": alert.text,
          "price": price.text,
          "product_details": proDetails.text,
          "details": proDetailsP.text,
          "product_image": imageFile != null
              ? await dio.MultipartFile.fromFile(imageFile!.path,
                  filename: imageFile!.path.split('/').last)
              : null,
        });
        int j = 0;
        if (supAdvdList.value.length > 0) {
          for (int i = 0; i < supAdvdList.length; i++) {
            if (i == 0) {
              data.fields.add(MapEntry(
                  "supplier", supAdvdList[i].supItemAdd.id.toString()));
              data.fields.add(MapEntry(
                  "supplier_price", supAdvdList[i].supp.text.toString()));

              data.fields.add(MapEntry(
                  "supplier_part_no", supAdvdList[i].supn.text.toString()));
            } else {
              j = i + 1;
              data.fields.add(MapEntry(
                  "supplier_$j", supAdvdList[i].supItemAdd.id.toString()));

              data.fields.add(MapEntry("supplier_" + j.toString() + "_price",
                  supAdvdList[i].supp.text.toString()));

              data.fields.add(MapEntry("supplier_" + j.toString() + "_part_no",
                  supAdvdList[i].supn.text.toString()));
            }
          }
        }
      }
      else if (proItem!.id.toString() == '3') {
        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        data = new dio.FormData.fromMap({
          "token": token,
          "type": proItem!.name.toLowerCase(),
          "code": codeTexts.text,
          "name": productN.text,
          "second_name": nameAra.text,
          "file_link": digi.text,
          //digital fileb
          "barcode_symbology": codeItel!.name.toLowerCase(),
          "brand": brandItem == null ? null : brandItem!.id,
          "category": catItem!.id,
          "subcategory": subItem == null ? null : subItem!.id,

          "promotion": isCheckedHide == false ? '' : '1',
          "promo_price": isCheckedHide == false ? '' : prop.text,
          "start_date": isCheckedHide == false ? '' : dates,
          "end_date": isCheckedHide == false ? '' : datee,
          "tax_rate": taxItem == null ? null : taxItem!.id,
          "tax_method": taxMethodItem == null ? null : taxMethodItem!.id,
          "price": price.text,
          "product_details": proDetails.text,
          "details": proDetailsP.text,
          "product_image": imageFile != null
              ? await dio.MultipartFile.fromFile(imageFile!.path,
                  filename: imageFile!.path.split('/').last)
              : null,
          "digital_file": imageFileDig != null
              ? await dio.MultipartFile.fromFile(imageFileDig!.path,
                  filename: imageFileDig!.path.split('/').last)
              : null,
        });
      }
      else if (proItem!.id.toString() == '4') {
        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        data = new dio.FormData.fromMap({
          "token": token,
          "type": proItem!.name.toLowerCase(),
          "code": codeTexts.text,
          "name": productN.text,
          "second_name": nameAra.text,
          //digital fileb
          "barcode_symbology": codeItel!.name.toLowerCase(),
          "brand": brandItem == null ? null : brandItem!.id,
          "category": catItem!.id,
          "subcategory": subItem == null ? null : subItem!.id,

          "promotion": isCheckedHide == false ? '' : '1',
          "promo_price": isCheckedHide == false ? '' : prop.text,
          "start_date": isCheckedHide == false ? '' : dates,
          "end_date": isCheckedHide == false ? '' : datee,
          "tax_rate": taxItem == null ? null : taxItem!.id,
          "tax_method": taxMethodItem == null ? null : taxMethodItem!.id,
          "price": price.text,
          "product_details": proDetails.text,
          "details": proDetailsP.text,
          "product_image": imageFile != null
              ? await dio.MultipartFile.fromFile(imageFile!.path,
                  filename: imageFile!.path.split('/').last)
              : null,
        });
      }
      else if (proItem!.id.toString() == '2') {
        double proprice = 0;
        for (int i = 0; i < productListSele.length; i++) {
          proprice = proprice +
              (double.parse(productListSele[i].pric.text) *
                  double.parse(productListSele[i].quan.text));
        }
        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        data = new dio.FormData.fromMap({
          "token": token,
          "type": proItem!.name.toLowerCase(),
          "code": codeTexts.text,
          "name": productN.text,
          "second_name": nameAra.text,
          "weight": weight.text,

          //digital fileb
          "barcode_symbology": codeItel!.name.toLowerCase(),
          "brand": brandItem == null ? null : brandItem!.id,
          "category": catItem!.id,
          "subcategory": subItem == null ? null : subItem!.id,

          "promotion": isCheckedHide == false ? '' : '1',
          "promo_price": isCheckedHide == false ? '' : prop.text,
          "start_date": isCheckedHide == false ? '' : dates,
          "end_date": isCheckedHide == false ? '' : datee,
          "tax_rate": taxItem == null ? null : taxItem!.id,
          "tax_method": taxMethodItem == null ? null : taxMethodItem!.id,
          "price": proprice.toString(),
          "product_details": proDetails.text,
          "details": proDetailsP.text,
          "product_image": imageFile != null
              ? await dio.MultipartFile.fromFile(imageFile!.path,
                  filename: imageFile!.path.split('/').last)
              : null,
        });
        for (int i = 0; i < productListSele.length; i++) {
          data.fields.add(MapEntry(
              "combo_item_id[$i]", productListSele[i].itemPro.id.toString()));
          data.fields.add(MapEntry("combo_item_name[$i]",
              productListSele[i].itemPro.name.toString()));
          data.fields.add(MapEntry("combo_item_code[$i]",
              productListSele[i].itemPro.code.toString()));
          data.fields.add(MapEntry("combo_item_quantity[$i]",
              productListSele[i].quan.text.toString()));
          data.fields.add(MapEntry(
              "combo_item_price[$i]", productListSele[i].pric.text.toString()));
        }
      }
      print(data!.fields);

      AddCustomerResponse result = await ProductApiProvider().addProduct(data);

      if (result.code == 200) {
        if (result.message.toString() == 'product_added') {
          Get.back();
          posController.onInit();
          proAllController.page=1;
          proAllController.onInit();
          Get.back();
        } else {
          String msg = result.message.replaceAll('<p>', '');
          String msgt = msg.replaceAll('</p>', '');

          Get.back();
          Get.snackbar(S.of(context).Error, msgt,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }  else if(result.code==503 && result.message.toString()=='Api feature is disabled'){
Get.back();
Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  void deletePro(BuildContext context, String proId) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );

      AddCustomerResponse result = await ProductApiProvider().deletePro(proId);

      if (result.code == 200) {
        if (result.error == 'null') {
          proAllController.page=1;
          proAllController.onInit();
          proAllController.getAllPro();
          posController.getPosDefault();

          Get.back();
        } else {
          Get.back();
          Get.snackbar(
              S.of(context).Error,
              result.message
                  .replaceAll('<p>', '')
                  .toString()
                  .replaceAll('</p>', ''),
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
      else if(result.code==503 && result.message.toString()=='Api feature is disabled'){
Get.back();        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      else {
        Get.snackbar(S.of(context).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }
}
