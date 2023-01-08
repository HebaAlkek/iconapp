import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/pdf_invoice_api.dart';
import 'package:icon/apiProvider/report_api_provider.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/biller_model.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/creatUser_model.dart';
import 'package:icon/model/customer_sale_model.dart';
import 'package:icon/model/inv_model.dart';
import 'package:icon/model/invoice.dart';
import 'package:icon/model/pos_model.dart';
import 'package:icon/screen/home_page.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:dio/dio.dart' as dio;
import 'package:icon/model/report_sale_model.dart';
import 'package:icon/model/title_lang_model.dart';
import 'package:icon/response/general_reponse.dart';
import 'package:icon/response/report_sale_response.dart';
import 'package:icon/response/report_taxs_response.dart';
import 'package:icon/screen/report/report_page.dart';
import 'package:icon/screen/report/report_sale_page.dart';

import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportController extends GetxController {
  var isLoading = false.obs;
  final reportTaxsListMore = [].obs;

  final reportTaxsList = [].obs;
  var isLoadingP = false.obs;
  final reportSaleList = [].obs;
  final reportSaleListmore = [].obs;
  bool search=false;
  TextEditingController searchMAin = TextEditingController();
  bool searchTax=false;
  TextEditingController searchMAinTax = TextEditingController();
  var isLoadingS = false.obs;
  EmployeeDataSource? employeeDataSource;
  int page = 1;
int pageTax=1;
  EmployeeDataSourceTax? employeeDataSourceTax;

  final reportTaxpList = [].obs;
  List<TitleLandModel> titleList = [
    TitleLandModel('Date', 'التاريخ'),
    TitleLandModel('Reference No', 'الرقم المرجعي'),
    TitleLandModel('Status', 'حالة البيع'),
    TitleLandModel('Warehouse', 'المستودع'),
    TitleLandModel('Biller', 'الكاشير'),
    TitleLandModel('Product Tax', 'ضريبة المنتج'),
    TitleLandModel('Order Tax', 'ضريبة الطلب'),
    TitleLandModel('Grand Total', 'المجموع العام'),
    TitleLandModel('Actions', 'الإجراءات'),
  ];
  List<TitleLandModel> titleSaleList = [
    TitleLandModel('Date', 'التاريخ'),
    TitleLandModel('Reference No', 'الرقم المرجعي'),
    TitleLandModel('Biller', 'الكاشير'),
    TitleLandModel('Customer', 'العميل'),
    TitleLandModel('Product (Qty)', 'كميات المنتجات'),
    TitleLandModel('Grand Total', 'المجموع العام'),
    TitleLandModel('Paid', 'المدفوع'),
    TitleLandModel('Balance', 'الرصيد'),
    TitleLandModel('Payment Status', 'حالة الدفع'),

    TitleLandModel('Actions', 'الإجراءات'),

  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getReportTaxs(BuildContext context) async {
    try {
      isLoading(true);
      reportTaxsList.clear();
      reportTaxsListMore.clear();
      pageTax=1;
      ReportTaxsResponse res = await ReportApiProvider().getReportTaxs(pageTax.toString());

      if (res.statuecode == 200) {
        reportTaxsList.clear();
        reportTaxsList.assignAll(res.listRep);
        pageTax=pageTax+10;
        getReportTaxsSec(context);
       // employeeDataSourceTax = EmployeeDataSourceTax(employeeData: reportTaxsList,contdext: context);

        //isLoading(false);
      } else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      //isLoading(false);
      update();
    }
  }
  void getReportTaxsSearch(BuildContext context) async {
    try {
      pageTax=1;
      isLoading(true);
      reportTaxsList.clear();

      reportTaxsListMore.clear();
      employeeDataSourceTax=EmployeeDataSourceTax(contdext: context,employeeData: []);

      Map<String, dynamic> dataId = ({
        "reference_no": searchMAinTax.text,
      });
      ReportTaxsResponse res = await ReportApiProvider().getReportTaxsSearch(pageTax.toString(),dataId);

      if (res.statuecode == 200) {
        reportTaxsList.clear();
        reportTaxsListMore.clear();

        reportTaxsList.assignAll(res.listRep);
        pageTax=pageTax+10;
        getReportTaxsSearchSec(context);

      }
      else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }


  void getReportTaxsSec(BuildContext context) async {
    try {


      ReportTaxsResponse res = await ReportApiProvider().getReportTaxs(pageTax.toString());

      if (res.statuecode == 200) {
        reportTaxsList.addAll(res.listRep);
        employeeDataSourceTax = EmployeeDataSourceTax(employeeData: reportTaxsList,contdext: context);

        isLoading(false);
      } else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoading(false);
      update();
    }
  }
  void getReportTaxsSearchSec(BuildContext context) async {
    try {

      Map<String, dynamic> dataId = ({
        "reference_no": searchMAinTax.text,
      });
      ReportTaxsResponse res = await ReportApiProvider().getReportTaxsSearch(pageTax.toString(),dataId);

      if (res.statuecode == 200) {


        reportTaxsList.addAll(res.listRep);
        employeeDataSourceTax = EmployeeDataSourceTax(employeeData: reportTaxsList,contdext: context);
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

  void getReportTaxp(BuildContext context) async {
    try {
      isLoadingP(true);
      reportTaxpList.clear();

      ReportTaxsResponse res = await ReportApiProvider().getReportTaxp();

      if (res.statuecode == 200) {
        reportTaxpList.clear();
        reportTaxpList.assignAll(res.listRep);
        // employeeDataSourceTaxP = EmployeeDataSourceTax(employeeData: reportTaxpList);

        isLoadingP(false);
      } else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingP(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingP(false);
      update();
    }
  }

  void getReportSale(BuildContext context) async {
    try {
      isLoadingS(true);
      reportSaleList.clear();
page = 1;
      ReportSaleResponse res = await ReportApiProvider().getReportSale(page.toString());

      if (res.statuecode == 200) {
        reportSaleList.clear();
        reportSaleList.assignAll(res.listRep);
        page = page+10;
        getReportSaleSec(context);
      } else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingS(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }
  void getReportSaleSearch(BuildContext context,String search) async {
    try {
      isLoadingS(true);
      employeeDataSource=EmployeeDataSource(contdext: context,employeeData: []);
      reportSaleList.clear();
      reportSaleListmore.clear();

      page=1;
      Map<String, dynamic> dataId = ({
        "reference_no": searchMAin.text,
      });
      ReportSaleResponse res = await ReportApiProvider().getReportSaleSearch(page.toString(),dataId);

      if (res.statuecode == 200) {
        reportSaleList.clear();
        reportSaleList.assignAll(res.listRep);
        page = page+10;
        getReportSaleSecSearch(context);

      } else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingS(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {

      update();
    }
  }

  void getReportSaleSec(BuildContext context) async {
    try {

      ReportSaleResponse res = await ReportApiProvider().getReportSale(page.toString());

      if (res.statuecode == 200) {
        reportSaleList.addAll(res.listRep);
        employeeDataSource = EmployeeDataSource(employeeData: reportSaleList,contdext: context);
        isLoadingS(false);
      }else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingS(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingS(false);
      update();
    }
  }
  void getReportSaleSecSearch(BuildContext context) async {
    try {
      Map<String, dynamic> dataId = ({
        "reference_no": searchMAin.text,
      });
      ReportSaleResponse res = await ReportApiProvider().getReportSaleSearch(page.toString(),dataId);

      if (res.statuecode == 200) {
        reportSaleList.addAll(res.listRep);
        employeeDataSource = EmployeeDataSource(employeeData: reportSaleList,contdext: context);
        isLoadingS(false);
      }else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingS(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingS(false);
      update();
    }
  }

  void getReportSaleMore(BuildContext context) async {
    try {


      ReportSaleResponse res = await ReportApiProvider().getReportSale(page.toString());

      if (res.statuecode == 200) {
        reportSaleList.addAll(res.listRep);
    employeeDataSource = EmployeeDataSource(employeeData: reportSaleList,contdext: context);
      }else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingS(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }
  void getReportSaleMoreSearch(BuildContext context,String search) async {
    try {

      Map<String, dynamic> dataId = ({
        "reference_no": searchMAin.text,
      });
      ReportSaleResponse res = await ReportApiProvider().getReportSaleSearch(page.toString(),dataId);

      if (res.statuecode == 200) {
        reportSaleList.addAll(res.listRep);
        employeeDataSource = EmployeeDataSource(employeeData: reportSaleList,contdext: context);
      }else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingS(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  List getEmployeeData() {
    return
      reportSaleList.value;
  }
}
