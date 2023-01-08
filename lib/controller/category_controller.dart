import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/pos_api_provider.dart';
import 'package:icon/apiProvider/product_api_provider.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/response/add_customer_response.dart';
import 'package:icon/response/add_product_list_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  CategoryModelList? catItem;
  final catList = [].obs;

  TextEditingController catCode = TextEditingController();
  TextEditingController catName = TextEditingController();
  TextEditingController slug = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController subCatCode = TextEditingController();
  TextEditingController subCatName = TextEditingController();
  TextEditingController subClug = TextEditingController();
  TextEditingController subDes = TextEditingController();
  TextEditingController brandCode = TextEditingController();
  TextEditingController brandName = TextEditingController();
  TextEditingController beandSlug = TextEditingController();
  TextEditingController brandDes = TextEditingController();
  PosController posController = Get.put(PosController());
  ProductController proo = Get.put(ProductController());
  void onInit() {
  getDropListAddPro();

    // TODO: implement onInit
    super.onInit();
  }

  void getDropListAddPro() async {
    try {
      isLoading(true);

      catList.clear();

      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');
      dio.FormData data = new dio.FormData.fromMap({"token": token});
      GetListAddProductResponse res =
          await ProductApiProvider().getDropListAddPro(data);

      if (res.statuecode == 200) {
        catList.clear();

        catList.assignAll(res.categories);

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

  void addMainCat(BuildContext context, PickedFile imageFile) async {
    try {
      if (catName.text == '' || catCode.text == '') {
        Get.snackbar(S.of(context).Error, S.of(context).insetdata,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.dialog(
          Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          ),
        );

        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        dio.FormData data = new dio.FormData.fromMap({
          "token": token,
          "name": catName.text,
          "code": catCode.text,
          "description": des.text,
          "userfile": imageFile.path != ''
              ? await dio.MultipartFile.fromFile(imageFile.path,
                  filename: imageFile.path.split('/').last)
              : null,
        });
        AddCustomerResponse result = await PosApiProvider().addMainCat(data);

        if (result.code == 200) {


          if (result.error == 'null') {
            posController.onInit();
            Get.back();
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
        } else if (result.code == 503 &&
            result.message.toString() == 'Api feature is disabled') {
          Get.back();
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.back();
          Get.snackbar(S.of(context).Error, result.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      update();
    }
  }

  void editMainCat(
      BuildContext context, PickedFile imageFile, String catId) async {
    try {
      if (catName.text == '' || catCode.text == '') {
        Get.snackbar(S.of(context).Error, S.of(context).insetdata,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.dialog(
          Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          ),
        );

        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        dio.FormData data;
        if(imageFile==null){
          data = new dio.FormData.fromMap({
            "token": token,
            "name": catName.text,
            "code": catCode.text,
            "description": des.text,
            "slug": catCode.text,

          });
        }else{
        data = new dio.FormData.fromMap({
            "token": token,
            "name": catName.text,
            "code": catCode.text,
            "description": des.text,
            "slug": catCode.text,
            "userfile": imageFile.path != ''
                ? await dio.MultipartFile.fromFile(imageFile.path,
                filename: imageFile.path.split('/').last)
                : null,
          });
        }

        print(data.fields);
        AddCustomerResponse result =
            await PosApiProvider().editMainCat(data, catId);

        if (result.code == 200) {
          if (result.error == 'null') {
            posController.onInit();
            Get.back();
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
        } else if (result.code == 503 &&
            result.message.toString() == 'Api feature is disabled') {
          Get.back();
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.back();
          Get.snackbar(S.of(context).Error, result.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      update();
    }
  }

  void editBrand(
      BuildContext context, PickedFile imageFile, String brandId) async {
    try {
      if (brandName.text == '') {
        Get.snackbar(S.of(context).Error, S.of(context).insetdata,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.dialog(
          Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          ),
        );

        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        dio.FormData data = new dio.FormData.fromMap({
          "token": token,
          "name": brandName.text,
          "slug": brandCode.text,
          "code": brandCode.text,
          "description": brandDes.text,
          "userfile": imageFile.path != ''
              ? await dio.MultipartFile.fromFile(imageFile.path,
                  filename: imageFile.path.split('/').last)
              : null,
        });
        AddCustomerResponse result =
            await PosApiProvider().editBrand(data, brandId);

        if (result.code == 200) {
          if (result.error == 'null') {
            posController.onInit();
            Get.back();
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
        } else if (result.code == 503 &&
            result.message.toString() == 'Api feature is disabled') {
          Get.back();
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.back();
          Get.snackbar(S.of(context).Error, result.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      update();
    }
  }

  void editSubCat(
      BuildContext context, PickedFile imageFile, String catId) async {
    try {
      if (subCatName.text == '' || subCatCode.text == '' || catItem == null) {
        Get.snackbar(S.of(context).Error, S.of(context).insetdata,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.dialog(
          Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          ),
        );

        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        dio.FormData data = new dio.FormData.fromMap({
          "token": token,
          "name": subCatName.text,
          "code": subCatCode.text,
          "description": subDes.text,
          "parent": catItem!.id,
          "slug": subCatCode.text,
          "userfile": imageFile.path != ''
              ? await dio.MultipartFile.fromFile(imageFile.path,
                  filename: imageFile.path.split('/').last)
              : null,
        });
        print(data.fields);
        AddCustomerResponse result =
            await PosApiProvider().editMainCat(data, catId);
        if (result.code == 200) {
          if (result.error == 'null') {
          //  posController.getSubCat(posController.mainItem.id);
            posController.getPosDefaultForSub();
            posController.getSubAll();
            Get.back();
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
        } else if (result.code == 503 &&
            result.message.toString() == 'Api feature is disabled') {
          Get.back();
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.back();
          Get.snackbar(S.of(context).Error, result.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      update();
    }
  }

  void deleteCat(BuildContext context, String catId, String type) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  posController.languagee=='en'? Text('Are you sure you want to delete?'):
                  Text('هل تريد الحذف بالتأكيد؟',style: TextStyle(fontWeight: FontWeight.bold,
                      color: Color(0xFF005189)),textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            print('yes selected');
                            Navigator.of(context).pop();

                            try {
                              Get.dialog(
                                Center(
                                  child:
                                  Lottie.asset('assets/images/loading.json', width: 90, height: 90),
                                ),
                              );

                              AddCustomerResponse result = await PosApiProvider().deleteCat(catId);

                              if (result.code == 200) {
                                if (result.error == 'null') {

                                  if (type == '1') {
                                    posController.onInit();
                                  } else {
                                    posController.getSubCat(posController.mainItem.id);
                                    posController.getPosDefaultForSub();
                                  }

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
                              } else if (result.code == 503 &&
                                  result.message.toString() == 'Api feature is disabled') {
                                Get.back();
                                Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
                                    backgroundColor: Colors.grey.withOpacity(0.6));
                              } else {
                                Get.back();
                                Get.snackbar(S.of(context).Error, result.message,
                                    backgroundColor: Colors.grey.withOpacity(0.6));
                              }
                            } finally {
                              update();
                            }                          },
                          child:  posController.languagee=='en'?Text('Yes'):Text('موافق'),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF005189)),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('no selected');
                              Navigator.of(context).pop();
                            },
                            child: Text(S.of(context).Cancel, style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });





  }

  void deleteBrand(BuildContext context, String brandId) async {
    try {
      Get.dialog(
        Center(
          child:
              Lottie.asset('assets/images/loading.json', width: 90, height: 90),
        ),
      );

      AddCustomerResponse result = await PosApiProvider().deleteBrand(brandId);

      if (result.code == 200) {


        if (result.error == 'null') {
          posController.onInit();
          proo.onInit();
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
      } else if (result.code == 503 &&
          result.message.toString() == 'Api feature is disabled') {
        Get.back();
        Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.back();
        Get.snackbar(S.of(context).Error, result.message,
            backgroundColor: Colors.grey.withOpacity(0.6));
      }
    } finally {
      update();
    }
  }

  void addSubCat(BuildContext context, PickedFile imageFile) async {
    try {
      if (subCatName.text == '' || subCatCode.text == '' || catItem == null) {
        Get.snackbar(S.of(context).Error, S.of(context).insetdata,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.dialog(
          Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          ),
        );

        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        dio.FormData data = new dio.FormData.fromMap({
          "token": token,
          "name": subCatName.text,
          "code": subCatCode.text,
          "description": subDes.text,
          "parent": catItem!.id,
          "userfile": imageFile.path != ''
              ? await dio.MultipartFile.fromFile(imageFile.path,
                  filename: imageFile.path.split('/').last)
              : null,
        });
        print(data.fields);
        AddCustomerResponse result = await PosApiProvider().addMainCat(data);

        if (result.code == 200) {


          if (result.error == 'null') {
            posController.getSubAll();
            posController.getPosDefaultForSub();

            Get.back();
            subCatName.text = '';
            subCatCode.text = '';
            subDes.text = '';
            catItem = null;
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
        } else if (result.code == 503 &&
            result.message.toString() == 'Api feature is disabled') {
          Get.back();
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.back();
          Get.snackbar(S.of(context).Error, result.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      update();
    }
  }

  void addBrand(BuildContext context, PickedFile imageFile) async {
    try {
      if (brandName.text == '') {
        Get.snackbar(S.of(context).Error, S.of(context).insetdata,
            backgroundColor: Colors.grey.withOpacity(0.6));
      } else {
        Get.dialog(
          Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          ),
        );

        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        String? token = sharedPrefs.getString('token');
        dio.FormData data = new dio.FormData.fromMap({
          "token": token,
          "name": brandName.text,
          "slug": brandCode.text,
          "code": brandCode.text,
          "description": brandDes.text,
          "userfile": imageFile.path != ''
              ? await dio.MultipartFile.fromFile(imageFile.path,
                  filename: imageFile.path.split('/').last)
              : null,
        });
        AddCustomerResponse result = await PosApiProvider().addBrand(data);

        if (result.code == 200) {

          if (result.error == 'null') {
            posController.onInit();
            Get.back();
            Get.back();
          } else {
            Get.back();
            if( result.error.toString().contains('The slug field may only contain alpha-numeric characters, underscores, and dashes.')){
              if(posController.languagee.value=='ar'){
                Get.snackbar(
                    S.of(context).Error,
                    'يجب أن يحتوي رمز الماركة على أرقام أو رموز مثل(- و _ )...',
                    backgroundColor: Colors.grey.withOpacity(0.6));
              }else{
                Get.snackbar(
                    S.of(context).Error,
                    result.error
                        .replaceAll('<p>', '')
                        .toString()
                        .replaceAll('</p>', ''),
                    backgroundColor: Colors.grey.withOpacity(0.6));
              }
            }else{
              Get.snackbar(
                  S.of(context).Error,
                  result.error
                      .replaceAll('<p>', '')
                      .toString()
                      .replaceAll('</p>', ''),
                  backgroundColor: Colors.grey.withOpacity(0.6));
            }

          }
        } else if (result.code == 503 &&
            result.message.toString() == 'Api feature is disabled') {
          Get.back();
          Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).accesss,
              backgroundColor: Colors.grey.withOpacity(0.6));
        } else {
          Get.back();
          Get.snackbar(S.of(context).Error, result.message,
              backgroundColor: Colors.grey.withOpacity(0.6));
        }
      }
    } finally {
      update();
    }
  }
}
