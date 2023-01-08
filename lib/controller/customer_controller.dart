import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icon/apiProvider/customer_api_provider.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/customer_group_model.dart';
import 'package:icon/model/price_group_model.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/customer_details_response.dart';
import 'package:icon/response/customer_reponse.dart';
import 'package:dio/dio.dart' as dio;
import 'package:icon/screen/home_page.dart';
import 'package:icon/utils/app_constant.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerController extends GetxController {
  var isLoading = false.obs;
  var isLoadingDetails = false.obs;

  final customerList = [].obs;
  var isLoadingAdd = false.obs;
  TextEditingController customerFO = TextEditingController();
  TextEditingController customerFT = TextEditingController();
  TextEditingController customerFTh = TextEditingController();
  TextEditingController customerFF = TextEditingController();
  TextEditingController customerFFi = TextEditingController();
  TextEditingController customerFSe = TextEditingController();
  PosController posController = Get.put(PosController());

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  var currentStep = 0.obs;
  TextEditingController companyN = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController vatNum = TextEditingController();
  TextEditingController gstNum = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postCode = TextEditingController();

  final priList = [].obs;
  CustomerGroupList? groupItem;
  PriceGroupList? priceItem;

  @override
  void onInit() {

    // TODO: implement onInit
    super.onInit();
  }

  void getCustomerList() async {
    try {
      isLoading(true);
      customerList.clear();
      priList.clear();

      CustomerResponse res = await CustomerApiProvider().getCustomerList();

      if (res.statuecode == 200) {
        customerList.clear();
        priList.clear();
        customerList.assignAll(res.customerList);
        groupItem=customerList[0];
        priList.assignAll(res.priceList);
        priceItem = priList[0];

        isLoading(false);
      }    else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      else {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, res.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void getCustomerDetails(String customerId) async {
    currentStep.value = 0;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? token = sharedPrefs.getString('token');
    try {
      isLoadingDetails(true);
      customerList.clear();
      priList.clear();
      dio.FormData data = new dio.FormData.fromMap({
        "token": token,
      });
      CustomerDetailsResponse res =
          await CustomerApiProvider().getCustomerDetails(customerId, data);

      if (res.statuecode == 200) {
        customerList.clear();
        priList.clear();
        customerList.assignAll(res.customerGroupList);
        priList.assignAll(res.priceList);
        for (int i = 0; i < customerList.length; i++) {
          if (customerList[i].id.toString() ==
              res.customerDe.customer_group_id.toString()) {
            groupItem = customerList[i];
          }
        }

        for (int i = 0; i < priList.length; i++) {
          if (priList[i].id.toString() ==
              res.customerDe.price_group_id.toString()) {
            priceItem = priList[i];
          }
        }
        country.text = res.customerDe.country;
        city.text = res.customerDe.city;
        companyN.text = res.customerDe.company;
        name.text = res.customerDe.name;
        vatNum.text = res.customerDe.vat_no;
        gstNum.text = res.customerDe.gst_no;
        email.text = res.customerDe.email;
        phone.text = res.customerDe.phone;
        address.text = res.customerDe.address;
        postCode.text = res.customerDe.postal_code;

        isLoadingDetails(false);
      }
      else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingDetails(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      else {
        isLoadingDetails(false);
        Get.snackbar(S.of(Get.context!).Error, res.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingDetails(false);
      update();
    }
  }

  void AddCustomer(dio.FormData data) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );

      isLoadingAdd(true);

      AddCustomerResponse result =
          await CustomerApiProvider().addCustomer(data);

      if (result.code == 200) {
        posController.onInit();

        isLoadingAdd(false);
        Get.back();
        Get.back();
        Get.delete<CustomerController>();
      }  else if(result.code==503 && result.message.toString()=='Api feature is disabled'){
Get.back();
isLoadingAdd(false);
Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      else {
Get.back();
isLoadingAdd(false);
Get.snackbar(S.of(Get.context!).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingAdd(false);

      update();
    }
  }

  void EditCustomer(dio.FormData data, String id) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );

      isLoadingAdd(true);

      AddCustomerResponse result =
          await CustomerApiProvider().EditCustomer(id, data);

      if (result.code == 200) {

        posController.onInit();

        isLoadingAdd(false);
        Get.back();
        Get.back();
        getCustomerList();
        Get.delete<CustomerController>();

      } else if(result.code==503 && result.message.toString()=='Api feature is disabled'){
        Get.back();
        isLoadingAdd(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      else {
        Get.back();
        isLoadingAdd(false);
        Get.snackbar(S.of(Get.context!).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingAdd(false);

      update();
    }
  }

  void deleteCustomer(BuildContext context, String cutmerId) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );

      AddCustomerResponse result =
          await CustomerApiProvider().deleteCustomer(cutmerId);

      if (result.code == 200) {
        if (result.error == 'null') {
          if (result.message.toString() == 'customer_x_deleted_have_sales') {
            Get.back();

            Get.snackbar(S.of(context).Error, S.of(context).deletecu,
                backgroundColor: Colors.grey.withOpacity(0.6),
                duration: Duration(seconds: 10));
          } else {
            posController.onInit();
            getCustomerList();
            Get.back();
          }
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
      } else if(result.code==503 && result.message.toString()=='Api feature is disabled'){
        Get.back();
        isLoadingAdd(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      else {
        Get.back();
        isLoadingAdd(false);
        Get.snackbar(S.of(Get.context!).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  Future<void> nextStep(BuildContext context, String type, String id) async {
    if (currentStep.value == 0) {
      /*  if (country.text == '' ||
             city.text == '' ||
             state.text == '' ||
             groupItem == null ||
             priceItem == null) {

         } else {*/
      currentStep.value++;
      // }
    } else if (currentStep.value == 1) {
      if (name.text == '') {
        Get.snackbar(S.of(context).Error, S.of(context).inserrtn,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        if (email.text == '') {
          SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
          String? token = sharedPrefs.getString('token');
          dio.FormData data = new dio.FormData.fromMap({
            "token": token,
            "customer_group": groupItem == null ? null : groupItem!.id,
            "price_group": priceItem == null ? null : priceItem!.id,
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
            /*   "cf1": customerFO.text,
          "cf2": customerFT.text,
          "cf3": customerFTh.text,
          "cf4": customerFF.text,
          "cf5": customerFFi.text,
          "cf6": customerFSe.text,*/
          });
          if (type == '2') {
            EditCustomer(data, id);
          } else {
            AddCustomer(data);
          }
        } else {
          if (EmailValidator.validate(email.text)) {
            SharedPreferences sharedPrefs =
                await SharedPreferences.getInstance();
            String? token = sharedPrefs.getString('token');
            dio.FormData data = new dio.FormData.fromMap({
              "token": token,
              "customer_group": groupItem == null ? null : groupItem!.id,
              "price_group": priceItem == null ? null : priceItem!.id,
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
              /*   "cf1": customerFO.text,
          "cf2": customerFT.text,
          "cf3": customerFTh.text,
          "cf4": customerFF.text,
          "cf5": customerFFi.text,
          "cf6": customerFSe.text,*/
            });

            if (type == '2') {
              EditCustomer(data, id);
            } else {
              AddCustomer(data);
            }
          } else {
            Get.snackbar(S.of(context).Error, S.of(context).valid,
                backgroundColor: Colors.grey.withOpacity(0.6));
          }
        }
      }
    } /*else {
      if (customerFO.text == '' ||
          customerFT.text == '' ||
          customerFTh.text == '' ||
          customerFF.text == '' ||
          customerFFi.text == '' ||
          customerFSe.text == '') {
        Get.snackbar(S.of(context).Error, 'Please insert all data',
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
    }
    }*/
  }
}
