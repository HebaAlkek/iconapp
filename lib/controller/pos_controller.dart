import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/model/permission_model.dart';
import 'package:icon/model/product_sale_model.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:icon/response/login_guest_response.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/LanguageChangeProvider.dart';
import 'package:icon/apiProvider/pdf_invoice_api.dart';
import 'package:icon/apiProvider/pdf_print_report_api.dart';
import 'package:icon/apiProvider/pos_api_provider.dart';
import 'package:icon/apiProvider/product_api_provider.dart';
import 'package:icon/apiProvider/report_api_provider.dart';
import 'package:icon/controller/category_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/main.dart';
import 'package:icon/model/biller_model.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/creatUser_model.dart';
import 'package:icon/model/customer_sale_model.dart';
import 'package:icon/model/inv_model.dart';
import 'package:icon/model/invoice.dart';
import 'package:icon/model/pos_model.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/cash_response.dart';
import 'package:icon/response/code_response.dart';
import 'package:icon/response/general_reponse.dart';
import 'package:icon/response/logo_response.dart';
import 'package:icon/response/pos_response.dart';
import 'package:icon/response/print_reponse.dart';
import 'package:icon/response/product_response.dart';
import 'package:icon/response/sub_cat_response.dart';
import 'package:icon/screen/home_page.dart';
import 'package:icon/screen/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PosController extends GetxController {
  var isLoading = false.obs;
  var isLoadingLogo = false.obs;
  String logog = '';
  RxBool scanIs = false.obs;

  int pagePos = 1;
  TextEditingController searchCustomer = TextEditingController();
  TextEditingController searchPro = TextEditingController();
  TextEditingController searchSub = TextEditingController();
  TextEditingController searchMAin = TextEditingController();
  TextEditingController searchBrand = TextEditingController();
  String proLstPArams='';
  String proAdd='';
  String proEdit='';
  String proLstDelete='';
  String returList='';
  String retuAdd='';
  String retuEdit='';
  String retuDelete='';
  String suppListView='';
  String suppAdd='';
  String suppEdit='';
  String suppDelete='';
  String cusListView='';
  String cusAdd='';
  String cusEdit='';
  String cusDelete='';
  String purListView='';
  String purAdd='';
  String purEdit='';
  String purDelete='';
  String reportSaleView='';
  String reportTaxView='';

  var isLoadingAuth = false.obs;
  var languagee = 'en'.obs;
  var isLoadingPro = false.obs;
  var isLoadingSub = false.obs;
  ProductAllController proAllController = Get.put(ProductAllController());

  final token = "".obs;
  final userId = "".obs;
  var isLoadingAdd = false.obs;
  final langSet = ''.obs;
  var status = false.obs;
  final message = "".obs;
  final customerL = [].obs;
  var stat = ''.obs;
  var isLoadingReg = false.obs;

  final taxL = [].obs;
  final CategoryL = [].obs;
  final WareL = [].obs;
  final brandL = [].obs;
  final products = [].obs;
  var itemsPro = [].obs;
  var itemsProList = [].obs;
  var itemsProListSearc = [].obs;
  var itemsProScan = [].obs;
  var itemsProSearcgh = [].obs;

  final defaultC = ''.obs;
  final defaultB = ''.obs;
  final defaultW = ''.obs;
  final currency = ''.obs;

  // final oldpass = ''.obs;
  final CategoryList = [].obs;
  final brandList = [].obs;
  final brandListSearch = [].obs;

  final SubCategoryList = [].obs;
  final customerList = [].obs;
  final SubCategoryListSearch = [].obs;
  final CategoryListSaerch = [].obs;

  var mainItem;
  var brandItem;
  var subItemo;
  final permission=[].obs;
  final billerL = [].obs;
  final SubCategoryL = [].obs;

  RxString finsih = '0'.obs;

  Future<void> GetLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logog = prefs.getString('logs')!;
  }

  @override
  void onInit() {
    GetLogo();
    getSubAll();
    getPosDefault();

    // TODO: implement onInit
    super.onInit();
  }

  void printReport(String reportId, String type, String ret) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );
      PrintResponse result = await ReportApiProvider().printReport(reportId);

      if (result.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        logog = prefs.getString('logs')!;
        final netImage = await networkImage(logog);

        final invoice = Invoice(
          supplier: BillerModel(
            invoicefooter: result.billerItem.invoicefooter,
            billerName: result.billerItem.billerName,
            address: result.billerItem.address,
            city: result.billerItem.city,
            tel: result.billerItem.tel,
            companeName: result.billerItem.companeName,
            country: result.billerItem.country,
          ),
          posItem: PosModel(
              cf_title2: result.posItem.cf_title2,
              cf_value2: result.posItem.cf_value2,
              cf_value1: result.posItem.cf_value1,
              cf_title1: result.posItem.cf_title1,
              customer_details: result.posItem.customer_details),
          customerSale: CustomerSaleModel(
              name: result.customerSale.name,
              country: result.customerSale.country,
              city: result.customerSale.city,
              address: result.customerSale.address,
              phone: result.customerSale.phone,
              state: result.customerSale.state),
          saleUser: SaleUserModel(
              first_name: result.saleUsesr.first_name,
              last_name: result.saleUsesr.last_name),
          invItem: InvModel(
              reference_no: result.invItem.reference_no,
              delivery_date: result.invItem.delivery_date,
              date: result.invItem.date,
              total: result.invItem.total,
              grand_total: result.invItem.grand_total,
              product_tax: result.invItem.product_tax,
              id: result.invItem.id,
              note:result.invItem.note,
              return_sale_ref: result.invItem.return_sale_ref),
          products: result.productList.reversed.toList(),

        );
        Get.back();
        if (ret == '1') {
          final pdfFile = await PdfInvoiceApiRetrive.generate(
              invoice, netImage,  type, ret,currency.value);
        } else {
          final pdfFile = await PdfInvoiceApi.generate(
              invoice, netImage,  type, ret,currency.value);
        }
      } else {
        Get.back();

        /*message.value = result.message.toString();
        Get.snackbar(S.of(context).Error, message.value,
            backgroundColor: Colors.grey.withOpacity(0.6));*/
      }
    } finally {
      update();
    }
  }

  void printReportREturned(String reportId, String type) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );
      PrintResponse result = await ReportApiProvider().printReport(reportId);

      if (result.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        logog = prefs.getString('logs')!;
        final netImage = await networkImage(logog);
        final List<ProductSaleModel> productListLast=[];

        for(int i=0;i<result.productList.length;i++){
  if(result.productList[i].quantity.toString().split('.')[0]=='0'){
  }else{
    productListLast.add(result.productList[i]);
  }
}
        final invoice = Invoice(
          supplier: BillerModel(
            invoicefooter: result.billerItem.invoicefooter,

            billerName: result.billerItem.billerName,
            address: result.billerItem.address,
            city: result.billerItem.city,
            tel: result.billerItem.tel,
            companeName: result.billerItem.companeName,
            country: result.billerItem.country,
          ),
          posItem: PosModel(
              cf_title2: result.posItem.cf_title2,
              cf_value2: result.posItem.cf_value2,
              cf_value1: result.posItem.cf_value1,
              cf_title1: result.posItem.cf_title1,
              customer_details: result.posItem.customer_details),
          customerSale: CustomerSaleModel(
              name: result.customerSale.name,
              country: result.customerSale.country,
              city: result.customerSale.city,
              address: result.customerSale.address,
              phone: result.customerSale.phone,
              state: result.customerSale.state),
          saleUser: SaleUserModel(
              first_name: result.saleUsesr.first_name,
              last_name: result.saleUsesr.last_name),
          invItem: InvModel(              note:result.invItem.note,

              reference_no: result.invItem.reference_no,
              delivery_date: result.invItem.delivery_date,
              date: result.invItem.date,
              total: result.invItem.total,
              grand_total: result.invItem.grand_total,
              product_tax: result.invItem.product_tax,
              id: result.invItem.id,
              return_sale_ref: result.invItem.return_sale_ref),
          products: productListLast.reversed.toList(),
        );
    Get.back();
        Get.back();
        final pdfFile = await PdfInvoiceApiRetrive.generate(
            invoice, netImage,  type, '1',currency.value).then((value) {

        });
     //   Get.back();

      } else {
        Get.back();

        /*message.value = result.message.toString();
        Get.snackbar(S.of(context).Error, message.value,
            backgroundColor: Colors.grey.withOpacity(0.6));*/
      }
    } finally {
      update();
    }
  }

  void getPosDefault() async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
