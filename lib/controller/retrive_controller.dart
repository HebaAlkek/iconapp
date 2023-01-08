import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/report_api_provider.dart';
import 'package:icon/apiProvider/retrive_api_provider.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';

import 'package:dio/dio.dart' as dio;
import 'package:icon/model/product_retrive_model.dart';
import 'package:icon/model/retrive_save_model.dart';

import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/reference_response.dart';
import 'package:icon/response/ret_details_response.dart';
import 'package:icon/response/ret_purchases_response.dart';

import 'package:icon/response/retrive_reponse.dart';
import 'package:icon/response/returnpur_response.dart';
import 'package:icon/screen/home_page.dart';
import 'package:icon/screen/purchases/purchases_page.dart';
import 'package:icon/screen/retive_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RetriveController extends GetxController {
  var isLoading = false.obs;
  var isLoadingAdd = false.obs;
  List<REtriveSaveModel> revSaveistGet = [];
  bool insert = false;
  String invId = '';
  final revProductListLast = [].obs;

  final revProductList = [].obs;
  RxDouble totalprice = 0.0.obs;
  RxDouble quanvisi=0.0.obs;
  RxDouble grandTotal = 0.0.obs;
  RxDouble totalpriceFirst = 0.0.obs;
  var isLoadingList = false.obs;
  final refList = [].obs;
  RxInt quantityFirst = 0.obs;
  String retPurId='';
  RxInt quantity = 0.obs;
  PosController posController = Get.put(PosController());
  int page = 1;
  RefreshController refreshControllerPos =
      RefreshController(initialRefresh: false);
  RxString valueText = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    page = 1;

    getRetriveList(valueText.value, Get.context!);
    refreshControllerPos.refreshCompleted();

    print('fgbfg');
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page = page + 10;
    print('lolo');
    getRetriveListMore(valueText.value, Get.context!);

    refreshControllerPos.loadComplete();
  }

  void getRetriveSale(String saleId, BuildContext context) async {
    try {
      totalprice.value = 0.0;
      grandTotal.value = 0.0;
      insert = false;
      quantity.value = 0;
      totalpriceFirst.value=0.0;
      quantityFirst.value=0;
      isLoading(true);
      revProductList.clear();
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      Map<String, dynamic> data = ({"id": saleId});

      dio.FormData dataMap = new dio.FormData.fromMap({
        "token": token,
      });
      print(data);
      RetriveResponse res =
          await RetriveApiProvider().getRetriveSale(data, dataMap);

      if (res.statuecode == 200) {
        final SharedPreferences sharedPrefs =
            await SharedPreferences.getInstance();

        String? orderL = sharedPrefs.getString('graphLists');
        if (orderL != null) {
          revSaveistGet = (json.decode(orderL) as List<dynamic>)
              .map<REtriveSaveModel>((item) => REtriveSaveModel.fromJson(item))
              .toList();
        }
        if (revSaveistGet.length != 0) {
          for (int i = 0; i < revSaveistGet.length; i++) {
            if (revSaveistGet[i].invId.toString() == res.invId.toString()) {

              totalprice.value =
                  double.parse(revSaveistGet[i].grandTotal.toString());
              grandTotal.value =
                  double.parse(revSaveistGet[i].grandTotal.toString());
              quantity.value =
                  int.parse(revSaveistGet[i].total_items.toString());
              revProductList.addAll(revSaveistGet[i].students);
          //    revProductListLast.add(revSaveistGet[i].students);
              for (int i = 0; i < revProductList.length; i++) {
                /* revProductList[i].quanText.text =
                    revProductList[i].qty.toString().split('.')[0];*/
                if (revProductList.value[i].tax_method.toString() != '1') {
                  revProductList.value[i].lastPrice =
                      revProductList.value[i].unit_price;
                } else {
                  if (revProductList.value[i].type_tax.toString() == '1') {
                    revProductList.value[i].lastPrice = (((double.parse(
                                        revProductList.value[i].unit_price) *
                                    double.parse(
                                        revProductList.value[i].rate)) /
                                100) +
                            double.parse(revProductList.value[i].unit_price))
                        .toStringAsFixed(2);
                  } else {
                    revProductList.value[i].lastPrice = (double.parse(
                                revProductList.value[i].rate) +
                            double.parse(revProductList.value[i].unit_price))
                        .toString();
                  }
                }
              }
              insert = true;
              totalpriceFirst.value = totalprice.value;

              isLoading(false);

              break;
            }
          }
          if (insert == false) {
            revProductList.value.assignAll(res.students.values);
            totalprice.value = double.parse(res.grandTotal);
            grandTotal.value = double.parse(res.grandTotal);
            invId = res.invId;
            quantity.value = int.parse(res.total_items);

            for (int i = 0; i < revProductList.length; i++) {
              /*      revProductList[i].quanText.text =
                  revProductList[i].qty.toString().split('.')[0];*/
              if (revProductList.value[i].tax_method.toString() != '1') {
                revProductList.value[i].lastPrice =
                    revProductList.value[i].unit_price;
              } else {
                if (revProductList.value[i].type_tax.toString() == '1') {
                  revProductList.value[i].lastPrice = (((double.parse(
                                      revProductList.value[i].unit_price) *
                                  double.parse(revProductList.value[i].rate)) /
                              100) +
                          double.parse(revProductList.value[i].unit_price))
                      .toStringAsFixed(2);
                } else {
                  revProductList.value[i].lastPrice =
                      (double.parse(revProductList.value[i].rate) +
                              double.parse(revProductList.value[i].unit_price))
                          .toString();
                }
              }
            }
            totalpriceFirst.value = totalprice.value;

            isLoading(false);
          }
          revProductList.value.reversed.toList();

        } else {
          revProductList.value.assignAll(res.students.values);
          revProductList.value.reversed.toList();
          totalprice.value = double.parse(res.grandTotal);
          grandTotal.value = double.parse(res.grandTotal);

          invId = res.invId;
          quantity.value = int.parse(res.total_items);

          for (int i = 0; i < revProductList.length; i++) {
            /* revProductList[i].quanText.text =
                revProductList[i].qty.toString().split('.')[0];*/
            if (revProductList.value[i].tax_method.toString() != '1') {
              revProductList.value[i].lastPrice =
                  revProductList.value[i].unit_price;
            } else {
              if (revProductList.value[i].type_tax.toString() == '1') {
                revProductList.value[i].lastPrice = (((double.parse(
                                    revProductList.value[i].unit_price) *
                                double.parse(revProductList.value[i].rate)) /
                            100) +
                        double.parse(revProductList.value[i].unit_price))
                    .toStringAsFixed(2);
              } else {
                revProductList.value[i].lastPrice =
                    (double.parse(revProductList.value[i].rate) +
                            double.parse(revProductList.value[i].unit_price))
                        .toString();
              }
            }
          }
          totalpriceFirst.value = totalprice.value;

          isLoading(false);
        }
      } else if (res.statuecode == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      quanvisi.value=0.0;
      revProductListLast.assignAll(revProductList.reversed);
      for(int i=0;i<revProductListLast.length;i++){
     quanvisi.value=quanvisi.value+  double.parse(revProductListLast[i]
         .qtybase );
      }
      isLoading(false);

      update();
    }
  }

  void getRetriveList(String saleId, BuildContext context) async {
    try {
      valueText.value = saleId;
      isLoadingList(true);
      refList.clear();
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      Map<String, dynamic> data = ({"reference_no": saleId});
      print(data);
      dio.FormData dataMap = new dio.FormData.fromMap({
        "token": token,
      });
      print(token);
      ReferenceResponse res =
          await RetriveApiProvider().getRetriveList(data, dataMap);

      if (res.code == 200) {
        refList.assignAll(res.refList);
        isLoadingList(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingList(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingList(false);

      update();
    }
  }


  void getRetriveListPurchases(String saleId) async {
    try {
      isLoadingList(true);
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      Map<String, dynamic> data = ({"reference_no": saleId});
      print(data);
      dio.FormData dataMap = new dio.FormData.fromMap({
        "token": token,
      });
      print(token);
      REturnPurchasesREsponse res =
      await RetriveApiProvider().getRetriveListPurchases(data, dataMap);

      if (res.code == 200) {
        retPurId=res.retPurId;
        print('oo'+retPurId.toString());
        isLoadingList(false);
        Get.back();
        Get.off(() => RetrivePage(retPurId,'2'));
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingList(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingList(false);

      update();
    }
  }



  void getRetriveListMore(String saleId, BuildContext context) async {
    try {
      valueText.value = saleId;
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      Map<String, dynamic> data = ({"reference_no": saleId});
      print(data);
      dio.FormData dataMap = new dio.FormData.fromMap({
        "token": token,
      });
      print(token);
      ReferenceResponse res =
      await RetriveApiProvider().getRetriveList(data, dataMap);

      if (res.code == 200) {
        refList.addAll(res.refList);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingList(false);

      update();
    }
  }

  void AddReturns(
      dio.FormData data, BuildContext context, String saleId) async {
    try {
      isLoadingAdd(true);
      Map<String, dynamic> dataId = ({"id": saleId});
      AddCustomerResponse result =
          await RetriveApiProvider().AddReturns(data, dataId);

      if (result.code == 200) {
        isLoadingAdd(false);
        final prefs = await SharedPreferences.getInstance();

        if (revSaveistGet.length != 0) {
          for (int i = 0; i < revSaveistGet.length; i++) {
            if (revSaveistGet[i].invId.toString() == invId.toString()) {
              revSaveistGet.removeAt(i);
            }
          }
        }
        revSaveistGet.add(REtriveSaveModel(
            students: revProductList,
            grandTotal: totalprice.value,
            total_items: quantity.value,
            invId: invId));
        String fgfh = json.encode(
          revSaveistGet
              .map<Map<String, dynamic>>(
                  (music) => REtriveSaveModel.toMap(music))
              .toList(),
        );
        prefs.setString('graphLists', fgfh);
        //  getSP();
        totalprice.value = 0.0;
        quantity.value = 0;
        totalpriceFirst.value = 0.0;
        quantityFirst.value = 0;
        posController.printReportREturned(result.invoice, '1');

        /* if (result.error == 'null') {
          if (result.message.toString() == 'customer_x_deleted_have_sales') {
            Get.back();

            Get.snackbar(S.of(context).Error, S.of(context).deletecu,
                backgroundColor: Colors.grey.withOpacity(0.6),
                duration: Duration(seconds: 10));
          } else {


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
        }*/
      } else if (result.code == 503 &&
          result.message.toString() == 'Api feature is disabled') {
        isLoadingAdd(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        isLoadingAdd(false);

        Get.snackbar(S.of(context).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }



  void AddReturnsPur(
      dio.FormData data, BuildContext context, String saleId) async {
    try {
      isLoadingAdd(true);
      Map<String, dynamic> dataId = ({"id": saleId});
      ReturnPurResponse result =
      await RetriveApiProvider().AddReturnsPur(data, dataId);

      if (result.code == 200) {
        isLoadingAdd(false);
     /*   final prefs = await SharedPreferences.getInstance();

        if (revSaveistGet.length != 0) {
          for (int i = 0; i < revSaveistGet.length; i++) {
            if (revSaveistGet[i].invId.toString() == invId.toString()) {
              revSaveistGet.removeAt(i);
            }
          }
        }
        revSaveistGet.add(REtriveSaveModel(
            students: revProductList,
            grandTotal: totalprice.value,
            total_items: quantity.value,
            invId: invId));
        String fgfh = json.encode(
          revSaveistGet
              .map<Map<String, dynamic>>(
                  (music) => REtriveSaveModel.toMap(music))
              .toList(),
        );
        prefs.setString('graphLists', fgfh);
        //  getSP();
        totalprice.value = 0.0;
        quantity.value = 0;
        totalpriceFirst.value = 0.0;
        quantityFirst.value = 0;
     //   posController.printReportREturned(result.invoice, '1');
*/
        Get.off(() => PurchasesPage(
          posController.WareL.value,
        ));
      } else if (result.code == 503 &&
          result.message.toString() == 'Api feature is disabled') {
        isLoadingAdd(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        isLoadingAdd(false);

        Get.snackbar(S.of(context).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }


  void getPurDetails(String saleId, BuildContext context) async {
    try {
      totalprice.value = 0.0;
      grandTotal.value = 0.0;
      insert = false;
      quantity.value = 0;
      totalpriceFirst.value=0.0;
      quantityFirst.value=0;
      isLoading(true);
      revProductList.clear();
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
    //  Map<String, dynamic> data = ({"id": saleId});

      dio.FormData dataMap = new dio.FormData.fromMap({
        "token": token,
        "id": saleId
      });
      REtPurchasesDetails res =
      await RetriveApiProvider().getPurDetails( dataMap);

      if (res.statuecodew == 200) {
        final SharedPreferences sharedPrefs =
        await SharedPreferences.getInstance();

        String? orderL = sharedPrefs.getString('graphLists');
        if (orderL != null) {
          revSaveistGet = (json.decode(orderL) as List<dynamic>)
              .map<REtriveSaveModel>((item) => REtriveSaveModel.fromJson(item))
              .toList();
        }
        if (revSaveistGet.length != 0) {
          for (int i = 0; i < revSaveistGet.length; i++) {
            if (revSaveistGet[i].invId.toString() == res.invId.toString()) {

              totalprice.value =
                  double.parse(revSaveistGet[i].grandTotal.toString());
              grandTotal.value =
                  double.parse(revSaveistGet[i].grandTotal.toString());
              quantity.value =
                  int.parse(revSaveistGet[i].total_items.toString());
              revProductList.addAll(revSaveistGet[i].students);
              //    revProductListLast.add(revSaveistGet[i].students);
              for (int i = 0; i < revProductList.length; i++) {
                /* revProductList[i].quanText.text =
                    revProductList[i].qty.toString().split('.')[0];*/
                if (revProductList.value[i].tax_method.toString() != '1') {
                  revProductList.value[i].lastPrice =
                      revProductList.value[i].unit_price;
                } else {
                  if (revProductList.value[i].type_tax.toString() == '1') {
                    revProductList.value[i].lastPrice = (((double.parse(
                        revProductList.value[i].unit_price) *
                        double.parse(
                            revProductList.value[i].rate)) /
                        100) +
                        double.parse(revProductList.value[i].unit_price))
                        .toStringAsFixed(2);
                  } else {
                    revProductList.value[i].lastPrice = (double.parse(
                        revProductList.value[i].rate) +
                        double.parse(revProductList.value[i].unit_price))
                        .toString();
                  }
                }
              }
              insert = true;
              totalpriceFirst.value = totalprice.value;

              isLoading(false);

              break;
            }
          }
          if (insert == false) {
            revProductList.value.assignAll(res.students);
         //   totalprice.value = double.parse(res.grandTotal);
           // grandTotal.value = double.parse(res.grandTotal);
            invId = res.invId;
           // quantity.value = int.parse(res.total_items);

            for (int i = 0; i < revProductList.length; i++) {
              /*      revProductList[i].quanText.text =
                  revProductList[i].qty.toString().split('.')[0];*/
              if (revProductList.value[i].tax_method.toString() != '1') {
                revProductList.value[i].lastPrice =
                    revProductList.value[i].unit_price;
              } else {
                if (revProductList.value[i].type_tax.toString() == '1') {
                  revProductList.value[i].lastPrice = (((double.parse(
                      revProductList.value[i].unit_price) *
                      double.parse(revProductList.value[i].rate)) /
                      100) +
                      double.parse(revProductList.value[i].unit_price))
                      .toStringAsFixed(2);
                } else {
                  revProductList.value[i].lastPrice =
                      (double.parse(revProductList.value[i].rate) +
                          double.parse(revProductList.value[i].unit_price))
                          .toString();
                }
              }
            }
            totalpriceFirst.value = totalprice.value;

            isLoading(false);
          }
          revProductList.value.reversed.toList();

        } else {
          revProductList.value.assignAll(res.students);
          revProductList.value.reversed.toList();
         // totalprice.value = double.parse(res.grandTotal);
       //   grandTotal.value = double.parse(res.grandTotal);

          invId = res.invId;
         // quantity.value = int.parse(res.total_items);

          for (int i = 0; i < revProductList.length; i++) {
            /* revProductList[i].quanText.text =
                revProductList[i].qty.toString().split('.')[0];*/
            if (revProductList.value[i].tax_method.toString() != '1') {
              revProductList.value[i].lastPrice =
                  revProductList.value[i].unit_price;
            } else {
              if (revProductList.value[i].tax_method.toString() == '1') {
                revProductList.value[i].lastPrice = (((double.parse(
                    revProductList.value[i].unit_price) *
                    double.parse(revProductList.value[i].rate)) /
                    100) +
                    double.parse(revProductList.value[i].unit_price))
                    .toStringAsFixed(2);
              } else {
                revProductList.value[i].lastPrice =
                    (double.parse(revProductList.value[i].rate) +
                        double.parse(revProductList.value[i].unit_price))
                        .toString();
              }
            }
          }
          totalpriceFirst.value = totalprice.value;

          isLoading(false);
        }
      } else if (res.statuecodew == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      quanvisi.value=0.0;
      revProductListLast.assignAll(revProductList.reversed);
      for(int i=0;i<revProductListLast.length;i++){
        quanvisi.value=quanvisi.value+  double.parse(revProductListLast[i]
            .qtybase );
      }
      isLoading(false);

      update();
    }
  }


  void getSP() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    String orderL = sharedPrefs.getString('graphLists')!;
    if (orderL != null) {
      revSaveistGet = (json.decode(orderL) as List<dynamic>)
          .map<REtriveSaveModel>((item) => REtriveSaveModel.fromJson(item))
          .toList();
    }
    print(revSaveistGet.length);
  }
}
