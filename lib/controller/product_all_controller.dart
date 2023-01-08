import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/LanguageChangeProvider.dart';

import 'package:icon/apiProvider/pos_api_provider.dart';
import 'package:icon/apiProvider/product_api_provider.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/combo_model.dart';
import 'package:icon/model/custom_mode_arabic.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/product_details_model.dart';
import 'package:icon/model/supModelAdd.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:icon/model/table_combp_edit_model.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/unit_model.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/add_product_list_response.dart';
import 'package:icon/response/product_details_response.dart';
import 'package:dio/dio.dart' as dio;

import 'package:icon/response/product_response.dart';
import 'package:icon/response/sub_cat_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProductAllController extends GetxController {
  var isLoadingPro = false.obs;
  var isLoadingdetails = false.obs;
  var itemDetails;
  bool searchh = false;

  List<WarehouseModelList> suplierList = [];
  UnitModelList? unitPurItem;
int page=1;
  RefreshController refreshControllerPos = RefreshController(initialRefresh: false);

  final products = [].obs;
  var itemsProList = [].obs;
  var itemsProListSearc = [].obs;
  var languagee = 'en'.obs;
  TextEditingController searchPro = TextEditingController();
  RxInt currentStep = 1.obs;
  final supAdvdList = [].obs;
  TextEditingController proDetails = TextEditingController();
  TextEditingController proDetailsP = TextEditingController();
  CustomerModelAraList? proItem;
  PickedFile? imageFileDig;
  TaxModelList? taxItem;
  TextEditingController codeTexts = TextEditingController();
  bool isCheckedHide = false;
  RxString dates = ''.obs;
  RxString datee = ''.obs;
  CategoryModelList? catItem;
  BrandModelList? brandItem;
  UnitModelList? unitItem;
  CategoryModelList? subItem;
  UnitModelList? unitSaleItem;
  PickedFile? imageFile;
  TextEditingController productN = TextEditingController();
  TextEditingController nameAra = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController alert = TextEditingController();
  TextEditingController prop = TextEditingController();
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
  var isLoading = false.obs;
  final wareList = [].obs;

  final taxList = [].obs;
  final catList = [].obs;
  final subCatList = [].obs;
  final unitList = [].obs;
  final brandList = [].obs;
  ProductModdelList? productItem;
  ComboModel? comboItem;

  final productListSele = [].obs;
  final productList = [].obs;
  bool check = false;
  TextEditingController digi = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    ProductAllController().onClose();

  }
  @override
  void onInit() {
    getDropListAddPro();

    getAllPro();

    // TODO: implement onInit
    super.onInit();
  }
  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    page= 1;

    getAllPro();
    refreshControllerPos.refreshCompleted();

    print('fgbfg');
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page=page+10;
    print('lolo');
    getAllProLoading();

    refreshControllerPos.loadComplete();

  }
  void getProduct() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    try {
      productList.clear();
      ProductResponse res = await ProductApiProvider().getProduct();

      if (res.code == 200) {
        productList.clear();

        productList.assignAll(res.products);
      }
      else if(res.code==503 && res.message.toString()=='Api feature is disabled'){
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  void getDropListAddPro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang == null || lang=='en') {
      languagee.value='en';
    } else {
      languagee.value='ar';

    }
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
        for (int i = 0; i < subCatList.length; i++) {
          if (subCatList[i].id.toString() ==
              itemDetails.subcategory_id.toString()) {
            subItem = subCatList[i];
          }
        }
      }
      else if(res.statuecode==503 && res.message.toString()=='Api feature is disabled'){
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  void addItemSup(TextEditingController controllern,
      TextEditingController controllerp, WarehouseModelList subI) {
    supAdvdList.add(addSupp(
        supAddList: suplierList,
        supn: controllern,
        supp: controllerp,
        supItemAdd: subI));
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

  void getAllPro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang == null || lang=='en') {
      languagee.value='en';
    } else {
      languagee.value='ar';

    }
    try {
      isLoadingPro(true);
      products.clear();
      itemsProList.clear();
      itemsProListSearc.clear();
      ProductResponse res = await PosApiProvider().getAllProduct(page.toString());

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
      }
      else if(res.code==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }
  void getAllProLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang == null || lang=='en') {
      languagee.value='en';
    } else {
      languagee.value='ar';

    }
    try {

      ProductResponse res = await PosApiProvider().getAllProduct(page.toString());

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');


        products.addAll(res.products);
        itemsProList.addAll(res.products);
        itemsProListSearc.addAll(itemsProList);

        isLoadingPro(false);
      }
      else if(res.code==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingPro(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingPro(false);
      update();
    }
  }

  void getDetailsProducr(String proId) async {
    currentStep.value = 1;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? token = sharedPrefs.getString('token');
    try {
      isLoadingdetails(true);
      supAdvdList.clear();
      dio.FormData data = new dio.FormData.fromMap({
        "token": token,
      });
      itemDetails = '';
      ProductDetailsResponse res =
          await PosApiProvider().getDetailsProduct(proId, data);

      if (res.code == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lang = prefs.getString('lang');
        itemDetails = res.products;
        for (int i = 0; i < proList.length; i++) {
          if (proList[i].name.toString().toLowerCase() ==
              itemDetails.type.toString().toLowerCase()) {
            proItem = proList[i];
          }
        }
        if(proItem!.id=='2'){
          getProduct();
          productListSele.clear();
           for(int i=0;i<res.comboList.length;i++){
             final controllerq =
             TextEditingController();
             final controllerpr =
             TextEditingController();
             controllerq.text= res.comboList[i].qty.toString().split('.')[0];
             controllerpr.text= res.comboList[i].price.toString().replaceAll('.0000','');

             productListSele.add(TableComboModelEdit(
                 quan: controllerq,
                 pric: controllerpr,
                 itemPro: res.comboList[i]));
           }


        }
        for (int i = 0; i < codeListType.length; i++) {
          if (codeListType[i].name.toString().toLowerCase() ==
              itemDetails.barcode_symbology.toString().toLowerCase()) {
            codeItel = codeListType[i];
          }
        }
        for (int i = 0; i < brandList.length; i++) {
          if (brandList[i].id.toString() == itemDetails.brand.toString()) {
            brandItem = brandList[i];
          }
        }
        for (int i = 0; i < catList.length; i++) {
          if (catList[i].id.toString() == itemDetails.category_id.toString()) {
            catItem = catList[i];
          }
        }
        if(catItem==null){
          getSubCat(itemDetails.category_id.toString());

        }else{
          getSubCat(catItem!.id);

        }

        for (int i = 0; i < unitList.length; i++) {
          if (unitList[i].id.toString() == itemDetails.sale_unit.toString()) {
            unitSaleItem = unitList[i];
          }
        }
        for (int i = 0; i < unitList.length; i++) {
          if (unitList[i].id.toString() ==
              itemDetails.purchase_unit.toString()) {
            unitPurItem = unitList[i];
          }
        }
        for (int i = 0; i < unitList.length; i++) {
          if (unitList[i].id.toString() == itemDetails.unit.toString()) {
            unitItem = unitList[i];
          }
        }
        for (int i = 0; i < taxMethodList.length; i++) {
          if (taxMethodList[i].id.toString() ==
              itemDetails.tax_method.toString()) {
            taxMethodItem = taxMethodList[i];
          }
        }
        for (int i = 0; i < taxList.length; i++) {
          if (taxList[i].id.toString() == itemDetails.tax_rate.toString()) {
            taxItem = taxList[i];
          }
        }
        if (itemDetails.supplier1 == '0' || itemDetails.supplier1 == '') {
        } else {
          final controllern = TextEditingController();
          final controllerp = TextEditingController();
          controllern.text = itemDetails.supplier1_part_no;
          controllerp.text = itemDetails.supplier1price;
          WarehouseModelList? subI;
          for (int i = 0; i < suplierList.length; i++) {
            if (suplierList[i].id.toString() == itemDetails.supplier1) {
              subI = suplierList[i];
            }
          }

          supAdvdList.add(addSupp(
              supAddList: suplierList,
              supn: controllern,
              supp: controllerp,
              supItemAdd: subI));
        }
        if (itemDetails.supplier2 == '0' || itemDetails.supplier2 == '') {
        } else {
          final controllern = TextEditingController();
          final controllerp = TextEditingController();
          controllern.text = itemDetails.supplier2_part_no;
          controllerp.text = itemDetails.supplier2price;
          WarehouseModelList? subI;
          for (int i = 0; i < suplierList.length; i++) {
            if (suplierList[i].id.toString() == itemDetails.supplier2) {
              subI = suplierList[i];
            }
          }

          supAdvdList.add(addSupp(
              supAddList: suplierList,
              supn: controllern,
              supp: controllerp,
              supItemAdd: subI));
        }

        if (itemDetails.supplier3 == '0' || itemDetails.supplier3 == '') {
        } else {
          final controllern = TextEditingController();
          final controllerp = TextEditingController();
          controllern.text = itemDetails.supplier3_part_no;
          controllerp.text = itemDetails.supplier3price;
          WarehouseModelList? subI;
          for (int i = 0; i < suplierList.length; i++) {
            if (suplierList[i].id.toString() == itemDetails.supplier3) {
              subI = suplierList[i];
            }
          }

          supAdvdList.add(addSupp(
              supAddList: suplierList,
              supn: controllern,
              supp: controllerp,
              supItemAdd: subI));
        }
        if (itemDetails.supplier4 == '0' || itemDetails.supplier4 == '') {
        } else {
          final controllern = TextEditingController();
          final controllerp = TextEditingController();
          controllern.text = itemDetails.supplier4_part_no;
          controllerp.text = itemDetails.supplier4price;
          WarehouseModelList? subI;
          for (int i = 0; i < suplierList.length; i++) {
            if (suplierList[i].id.toString() == itemDetails.supplier4) {
              subI = suplierList[i];
            }
          }

          supAdvdList.add(addSupp(
              supAddList: suplierList,
              supn: controllern,
              supp: controllerp,
              supItemAdd: subI));
        }

        if (itemDetails.supplier5 == '0' || itemDetails.supplier5 == '') {
        } else {
          final controllern = TextEditingController();
          final controllerp = TextEditingController();
          controllern.text = itemDetails.supplier5_part_no;
          controllerp.text = itemDetails.supplier5price;
          WarehouseModelList? subI;
          for (int i = 0; i < suplierList.length; i++) {
            if (suplierList[i].id.toString() == itemDetails.supplier5) {
              subI = suplierList[i];
            }
          }

          supAdvdList.add(addSupp(
              supAddList: suplierList,
              supn: controllern,
              supp: controllerp,
              supItemAdd: subI));
        }
        if (itemDetails.image.toString() == '' ||
            itemDetails.image.toString() == 'no_image.png' ||
            itemDetails.image.toString() == 'null') {
          itemDetails.image = '';
        }
        productN.text = itemDetails.name;
        nameAra.text = itemDetails.second_name;
        codeTexts.text = itemDetails.code;
        proDetails.text = itemDetails.product_details;
        proDetailsP.text = itemDetails.details;
        prop.text = itemDetails.promo_price;
        dates.value = itemDetails.start_date;
        datee.value = itemDetails.end_date;

        if (itemDetails.promotion.toString() == '1') {
          isCheckedHide = true;
        } else {
          isCheckedHide = false;
        }
        if (itemDetails.weight.toString().split('.')[0] == '0') {
          weight.text = '';
        } else {
          weight.text = itemDetails.weight;
        }
        if(itemDetails.cost.toString()!='') {
          if (itemDetails.cost.toString().split('.')[1] == '0000') {
            cost.text = itemDetails.cost.toString().split('.')[0] + '.' + '0';
          } else {
            cost.text = itemDetails.cost;
          }
        }
        if (itemDetails.price.toString().split('.')[1] == '0000') {
          price.text = itemDetails.price.toString().split('.')[0] + '.' + '0';
        } else {
          price.text = itemDetails.price;
        }
        if(itemDetails.cost.toString()!='') {

          if (itemDetails.alert_quantity.toString().split('.')[1] == '0000') {
          alert.text =
              itemDetails.alert_quantity.toString().split('.')[0] + '.' + '0';
        } else {
          alert.text = itemDetails.alert_quantity;
        }}

        isLoadingdetails(false);
      }
      else if(res.code==503 && res.message.toString()=='Api feature is disabled'){
        isLoadingdetails(false);
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      isLoadingdetails(false);
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
    } else if (currentStep.value == 2) {
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
    } else if (currentStep.value == 3) {
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
          proItem!.id.toString() == '3') {
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
      EditPro(context);
    }
  }

  void EditPro(BuildContext context) async {
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
       /* if (supAdvdList.value.length > 0) {
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
        }*/
      } else if (proItem!.id.toString() == '3') {
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
      } else if (proItem!.id.toString() == '4') {
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
      } else if (proItem!.id.toString() == '2') {
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

      AddCustomerResponse result =
          await ProductApiProvider().editProduct(data, itemDetails.id);
      PosController posController = Get.put(PosController());

      if (result.code == 200) {
        if (result.message.toString() == 'product_updated') {
          page=1;

          Get.back();
          posController.getPosDefault();
          getAllPro();

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
}