//    oldpass.value = prefs.getString('pass');
    try {
      if (pagePos == 1) {
        isLoading(true);
      }
      customerL.clear();
      customerList.clear();
      CategoryL.clear();
      CategoryList.clear();
      CategoryListSaerch.clear();

      brandList.clear();
      brandListSearch.clear();
      SubCategoryL.clear();
      WareL.clear();
      billerL.clear();
      products.clear();
      itemsPro.clear();
      taxL.clear();
      brandL.clear();

      PosResponse res = await PosApiProvider().getPosDefault(pagePos);
      if (res.status != '') {
        if (res.status == 'false') {
          print(res.message);
          stat.value = res.status;
        }
      }else{
        if (res.code == 200) {
          permission.clear();
          if(res.settingItem!.Permission!=null){
            permission.add(res.settingItem!.Permission);

            proLstPArams = res.settingItem!.Permission!.products_index;
            proAdd = res.settingItem!.Permission!.products_add;
            proEdit = res.settingItem!.Permission!.products_edit;
            proLstDelete = res.settingItem!.Permission!.products_delete;
            returList = res.settingItem!.Permission!.returns_index;
            retuAdd = res.settingItem!.Permission!.returns_add;
            retuEdit = res.settingItem!.Permission!.returns_edit;
            retuDelete = res.settingItem!.Permission!.returns_delete;
            suppListView=res.settingItem!.Permission!.suppliers_index;
            suppAdd=res.settingItem!.Permission!.suppliers_add;
            suppEdit=res.settingItem!.Permission!.suppliers_edit;
            suppDelete=res.settingItem!.Permission!.suppliers_delete;
            cusListView=res.settingItem!.Permission!.customers_index;
            cusAdd=res.settingItem!.Permission!.customers_add;
            cusEdit=res.settingItem!.Permission!.customers_edit;
            cusDelete=res.settingItem!.Permission!.customers_delete;
            purListView=res.settingItem!.Permission!.purchases_index;
            purAdd=res.settingItem!.Permission!.purchases_add;
            purEdit=res.settingItem!.Permission!.purchases_edit;
            purDelete=res.settingItem!.Permission!.purchases_delete;
            reportSaleView=res.settingItem!.Permission!.reports_sales;
            reportTaxView=res.settingItem!.Permission!.reports_tax;
          }

          for (int i = 0; i < res.categories.length; i++) {
            if (res.categories[i].image == null ||
                res.categories[i].image == 'null' ||
                res.categories[i].image == '') {
              res.categories[i].imgfile = Uint8List(0);
            } else {
              http.Response response = await http.get(Uri.parse(
                  'https://heba.icon-pos.com/assets/uploads/' +
                      res.categories[i].image));
              if (response.statusCode == 200) {
                final ByteData data = await NetworkAssetBundle(Uri.parse(
                    'https://heba.icon-pos.com/assets/uploads/' +
                        res.categories[i].image))
                    .load('https://heba.icon-pos.com/assets/uploads/' +
                    res.categories[i].image);
                final Uint8List bytes = data.buffer.asUint8List();
                res.categories[i].imgfile = bytes;
              } else {
                res.categories[i].imgfile = Uint8List(0);
              }
            }
          }
          for (int i = 0; i < res.brands.length; i++) {
            if (res.brands[i].image == null ||
                res.brands[i].image == 'null' ||
                res.brands[i].image == '') {
              res.brands[i].imgfile = Uint8List(0);
            } else {
              http.Response response = await http.get(Uri.parse(
                  'https://heba.icon-pos.com/assets/uploads/' +
                      res.brands[i].image));
              if (response.statusCode == 200) {
                final ByteData data = await NetworkAssetBundle(Uri.parse(
                    'https://heba.icon-pos.com/assets/uploads/' +
                        res.brands[i].image))
                    .load('https://heba.icon-pos.com/assets/uploads/' +
                    res.brands[i].image);
                final Uint8List bytes = data.buffer.asUint8List();
                res.brands[i].imgfile = bytes;
              } else {
                res.brands[i].imgfile = Uint8List(0);
              }
            }
          }

          if (res.status != '') {
            if (res.status == 'false') {
              print(res.message);
              stat.value = res.status;
            }
          } else {
            customerL.clear();
            customerList.clear();
            CategoryL.clear();
            CategoryList.clear();
            CategoryListSaerch.clear();

            brandList.clear();
            brandListSearch.clear();
            WareL.clear();
            brandL.clear();
            billerL.clear();
            taxL.clear();
            SubCategoryL.clear();
            products.clear();
            itemsPro.clear();

            token.value = res.token;
            userId.value = res.user_id;
            SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
            sharedPrefs.setString('token', token.value);

            sharedPrefs.setString('userid', userId.value);
            customerL.assignAll(res.customers!.customerList);
            customerList.addAll(customerL);

            for (int i = 0; i < res.categories.length; i++) {
              if (res.categories[i].parent_id.toString() == '0' ||
                  res.categories[i].parent_id.toString() == 'null') {
                CategoryL.add(res.categories[i]);
              }
            }

            //  var myFile = await file("myFileName.png")ك

            for (int i = 0; i < CategoryL.length; i++) {
              if (CategoryL[i].IsDefault == 'True') {
                mainItem = CategoryL[i];
              }
            }
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? lang = prefs.getString('lang');
            if (lang == 'en' || lang == '' || lang == null || lang == 'null') {
              CategoryL.insert(
                  0,
                  CategoryModelList(
                      id: '0',
                      name: 'All Categories',
                      IsDefault: 'False',
                      slug: '',
                      description: '',
                      image: '',
                      code: '0000',
                      parent_id: '',
                      imgfile: Uint8List(0),
                      catName: ''));
            } else {
              CategoryL.insert(
                  0,
                  CategoryModelList(
                      id: '0',
                      imgfile: Uint8List(0),
                      name: 'جميع الفئات',
                      IsDefault: 'False',
                      slug: '',
                      description: '',
                      image: '',
                      code: '0000',
                      parent_id: '',
                      catName: ''));
            }
            CategoryList.addAll(CategoryL);

            CategoryList.value.removeAt(0);

            CategoryListSaerch.addAll(CategoryList);

            brandL.assignAll(res.brands);
            if (lang == 'en' || lang == '' || lang == null || lang == 'null') {
              brandL.insert(
                  0,
                  BrandModelList(
                      id: '0',
                      name: 'All Brands',
                      imgfile: Uint8List(0),
                      slug: '',
                      description: '',
                      image: '',
                      code: '0000'));
            } else {
              brandL.insert(
                  0,
                  BrandModelList(
                    id: '0',
                    imgfile: Uint8List(0),
                    name: 'جميع الماركات',
                    slug: '',
                    description: '',
                    image: '',
                    code: '0000',
                  ));
            }
            brandItem = brandL[0];
            brandList.addAll(brandL);
            brandList.value.removeAt(0);
            brandListSearch.addAll(brandList);
            products.assignAll(res.products);
            itemsPro.assignAll(products);

            SubCategoryL.assignAll(res.subCategories);
            if (lang == 'en' || lang == '' || lang == null || lang == 'null') {
              SubCategoryL.insert(
                  0,
                  CategoryModelList(
                      id: '0',
                      imgfile: Uint8List(0),
                      name: 'All Sub Categories',
                      slug: '',
                      description: '',
                      image: '',
                      code: '0000',
                      IsDefault: 'false',
                      parent_id: '',
                      catName: ''));
            } else {
              SubCategoryL.insert(
                  0,
                  CategoryModelList(
                      id: '0',
                      imgfile: Uint8List(0),
                      name: 'جميع الفئات الفرعية',
                      slug: '',
                      description: '',
                      image: '',
                      code: '0000',
                      IsDefault: 'false',
                      parent_id: '',
                      catName: ''));
            }

            billerL.assignAll(res.billers!.customerList);
            taxL.assign(res.taxes);
            WareL.assignAll(res.wares!.wareList);
            langSet.value = res.settingItem!.Language_print_items;
            defaultC.value = res.settingItem!.default_customer;
            defaultB.value = res.settingItem!.default_biller;
            defaultW.value = res.settingItem!.default_warehouse;
            currency.value = res.settingItem!.currency.toString();
            isLoading(false);
          }
        }
        else if (res.code == 503 &&
            res.message.toString() == 'Api feature is disabled') {
          isLoading(false);
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
        else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? lang = prefs.getString('lang');
          if (lang == 'en') {
            if (res.code.toString() == '401') {
              Get.snackbar('Error', 'Username or password incorrect',
                  backgroundColor: Colors.grey.withOpacity(0.6));
              isLoading(false);
            }
          } else {
            Get.snackbar('خطأ', 'اسم المستخدم أو كلمة المرور غير صحيحة',
                backgroundColor: Colors.grey.withOpacity(0.6));
            isLoading(false);
          }
          isLoading(false);
        }
      }

    } finally {
      isLoading(false);
      update();
    }
  }

  void getPosDefaultLoading() async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
