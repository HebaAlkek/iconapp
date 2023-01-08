import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/country_state_package.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/custom_mode_arabic.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/tex_model.dart';
import 'package:icon/model/unit_model.dart';
import 'package:lottie/lottie.dart';

class StepThreeProductEdit extends StatefulWidget {


  @override
  _StepThreeProductEdit createState() => _StepThreeProductEdit();
}

class _StepThreeProductEdit extends State<StepThreeProductEdit>
    with TickerProviderStateMixin {
  ProductAllController proAllController = Get.put(ProductAllController());

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            height: Get.height - 150,
            child: Obx(() => proAllController.isLoading.value == true
                ? Center(
              child: Lottie.asset('assets/images/loading.json',
                  width: 90, height: 90),
            )
                : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    color: Colors.white,
                    //   height: Get.height,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' * ' + S.of(context).procode,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                child: Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(10, 0, 10, 5),
                                    child: TextField(
                                      controller: proAllController.codeTexts,
                                      style: TextStyle(
                                          color: Color(0xFF002e80)),
                                      decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.all(15),
                                          labelStyle: TextStyle(
                                              color: Color(0xFF002e80)),
                                          focusedBorder:
                                          OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder:
                                          new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.transparent),
                                          ),
// and:

                                          suffixStyle: TextStyle(
                                              color: Color(0xFF002e80)),
                                          hintText: S.of(context).procode,
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          )),
                                    )),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF002e80),
                                          blurRadius: 2,
                                          spreadRadius: 0)
                                    ]),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' * ' + S.of(context).sym,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 15, 10, 15),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              CustomerModelList>(
                                            value: proAllController.codeItel,
                                            isDense: true,
                                            onChanged:
                                                (CustomerModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController.codeItel = val;
                                              });
                                            },
                                            items: proAllController.codeListType
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  CustomerModelList>(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).sym,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).Brand,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 15, 10, 15),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              BrandModelList>(
                                            value: proAllController.brandItem,
                                            isDense: true,
                                            onChanged: (BrandModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController.brandItem = val;
                                              });
                                            },
                                            items: proAllController.brandList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  BrandModelList>(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(0xFF002e80),
                                            hint: Text(
                                              S
                                                  .of(context)
                                                  .Brand
                                                  .replaceAll(':', ''),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' * ' + S.of(context).Category,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 15, 10, 15),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              CategoryModelList>(
                                            value: proAllController.catItem,
                                            isDense: true,
                                            onChanged:
                                                (CategoryModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController.catItem = val;
                                              });
                                              proAllController.getSubCat(
                                                  proAllController.catItem!.id);
                                            },
                                            items: proAllController.catList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  CategoryModelList>(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).Category,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).sub,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 15, 10, 15),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              CategoryModelList>(
                                            value: proAllController.subItem,
                                            isDense: true,
                                            onChanged:
                                                (CategoryModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController.subItem = val;
                                              });
                                            },
                                            items: proAllController.subCatList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  CategoryModelList>(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).sub,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : Text(
                            ' * ' + S.of(context).prounit,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                                0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(
                                                  0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius:
                                              0)
                                        ]),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .fromLTRB(
                                          10.0,
                                          15,
                                          10,
                                          15),
                                      child:
                                      DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              UnitModelList>(
                                            value: proAllController
                                                .unitItem,
                                            isDense: true,
                                            onChanged:
                                                (UnitModelList?
                                            val) {
                                              FocusScope.of(
                                                  context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController
                                                    .unitItem =
                                                    val;
                                              });
                                            },
                                            items: proAllController
                                                .unitList
                                                .map(
                                                    (final value) {
                                                  return DropdownMenuItem<
                                                      UnitModelList>(
                                                    value: value,
                                                    child: new Text(
                                                        value.name,
                                                        style:
                                                        TextStyle()),
                                                  );
                                                }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(
                                                0xFF002e80),
                                            hint: Text(
                                              S
                                                  .of(context)
                                                  .prounit,
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : SizedBox(
                            height: 20,
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : Text(
                            S.of(context).sale,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                                0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(
                                                  0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius:
                                              0)
                                        ]),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .fromLTRB(
                                          10.0,
                                          15,
                                          10,
                                          15),
                                      child:
                                      DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              UnitModelList>(
                                            value: proAllController
                                                .unitSaleItem,
                                            isDense: true,
                                            onChanged:
                                                (UnitModelList?
                                            val) {
                                              FocusScope.of(
                                                  context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController
                                                    .unitSaleItem =
                                                    val;
                                              });
                                            },
                                            items: proAllController
                                                .unitList
                                                .map(
                                                    (final value) {
                                                  return DropdownMenuItem<
                                                      UnitModelList>(
                                                    value: value,
                                                    child: new Text(
                                                        value.name,
                                                        style:
                                                        TextStyle()),
                                                  );
                                                }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(
                                                0xFF002e80),
                                            hint: Text(
                                              S
                                                  .of(context)
                                                  .sale,
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : SizedBox(
                            height: 20,
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : Text(
                            S.of(context).pur,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                                0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(
                                                  0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius:
                                              0)
                                        ]),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .fromLTRB(
                                          10.0,
                                          15,
                                          10,
                                          15),
                                      child:
                                      DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              UnitModelList>(
                                            value: proAllController
                                                .unitPurItem,
                                            isDense: true,
                                            onChanged:
                                                (UnitModelList?
                                            val) {
                                              FocusScope.of(
                                                  context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController
                                                    .unitPurItem =
                                                    val;
                                              });
                                            },
                                            items: proAllController
                                                .unitList
                                                .map(
                                                    (final value) {
                                                  return DropdownMenuItem<
                                                      UnitModelList>(
                                                    value: value,
                                                    child: new Text(
                                                        value.name,
                                                        style:
                                                        TextStyle()),
                                                  );
                                                }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(
                                                0xFF002e80),
                                            hint: Text(
                                              S.of(context).pur,
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          proAllController.proItem!.id.toString() == '3'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id.toString() ==
                              '4'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : proAllController.proItem!.id
                              .toString() ==
                              '2'
                              ? Visibility(
                            child: Text(''),
                            visible: false,
                          )
                              : SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' * ' + S.of(context).protax,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 15, 10, 15),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              TaxModelList>(
                                            value: proAllController.taxItem,
                                            isDense: true,
                                            onChanged: (TaxModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController.taxItem = val;
                                              });
                                            },
                                            items: proAllController.taxList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  TaxModelList>(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).protax,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' * ' + S.of(context).TaxMethod,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                            child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 15, 10, 15),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton<
                                              CustomerModelAraList>(
                                            value:
                                            proAllController.taxMethodItem,
                                            isDense: true,
                                            onChanged:
                                                (CustomerModelAraList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  new FocusNode());

                                              setState(() {
                                                proAllController.taxMethodItem =
                                                    val;
                                              });
                                            },
                                            items: proAllController.taxMethodList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  CustomerModelAraList>(
                                                value: value,
                                                child: new Text(
                                                    proAllController.languagee == 'en'
                                                        ? value.name
                                                        : value.nameAr,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor:
                                            Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).TaxMethod,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
              shrinkWrap: true,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
