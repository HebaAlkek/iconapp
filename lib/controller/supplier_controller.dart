import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icon/apiProvider/supplier_api_provider.dart';

import 'package:icon/generated/l10n.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/supplier_response.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierController extends GetxController {
  var isLoading = false.obs;
  final supplierList = [].obs;
  final supplierListSearch = [].obs;
  TextEditingController searchSupplier = TextEditingController();

  TextEditingController companyN = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController vatNum = TextEditingController();
  TextEditingController gstNum = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postCode = TextEditingController();
  var currentStep = 0.obs;

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  void onInit() {
    getSupplierList();

    // TODO: implement onInit
    super.onInit();
  }

  void deleteSupplier(BuildContext context, String suppId) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );
      dio.FormData data = new dio.FormData.fromMap({"id": int.parse(suppId)});
      AddCustomerResponse result =
          await SupplierApiProvider().deleteSupplier(suppId, data);

      if (result.code == 200) {
        if (result.error == 'null') {
          Get.back();
          getSupplierList();
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

  void getSupplierList() async {
    try {
      isLoading(true);
      supplierListSearch.clear();
      supplierList.clear();

      SupplierResponse res = await SupplierApiProvider().getSupplierList();

      if (res.statuecode == 200) {
        supplierList.clear();

        supplierList.assignAll(res.suppList);
        supplierListSearch.assignAll(res.suppList);

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

  void AddSupplier() async {
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
        "city": city.text,
        "state": state.text,
        "country": country.text,
        "company": companyN.text,
        "vat_no": vatNum.text,
        "gst_no": gstNum.text,
        "email": email.text,
        "name": name.text,
        "phone": phone.text,
        "address": address.text,
        "postal_code": postCode.text,
      });
      AddCustomerResponse result =
          await SupplierApiProvider().AddSupplier(data);

      if (result.code == 200) {
        getSupplierList();

        Get.back();
        Get.back();
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

  void EditSupplier(String id) async {
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
        "city": city.text,
        "state": state.text,
        "country": country.text,
        "company": companyN.text,
        "vat_no": vatNum.text,
        "gst_no": gstNum.text,
        "email": email.text,
        "name": name.text,
        "phone": phone.text,
        "address": address.text,
        "postal_code": postCode.text,
      });
      AddCustomerResponse result =
          await SupplierApiProvider().EditSupplier(data, id);

      if (result.code == 200) {
        Get.back();
        Get.back();
        getSupplierList();
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
}