//    oldpass.value = prefs.getString('pass');
    try {
      if (pagePos == 1) {
        isLoading(true);
      }

      PosResponse res = await PosApiProvider().getPosDefault(pagePos);

      if (res.code == 200) {
        if (res.status != '') {
          if (res.status == 'false') {
            print(res.message);
            stat.value = res.status;
          }
        } else {
          token.value = res.token;
          userId.value = res.user_id;
          SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
          sharedPrefs.setString('token', token.value);

          sharedPrefs.setString('userid', userId.value);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? lang = prefs.getString('lang');

          products.addAll(res.products);
          itemsPro.addAll(res.products);

          isLoading(false);
        }
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        if (lang == 'en') {
          if (res.code.toString() == '401') {
            Get.snackbar('Error', 'Username or password incorrect',
                backgroundColor: Colors.grey.withOpacity(0.6));
            isLoading(false);
          }
        } else {
          Get.snackbar('خطأ', 'اسم المستخدم أو كلمة المرور غير صحيحة',
              backgroundColor: Colors.grey.withOpacity(0.6));
          isLoading(false);
        }
        isLoading(false);
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void getPosDefaultForSub() async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
//    oldpass.value = prefs.getString('pass');
    try {
      isLoading(true);

      SubCategoryL.clear();

      PosResponse res = await PosApiProvider().getPosDefault(pagePos);

      if (res.code == 200) {
        if (res.status != '') {
          if (res.status == 'false') {
            print(res.message);
            stat.value = res.status;
          }
        } else {
          SubCategoryL.clear();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? lang = prefs.getString('lang');

          SubCategoryL.assignAll(res.subCategories);
          if (lang == 'en' || lang == '' || lang == null || lang == 'null') {
            SubCategoryL.insert(
                0,
                CategoryModelList(
                    id: '0',
                    name: 'All Sub Categories',
                    slug: '',
                    imgfile: Uint8List(0),
                    description: '',
                    image: '',
                    code: '0000',
                    IsDefault: 'false',
                    parent_id: '',
                    catName: ''));
          } else {
            SubCategoryL.insert(
                0,
                CategoryModelList(
                    id: '0',
                    imgfile: Uint8List(0),
                    name: 'جميع الفئات الفرعية',
                    slug: '',
                    description: '',
                    image: '',
                    code: '0000',
                    IsDefault: 'false',
                    parent_id: '',
                    catName: ''));
          }

          isLoading(false);
        }
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        if (lang == 'en') {
          if (res.code.toString() == '401') {
            Get.snackbar('Error', 'Username or password incorrect',
                backgroundColor: Colors.grey.withOpacity(0.6));
            isLoading(false);
          }
        } else {
          Get.snackbar('خطأ', 'اسم المستخدم أو كلمة المرور غير صحيحة',
              backgroundColor: Colors.grey.withOpacity(0.6));
          isLoading(false);
        }
        isLoading(false);
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void getLogo(BuildContext context, String subdomain) async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
//    oldpass.value = prefs.getString('pass');
    try {
      isLoadingLogo(true);
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('baseurl', 'https://' + subdomain + '.icon-pos.com');

      LogoResponse res = await PosApiProvider().getLogo();

      if (res.statuecode == 200) {
        isLoadingLogo(false);
        logog = res.loggs;
        prefs.setString('logs', logog);
        Get.offAll(() => LoginPage());
      } else if (res.statuecode == 503 &&
          res.loggs.toString() == 'Api feature is disabled') {
        prefs.remove('baseurl');
        isLoadingLogo(false);
        Get.snackbar(S.of(context).Error, S.of(context).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        isLoadingLogo(false);
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  void getLogoTrail(String email,String phone,String namee,BuildContext context) async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
//    oldpass.value = prefs.getString('pass');
    try {

      isLoadingAuth(true);
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('baseurl', 'https://icon-pos.com');

      LogoResponse res = await PosApiProvider().getLogo();

      if (res.statuecode == 200) {
        checkAuthGuest('owner', '12345678',email,phone,namee, context);
        logog = res.loggs;
        prefs.setString('logs', logog);
      } else if (res.statuecode == 503 &&
          res.loggs.toString() == 'Api feature is disabled') {
        prefs.remove('baseurl');
        isLoadingAuth(false);
        Get.snackbar(S.of(context).Error, S.of(context).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        isLoadingAuth(false);
      }
    } finally {
      isLoadingAuth(false);
      update();
    }
  }

  void checkAuth(String username, String pass, BuildContext context) async {
    try {


      PosResponse res = await PosApiProvider().checkAuth(username, pass);

      if (res.code == 200) {
        isLoadingAuth(false);
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('countt');

        prefs.setString('user', username);
        prefs.setString('pass', pass);
        prefs.setString('token', res.token);
        Get.offAll(() => HomePage());
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingLogo(false);
        Get.snackbar(S.of(context).Error, S.of(context).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        if (res.code.toString() == '401') {
          Get.snackbar(S.of(context).Error, res.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
          isLoadingAuth(false);
        }
        isLoadingAuth(false);
      }
    } finally {
      isLoadingAuth(false);
      update();
    }
  }
  void checkAuthGuest(String username, String pass,String email, String phone,String namee, BuildContext context) async {
    try {


      PosResponse res = await PosApiProvider().checkAuth(username, pass);

      if (res.code == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('countt');

        prefs.setString('user', username);
        prefs.setString('pass', pass);
        prefs.setString('token', res.token);

        String? token = prefs.getString('token');
        dio.FormData data = new dio.FormData.fromMap({
          "token": token,
          "email": email,
          "phone":phone,
        "name":namee
        });
      loginGuest(data, context);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingLogo(false);
        Get.snackbar(S.of(context).Error, S.of(context).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        if (res.code.toString() == '401') {
          Get.snackbar(S.of(context).Error, res.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
          isLoadingAuth(false);
        }
        isLoadingAuth(false);
      }
    } finally {
      isLoadingAuth(false);
      update();
    }
  }

  void getProduct(String categoryCode) async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsPro.clear();
      ProductResponse res = await PosApiProvider().getProduct(categoryCode);

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        products.clear();
        SubCategoryL.clear();
        itemsPro.clear();
        products.assignAll(res.products);
        itemsPro.assignAll(products);
        SubCategoryL.assignAll(res.subList);
        if (lang == 'en' || lang == '' || lang == null || lang == 'null') {
          SubCategoryL.insert(
              0,
              CategoryModelList(
                  id: '0',
                  name: 'All Sub Categories',
                  slug: '',
                  imgfile: Uint8List(0),
                  description: '',
                  image: '',
                  code: '0000',
                  IsDefault: 'false',
                  parent_id: '',
                  catName: ''));
        } else {
          SubCategoryL.insert(
              0,
              CategoryModelList(
                  id: '0',
                  imgfile: Uint8List(0),
                  name: 'جميع الفئات الفرعية',
                  slug: '',
                  description: '',
                  image: '',
                  code: '0000',
                  IsDefault: 'false',
                  parent_id: '',
                  catName: ''));
        }

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoading(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getProductMain(String categoryCode) async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsPro.clear();
      ProductResponse res = await PosApiProvider().getProduct(categoryCode);

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        products.clear();
        itemsPro.clear();
        products.assignAll(res.products);
        itemsPro.assignAll(products);

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getProductAllCAtegoryMain() async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsPro.clear();
      itemsProList.clear();

      ProductResponse res =
          await PosApiProvider().getAllProduct(pagePos.toString());

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        products.clear();
        itemsPro.clear();
        itemsProList.clear();

        products.assignAll(res.products);
        itemsPro.assignAll(products);
        itemsProList.assignAll(itemsPro);

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getAllPro() async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsProList.clear();
      itemsProListSearc.clear();
      ProductResponse res =
          await PosApiProvider().getAllProduct(pagePos.toString());

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        products.clear();
        itemsProList.clear();
        itemsProListSearc.clear();

        products.assignAll(res.products);
        itemsProList.assignAll(products);
        itemsProListSearc.assignAll(products);

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getSubCat(String catId) async {
    try {
      isLoadingPro(true);

      SubCategoryList.clear();

      SubCategoryResponse res = await ProductApiProvider().GettSubCat(catId);

      if (res.statuecode == 200) {
        SubCategoryList.clear();

        SubCategoryList.addAll(res.subCategories);
      } else if (res.statuecode == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      isLoadingPro(false);
    } finally {
      isLoadingPro(false);

      update();
    }
  }

  void getSubAll() async {
    try {
      isLoadingSub(true);

      SubCategoryList.clear();
      SubCategoryListSearch.clear();
      SubCategoryResponse res = await ProductApiProvider().GettSubCatAll();

      if (res.statuecode == 200) {
        for (int i = 0; i < res.subCategories.length; i++) {
          if (res.subCategories[i].image == null ||
              res.subCategories[i].image == 'null' ||
              res.subCategories[i].image == '') {
            res.subCategories[i].imgfile = Uint8List(0);
          } else {
            http.Response response = await http.get(Uri.parse(
                'https://heba.icon-pos.com/assets/uploads/' +
                    res.subCategories[i].image));
            if (response.statusCode == 200) {
              final ByteData data = await NetworkAssetBundle(Uri.parse(
                      'https://heba.icon-pos.com/assets/uploads/' +
                          res.subCategories[i].image))
                  .load('https://heba.icon-pos.com/assets/uploads/' +
                      res.subCategories[i].image);
              final Uint8List bytes = data.buffer.asUint8List();
              res.subCategories[i].imgfile = bytes;
            } else {
              res.subCategories[i].imgfile = Uint8List(0);
            }
          }
        }

        SubCategoryList.clear();
        SubCategoryListSearch.clear();
        CategoryController catController = Get.put(CategoryController());

        SubCategoryList.addAll(res.subCategories);
        SubCategoryListSearch.addAll(res.subCategories);
        for (int i = 0; i < SubCategoryList.length; i++) {
          for (int j = 0; j < catController.catList.length; j++) {
            if (catController.catList[j].id == SubCategoryList[i].parent_id) {
              SubCategoryList[i].catName = catController.catList[j].name;
            }
          }
        }
        isLoadingSub(false);
      } else if (res.statuecode == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingSub(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
      isLoadingSub(false);
    } finally {
      isLoadingSub(false);

      update();
    }
  }

  void getProductAllCAtegory() async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsProScan.clear();
      itemsPro.clear();
      ProductResponse res =
          await PosApiProvider().getAllProduct(pagePos.toString());

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        products.clear();
        SubCategoryL.clear();
        itemsPro.clear();
        products.assignAll(res.products);
        itemsPro.assignAll(products);
        SubCategoryL.assignAll(res.subList);
        if (lang == 'en' || lang == '' || lang == null || lang == 'null') {
          SubCategoryL.insert(
              0,
              CategoryModelList(
                  id: '0',
                  name: 'All Sub Categories',
                  slug: '',
                  description: '',
                  image: '',
                  imgfile: Uint8List(0),
                  code: '0000',
                  IsDefault: 'false',
                  parent_id: '',
                  catName: ''));
        } else {
          SubCategoryL.insert(
              0,
              CategoryModelList(
                  id: '0',
                  imgfile: Uint8List(0),
                  name: 'جميع الفئات الفرعية',
                  slug: '',
                  description: '',
                  image: '',
                  code: '0000',
                  IsDefault: 'false',
                  parent_id: '',
                  catName: ''));
        }

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getProductByBrand(String brandCode) async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsPro.clear();
      ProductResponse res = await PosApiProvider().getProductByBrand(brandCode);

      if (res.code == 200) {
        products.clear();
        itemsPro.clear();

        products.assignAll(res.products);
        itemsPro.assignAll(products);

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getProductAllBrand() async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsPro.clear();
      ProductResponse res;
      if (mainItem.id == '0') {
        res = await PosApiProvider().getProductAllBrand();
      } else {
        res = await PosApiProvider().getProduct(mainItem.code);
      }

      if (res.code == 200) {
        products.clear();
        itemsPro.clear();

        products.assignAll(res.products);
        itemsPro.assignAll(products);

        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getProductBySubCategory(String subCode) async {
    try {
      isLoadingPro(true);
      products.clear();
      itemsPro.clear();
      ProductResponse res = await PosApiProvider().getProductByBSub(subCode);

      if (res.code == 200) {
        products.clear();

        products.assignAll(res.products);
        itemsPro.assignAll(products);
        isLoadingPro(false);
      } else if (res.code == 503 &&
          res.message.toString() == 'Api feature is disabled') {
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getProductByCode(String proCode) async {
    try {
      scanIs.value = true;
      isLoadingPro(true);
      //  products.clear();
      itemsProScan.clear();
      CodeResponse res = await PosApiProvider().getProductByCode(proCode);
      if (res.code == 200) {

        if (res.status == true) {
          // products.clear();

          //  products.assign(res.productItem);
          itemsProScan.assign(res.productItem);
          isLoadingPro(false);
        }
      } else {
        scanIs.value=false;

        if (languagee == 'en') {
          Get.snackbar(S.of(Get.context!).Error, 'No product found',
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.snackbar(S.of(Get.context!).Error, 'لا يوجد أي منتج لهذا الرمز',
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }
  void getProductByCodetoAddPurchases(String proCode) async {
    try {
      Get.dialog(
        Center(
          child:
          Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );
      //  products.clear();
      CodeResponse res = await PosApiProvider().getProductByCode(proCode);
      if (res.code == 200) {

        if (res.status == true) {
          // products.clear();
          ProductController proController = Get.put(ProductController());
          proController.productItem = res.productItem;
          proController.check=false;


          final controllerq = TextEditingController();
            final controllerpr =
            TextEditingController();

            if (proController
                .productListSele.value.length ==
                0) {
              controllerq.text = res.productItem.quantitySel
                  .toString();
              controllerpr.text = res.productItem.net_price_sel
                  .toString();

              proController.productListSele.add(
                  TableComboModel(
                      quan: controllerq,
                      pric: controllerpr,
                      itemPro:
                      res.productItem));
              proController.check = true;
            } else {
              for (int i = 0;
              i <
                  proController
                      .productListSele.length;
              i++) {
                if (proController
                    .productListSele[i].itemPro.id
                    .toString() ==
                    res.productItem.id
                        .toString()) {
                  proController
                      .productListSele[i]
                      .itemPro
                      .quantitySel = proController
                      .productListSele[i]
                      .itemPro
                      .quantitySel +
                      1;
                  proController.productListSele[i].quan
                      .text =
                      proController.productListSele[i]
                          .itemPro.quantitySel
                          .toString();

                  proController.check = true;
                }
              }
            }
            if (proController.check == false) {
              controllerq.text = proController
                  .productItem!.quantitySel
                  .toString();
              controllerpr.text = proController
                  .productItem!.net_price_sel
                  .toString();

              proController.productListSele.add(
                  TableComboModel(
                      quan: controllerq,
                      pric: controllerpr,
                      itemPro:
                      res.productItem));
            }

          //  products.assign(res.productItem);
          isLoadingPro(false);
        }
        Get.back();
      } else {

        if (languagee == 'en') {
          Get.snackbar(S.of(Get.context!).Error, 'No product found',
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.snackbar(S.of(Get.context!).Error, 'لا يوجد أي منتج لهذا الرمز',
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
        Get.back();

      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void openRegister(dio.FormData data, BuildContext context) async {
    try {
      isLoadingReg(true);

      CashResponse result = await PosApiProvider().openRegister(data);

      if (result.status == true) {
        isLoadingReg(false);

        getPosDefault();
      } else {
        message.value = result.message.toString();
        Get.snackbar(S.of(context).Error, message.value,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingReg(false);

      update();
    }
  }

  Future<void> changeLang(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang == null) {
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'ar'));
      LanguageChangeProvider().changeLocale("ar");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lang', 'ar');
      lang = 'AR';
      languagee.value = 'ar';
      proAllController.getLang(context);
      Get.updateLocale(Locale.fromSubtags(languageCode: 'ar'));
    } else if (lang == 'en') {
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'ar'));
      LanguageChangeProvider().changeLocale("ar");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lang', 'ar');
      lang = 'AR';
      languagee.value = 'ar';
      proAllController.getLang(context);

      Get.updateLocale(Locale.fromSubtags(languageCode: 'ar'));
    } else if (lang == 'ar') {
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'en'));
      LanguageChangeProvider().changeLocale("en");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lang', 'en');
      lang = 'EN';
      languagee.value = 'en';
      proAllController.getLang(context);

      Get.updateLocale(Locale.fromSubtags(languageCode: 'en'));
    }
  }

  Future<void> getLang(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang == null) {
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'en'));
      LanguageChangeProvider().changeLocale("en");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lang', 'en');
      lang = 'EN';
      languagee.value = 'en';
      Get.updateLocale(Locale.fromSubtags(languageCode: 'en'));
    } else if (lang == 'en') {
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'en'));
      LanguageChangeProvider().changeLocale("en");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lang', 'en');
      lang = 'EN';
      languagee.value = 'en';

      Get.updateLocale(Locale.fromSubtags(languageCode: 'en'));
    } else if (lang == 'ar') {
      MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: 'ar'));
      LanguageChangeProvider().changeLocale("ar");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lang', 'ar');
      lang = 'AR';
      languagee.value = 'ar';

      Get.updateLocale(Locale.fromSubtags(languageCode: 'ar'));
    }
  }
  void AddSale(dio.FormData data, BuildContext context) async {
    try {
      isLoadingAdd(true);

      GeneralResponse result = await PosApiProvider().addSale(data);

      if (result.status == true) {
        Get.back();
        SharedPreferences prefs = await SharedPreferences.getInstance();

        for (int i = 0; i < itemsPro.length; i++) {
          itemsPro[i].select = false;
          itemsPro[i].quantity = 0;
        }
        prefs.remove('cartOrder');
        prefs.remove('lastpro');

        logog = prefs.getString('logs')!;
        final netImage = await networkImage(logog);
        List<CartMode> alarmLi = <CartMode>[];

        String? orderL = prefs.getString('cartOrder');
        if (orderL != null) {
          alarmLi = (json.decode(orderL) as List<dynamic>)
              .map<CartMode>((item) => CartMode.fromJson(item))
              .toList();
        }
        final invoice = Invoice(
          supplier: BillerModel(
            invoicefooter: result.billerItem.invoicefooter,

            billerName: result.billerItem.billerName,
            address: result.billerItem.address,
            city: result.billerItem.city,
            tel: result.billerItem.tel,
            companeName: result.billerItem.companeName,
            country: result.billerItem.country,
          ),
          posItem: PosModel(
              cf_title2: result.posItem.cf_title2,
              cf_value2: result.posItem.cf_value2,
              cf_value1: result.posItem.cf_value1,
              cf_title1: result.posItem.cf_title1,
              customer_details: result.posItem.customer_details),
          customerSale: CustomerSaleModel(
              name: result.customerSale.name,
              country: result.customerSale.country,
              city: result.customerSale.city,
              address: result.customerSale.address,
              phone: result.customerSale.phone,
              state: result.customerSale.state),
          saleUser: SaleUserModel(
              first_name: result.saleUsesr.first_name,
              last_name: result.saleUsesr.last_name),
          invItem: InvModel(              note:result.invItem.note,

              reference_no: result.invItem.reference_no,
              delivery_date: result.invItem.delivery_date,
              date: result.invItem.date,
              total: result.invItem.total,
              grand_total: result.invItem.grand_total,
              product_tax: result.invItem.product_tax,
              id: result.invItem.id,
              return_sale_ref: ''),
          products: result.productList.reversed.toList(),
        );

        final pdfFile = await PdfInvoiceApi.generate(
            invoice, netImage,  '1', '0',currency.value);
        isLoadingAdd(false);
        for (int y = 0; y < itemsPro.value.length; y++) {
          itemsPro.value[y].quantity = 0;
        }

        isLoadingAdd(false);
        prefs.remove('cartOrder');
        prefs.remove('lastpro');
        Get.offAll(() => HomePage());
      } else {
        Get.back();

        message.value = result.message.toString();
        Get.snackbar(S.of(context).Error, message.value,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingAdd(false);

      update();
    }
  }

  void loginGuest(dio.FormData data, BuildContext context) async {
    try {

      GuestResponse result = await PosApiProvider().loginGuest(data);

      if (result.status == true) {
        isLoadingAuth(false);

        Get.offAll(() => HomePage());
      } else {
        isLoadingAuth(false);

        Get.back();

        message.value = result.message.toString();
        Get.snackbar(S.of(context).Error, message.value,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingAuth(false);

      update();
    }
  }
}
