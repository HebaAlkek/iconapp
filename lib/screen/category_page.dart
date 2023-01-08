import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart' as dio;

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:icon/controller/category_controller.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/store_rpo.dart';
import 'package:icon/screen/add_brand_page.dart';
import 'package:icon/screen/add_category_screen.dart';
import 'package:icon/screen/add_customer_page.dart';
import 'package:icon/screen/add_sub_categoru_screen.dart';
import 'package:icon/screen/category_details_page.dart';
import 'package:icon/screen/product_details_screen.dart';
import 'package:icon/screen/qr_page.dart';
import 'package:icon/screen/sale_screen.dart';
import 'package:icon/utils/app_constant.dart';
import 'package:icon/widget/brand_card.dart';
import 'package:icon/widget/category_card_item.dart';
import 'package:icon/widget/category_main_card.dart';
import 'package:icon/widget/customer_card.dart';
import 'package:icon/widget/product_item_card.dart';
import 'package:icon/widget/sub_category_card.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryPage extends StatefulWidget {
  final String type;

  CategoryPage(this.type);

  @override
  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  bool searchh = false;
  bool searchsub = false;
  bool searchmain = false;
  bool searchBrand = false;
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    posController.CategoryList.clear();
    posController.brandList.clear();
    posController.SubCategoryList.clear();

    posController.CategoryList.addAll(posController.CategoryL);
    if (posController.CategoryList.length > 0) {
      posController.CategoryList.value.removeAt(0);
    }

    posController.brandList.addAll(posController.brandL);
    if (posController.brandList.length > 0) {
      posController.brandList.value.removeAt(0);
    }
    posController.customerList.clear();
    posController.customerList.addAll(posController.customerL);
    posController.getSubAll();
    super.initState();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.7;
    final double itemWidth = size.width / 1.8;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              posController.languagee.value == 'en'
                  ? Icons.keyboard_arrow_left_sharp
                  : Icons.keyboard_arrow_right,
              color: Colors.white,
            )),
        actions: [
          widget.type == '4'
              ? Row(
                  children: [
                    posController.permission.value.length != 0
                        ? posController.cusAdd == '1'
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => AddCustomerPage('1', ''));
                                },
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 21,
                                        ),
                                      ),
                                    )))
                            : Visibility(child: Text(''), visible: false)
                        : InkWell(
                            onTap: () {
                              Get.to(() => AddCustomerPage('1', ''));
                            },
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 21,
                                    ),
                                  ),
                                ))),
                    InkWell(
                        onTap: () {
                          setState(() {
                            searchh = !searchh;
                          });
                          if (searchh == false) {
                            posController.customerList.clear();
                            posController.searchCustomer.text = '';
                            posController.customerList
                                .addAll(posController.customerL);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0.0),
                          child: searchh == false
                              ? Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.white,
                                ),
                        )),
                  ],
                )
              : widget.type == '2'
                  ? Row(
                      children: [
                        posController.permission.value.length != 0
                            ? posController.proAdd == '1'
                                ? InkWell(
                                    onTap: () {
                                      categoryController.getDropListAddPro();
                                      Get.to(
                                          () => AddSubCategoryPage('1', null));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 21,
                                            ),
                                          ),
                                        )))
                                : Visibility(
                                    child: Text(''),
                                    visible: false,
                                  )
                            : InkWell(
                                onTap: () {
                                  categoryController.getDropListAddPro();
                                  Get.to(() => AddSubCategoryPage('1', null));
                                },
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 21,
                                        ),
                                      ),
                                    ))),
                        InkWell(
                            onTap: () {
                              setState(() {
                                searchsub = !searchsub;
                              });
                              if (searchsub == false) {
                                posController.SubCategoryList.clear();
                                posController.searchSub.text = '';
                                posController.SubCategoryList.addAll(
                                    posController.SubCategoryListSearch);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0.0),
                              child: searchsub == false
                                  ? Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                    ),
                            )),
                      ],
                    )
                  : widget.type == '1'
                      ? Row(
                          children: [
                            posController.permission.value.length != 0
                                ? posController.proAdd == '1'
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => AddCategoryPage('1', null));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                  shape: BoxShape.circle),
                                              child: Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 21,
                                                ),
                                              ),
                                            )))
                                    : Visibility(
                                        child: Text(''),
                                        visible: false,
                                      )
                                : InkWell(
                                    onTap: () {
                                      Get.to(() => AddCategoryPage('1', null));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 21,
                                            ),
                                          ),
                                        ))),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    searchmain = !searchmain;
                                  });
                                  if (searchmain == false) {
                                    posController.CategoryList.clear();
                                    posController.searchMAin.text = '';
                                    posController.CategoryList.addAll(
                                        posController.CategoryListSaerch);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 5, 0.0),
                                  child: searchmain == false
                                      ? Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                        ),
                                )),
                          ],
                        )
                      : Row(
                          children: [
                            posController.permission.value.length != 0
                                ? posController.proAdd == '1'
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(() => AddBeandPage('1', null));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                  shape: BoxShape.circle),
                                              child: Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 21,
                                                ),
                                              ),
                                            )))
                                    : Visibility(
                                        child: Text(''),
                                        visible: false,
                                      )
                                : InkWell(
                                    onTap: () {
                                      Get.to(() => AddBeandPage('1', null));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 21,
                                            ),
                                          ),
                                        ))),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    searchBrand = !searchBrand;
                                  });
                                  if (searchBrand == false) {
                                    posController.brandList.clear();
                                    posController.searchBrand.text = '';
                                    posController.brandList
                                        .addAll(posController.brandListSearch);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 5, 0.0),
                                  child: searchBrand == false
                                      ? Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                        ),
                                )),
                          ],
                        )
        ],
        // hides default back button
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xFF002e80).withOpacity(0.4),
              Color(0xFF002e80).withOpacity(0.7),
              Color(0xFF002e80)
            ],
          ),
        )),
        title: widget.type == '4'
            ? searchh == false
                ? Text(S.of(context).addc,
                    style: TextStyle(fontSize: 22.0, color: Colors.white))
                : Padding(
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
                    child: TextField(
                      controller: posController.searchCustomer,
                      autofocus: true,
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          isDense: false,
                          contentPadding: EdgeInsets.zero,
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 15,
                            minHeight: 25,
                          ),
                          hintText: S.of(context).searchh,
                          hintStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  )
            : widget.type == '2'
                ? searchsub == false
                    ? Text(S.of(context).sub,
                        style: TextStyle(fontSize: 22.0, color: Colors.white))
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
                        child: TextField(
                          controller: posController.searchSub,
                          autofocus: true,
                          onChanged: (value) {
                            filterSearchResultsSub(value);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              isDense: false,
                              contentPadding: EdgeInsets.zero,
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 15,
                                minHeight: 25,
                              ),
                              hintText: S.of(context).searchh,
                              hintStyle: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      )
                : widget.type == '1'
                    ? searchmain == false
                        ? Text(S.of(context).Category,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white))
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
                            child: TextField(
                              controller: posController.searchMAin,
                              autofocus: true,
                              onChanged: (value) {
                                filterSearchResultsMain(value);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  isDense: false,
                                  contentPadding: EdgeInsets.zero,
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 15,
                                    minHeight: 25,
                                  ),
                                  hintText: S.of(context).searchh,
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          )
                    : searchBrand == false
                        ? Text(S.of(context).addBrand,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white))
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
                            child: TextField(
                              controller: posController.searchBrand,
                              autofocus: true,
                              onChanged: (value) {
                                filterSearchResulthBrand(value);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  isDense: false,
                                  contentPadding: EdgeInsets.zero,
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 15,
                                    minHeight: 25,
                                  ),
                                  hintText: S.of(context).searchh,
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: widget.type == '1'
          ? Stack(
              children: [
                Obx(() => posController.isLoading.value == true
                    ? Center(
                        child: Lottie.asset('assets/images/loading.json',
                            width: 90, height: 90),
                      )
                    : posController.CategoryList.length == 0
                        ? Container(
                            width: Get.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 8.0),
                              child: Center(
                                child: Lottie.asset('assets/images/nodata.json',
                                    height: 250, width: 250),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        posController.CategoryList.value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () async {
                                            showMaterialModalBottomSheet(
                                                expand: false,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                ),
                                                builder: (context) =>
                                                    CategoryDetails(
                                                      Item: posController
                                                          .CategoryList
                                                          .value[index],
                                                      type: '0',
                                                    ));
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 10, 10),
                                              child: MainCatCard(
                                                posController
                                                    .CategoryList.value[index],
                                                context,
                                              )));
                                    },
                                  ),
                                )),
                          )),
              ],
            )
          : widget.type == '2'
              ? Stack(
                  children: [
                    Obx(() => posController.isLoadingSub.value == true
                        ? Center(
                            child: Lottie.asset('assets/images/loading.json',
                                width: 90, height: 90),
                          )
                        : posController.SubCategoryList.value.length == 0
                            ? Container(
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 15, 10, 8.0),
                                  child: Center(
                                    child: Lottie.asset(
                                        'assets/images/nodata.json',
                                        height: 250,
                                        width: 250),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: posController
                                        .SubCategoryList.value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () async {
                                            showMaterialModalBottomSheet(
                                                expand: false,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                ),
                                                builder: (context) =>
                                                    CategoryDetails(
                                                      Item: posController
                                                          .SubCategoryList
                                                          .value[index],
                                                      type: '1',
                                                    ));
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 10, 10),
                                              child: SubCategoryCard(
                                                posController.SubCategoryList
                                                    .value[index],
                                                context,
                                              )));
                                    },
                                  ),
                                ))),
                  ],
                )
              : widget.type == '3'
                  ? Stack(
                      children: [
                        Obx(() => posController.isLoading.value == true
                            ? Center(
                                child: Lottie.asset(
                                    'assets/images/loading.json',
                                    width: 90,
                                    height: 90),
                              )
                            : posController.brandList.length == 0
                                ? Container(
                                    width: Get.width,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 8.0),
                                      child: Center(
                                        child: Lottie.asset(
                                            'assets/images/nodata.json',
                                            height: 250,
                                            width: 250),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: posController
                                                .brandList.value.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                  onTap: () async {
                                                    showMaterialModalBottomSheet(
                                                        expand: false,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          25),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          25)),
                                                        ),
                                                        builder: (context) =>
                                                            CategoryDetails(
                                                              Item: posController
                                                                  .brandList
                                                                  .value[index],
                                                              type: '0',
                                                            ));
                                                  },
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 5, 10, 10),
                                                      child: BrandCatCard(
                                                          posController
                                                              .brandList
                                                              .value[index],
                                                          context)));
                                            },
                                          ),
                                        )),
                                  )),
                      ],
                    )
                  : Stack(
                      children: [
                        Obx(() => posController.isLoading.value == true
                            ? Center(
                                child: Lottie.asset(
                                    'assets/images/loading.json',
                                    width: 90,
                                    height: 90),
                              )
                            : posController.customerList.length == 0
                                ? Container(
                                    width: Get.width,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 8.0),
                                      child: Center(
                                        child: Lottie.asset(
                                            'assets/images/nodata.json',
                                            height: 250,
                                            width: 250),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.white),
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: ListView.builder(
                                              itemBuilder: (contextt, index) {
                                                return InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        15, 5, 15, 10),
                                                    child: CustomerCard(
                                                        posController
                                                            .customerList
                                                            .value[index],
                                                        context),
                                                  ),
                                                );
                                              },
                                              itemCount: posController
                                                  .customerList.length,
                                            ))),
                                  )),
                      ],
                    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  void filterSearchResults(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(posController.customerL.value);
    if (query.isNotEmpty) {
      final dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()) ||
            item.company
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        posController.customerList.clear();
        posController.customerList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        posController.customerList.clear();
        posController.customerList.addAll(posController.customerL);
      });
    }
  }

  void filterSearchResultsSub(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(posController.SubCategoryListSearch.value);
    if (query.isNotEmpty) {
      final dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name
            .toString()
            .toLowerCase()
            .contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        posController.SubCategoryList.clear();
        posController.SubCategoryList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        posController.SubCategoryList.clear();
        posController.SubCategoryList.addAll(
            posController.SubCategoryListSearch);
      });
    }
  }

  void filterSearchResultsMain(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(posController.CategoryListSaerch.value);
    if (query.isNotEmpty) {
      final dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name
            .toString()
            .toLowerCase()
            .contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        posController.CategoryList.clear();
        posController.CategoryList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        posController.CategoryList.clear();
        posController.CategoryList.addAll(posController.CategoryListSaerch);
      });
    }
  }

  void filterSearchResulthBrand(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(posController.brandListSearch.value);
    if (query.isNotEmpty) {
      final dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name
            .toString()
            .toLowerCase()
            .contains(query.toString().toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        posController.brandList.clear();
        posController.brandList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        posController.brandList.clear();
        posController.brandList.addAll(posController.brandListSearch);
      });
    }
  }
}
