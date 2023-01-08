import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icon/controller/product_controller.dart';

import 'package:icon/generated/l10n.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/supplier_model.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/purchases_response.dart';
import 'package:icon/screen/purchases/add_purchases_page.dart';
import 'package:icon/screen/purchases/purchases_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiProvider/purchases_api_provider.dart';

class PurchasesController extends GetxController {
  var isLoading = false.obs;
  final purList = [].obs;
  final purListAll = [].obs;
  TextEditingController searchMAinTax = TextEditingController();
  bool filter = false;

  EmployeeDataSource? employeeDataSource;
  var currentStep = 0.obs;
  RxString dates = ''.obs;
  TextEditingController note = TextEditingController();

  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void AddPurchase(
      BuildContext context,
      WarehouseModelList wareItem,
      SupplierModelList subItem,
      String status,
      List<ProductModdelList> itempvro) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );

      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      dio.FormData data = new dio.FormData.fromMap({
        "token": token,
        "date": dates,
        "warehouse": wareItem.id,
        "supplier": subItem.id,
        "supplier_id":subItem.id,
        "status": status,
        "note": note.text,
      });
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_id[$i]",
            itempvro[i].id.toString()));
      }
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product[$i]",
            itempvro[i].code.toString()));
      }
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_name[$i]",
            itempvro[i].name.toString()));
      }
     /* for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_option[$i]",
            'false'));
      }*/
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "net_cost[$i]",
            itempvro[i].net_price.toString()));
      }
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "unit_cost[$i]",
            itempvro[i].unit_price.toString()));
      }
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "real_unit_cost[$i]",
            itempvro[i].unit_price.toString()));
      }
     /* for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "quantity_balance[$i]",
            itempvro[i].quantitySel.toString()));
      }*/
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "quantity[$i]",
            itempvro[i].quantitySel.toString()));
      }
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_base_quantity[$i]",
            itempvro[i].quantitySel.toString()));
      }
  /*    for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_unit[$i]",
            itempvro[i].unitItem.id.toString()));
      }
*/
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_discount[$i]",
           '0'));
      }
      for (int i = 0;
      i < itempvro.length;
      i++) {
        data.fields.add(MapEntry(
            "product_tax[$i]",
            itempvro[i].texes.id.toString()));
      }
      print(data.fields);
      AddCustomerResponse result =
          await PurchasesApiProvider().AddPurchase(data);
      ProductController proController = Get.put(ProductController());

      if (result.code == 200 && result.error == 'null') {
        proController.productListSele.clear();
        Get.delete<PurchasesController>();

        getPurchasesList(context);

        Get.back();
        Get.back();
      } else if (result.code == 200 && result.error != '') {
        Get.back();
        Get.snackbar(S.of(Get.context!).Error, result.error,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else if (result.code == 503 &&
          result.message.toString() == 'Api feature is disabled') {
        Get.back();
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.back();
        Get.snackbar(S.of(Get.context!).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }
  void getPurchasesListFilter(BuildContext context) async {
    try {


      purList.clear();
      if (filter == false) {
        purListAll
            .sort((a, b) => b.date.compareTo(a.date));
        filter=true;
      } else {
        purListAll
            .sort((a, b) => a.date.compareTo(b.date));
        filter=false;

      }
      purList.addAll(purListAll);
      employeeDataSource =
          EmployeeDataSource(employeeData: purList, contdext: context);

    } finally {
      update();
    }
  }

  void getPurchasesList(BuildContext context) async {
    try {
      isLoading(true);

      purList.clear();
      purListAll.clear();

      PurchasesResponse res = await PurchasesApiProvider().getPurList();

      if (res.statuecode == 200) {
        purList.clear();
        purListAll.clear();
        purList.assignAll(res.purList);
        purListAll.assignAll(res.purList);

        employeeDataSource =
            EmployeeDataSource(employeeData: purList, contdext: context);

        isLoading(false);
      } else if (res.statuecode == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
      update();
    }
  }
}
