import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/custom_mode_arabic.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/supModelAdd.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepOneProductAdd extends StatefulWidget {
  @override
  _StepOneProductAdd createState() => _StepOneProductAdd();
}

class _StepOneProductAdd extends State<StepOneProductAdd>
    with TickerProviderStateMixin {
  // TextEditingController slug = TextEditingController();

  ProductController proController = Get.put(ProductController());
  final _horizontalScrollController = ScrollController();

  @override
  void initState() {
    //  proController.getDropListAddPro();

    // TODO: implement initState
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 150,
        imageQuality: 100);
    setState(() {
      proController.imageFileDig = pickedFile!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          color: Colors.white,
          height: Get.height - 150,
          child: Obx(() => proController.isLoading.value == true
              ? Center(
                  child: Lottie.asset('assets/images/loading.json',
                      width: 90, height: 90),
                )
              : ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        color: Colors.white,
                        // height: Get.height,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                ' * ' + S.of(context).prot,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
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
                                            value: proController.proItem,
                                            isDense: true,
                                            onChanged:
                                                (CustomerModelAraList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());

                                              setState(() {
                                                proController.proItem = val;
                                              });
                                              if (proController.proItem!.id
                                                      .toString() ==
                                                  '1') {
                                               /* proController.supAdvdList
                                                    .clear();
                                                final controllern =
                                                    TextEditingController();
                                                final controllerp =
                                                    TextEditingController();
                                                WarehouseModelList? subI;

                                                proController.addItemSup(
                                                    controllern,
                                                    controllerp,
                                                    subI);*/
                                              } else if (proController
                                                      .proItem!.id
                                                      .toString() ==
                                                  '2') {
                                                proController.getProduct();
                                                proController.productListSele
                                                    .clear();
                                                for (int u = 0;
                                                    u <
                                                        proController
                                                            .productList.length;
                                                    u++) {
                                                  proController.productList[u]
                                                      .quantitySel = 1;
                                                  proController.productList[u]
                                                          .net_price_sel =
                                                      proController
                                                          .productList[u]
                                                          .net_price;
                                                }
                                              }
                                            },
                                            items: proController.proList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  CustomerModelAraList>(
                                                value: value,
                                                child: new Text(
                                                    proController.lang == 'en'
                                                        ? value.name
                                                        : value.nameAr,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor: Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).prot,
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
                              proController.proItem != null
                                  ? /*proController.proItem!.id == '1'
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).supplier,
                                                  style: TextStyle(
                                                      color: Color(0xFF002e80),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      if (proController
                                                              .supAdvdList
                                                              .length <
                                                          5) {
                                                        final controllern =
                                                            TextEditingController();
                                                        final controllerp =
                                                            TextEditingController();
                                                        WarehouseModelList
                                                            subI = proController
                                                                .suplierList[0];

                                                        proController
                                                            .addItemSup(
                                                                controllern,
                                                                controllerp,
                                                                subI);
                                                      } else {
                                                        Get.snackbar(
                                                            S.of(context).Error,
                                                            S.of(context).maxs,
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .withOpacity(
                                                                        0.6));
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .add_circle_outline_sharp,
                                                      color: Color(0xFF002e80),
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : */proController.proItem!.id == '2'
                                          ? Obx(
                                              () =>
                                                  proController.productList
                                                              .value.length ==
                                                          0
                                                      ? Center(
                                                          child: Lottie.asset(
                                                              'assets/images/loading.json',
                                                              width: 90,
                                                              height: 90),
                                                        )
                                                      : Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  S
                                                                      .of(context)
                                                                      .addp,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF002e80),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      15,
                                                                      0,
                                                                      0.0),
                                                              child: Container(
                                                                width:
                                                                    Get.width,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.0),
                                                                  child: Center(
                                                                    child:
                                                                        Container(
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
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            10.0,
                                                                            15,
                                                                            10,
                                                                            15),
                                                                        child: DropdownButtonHideUnderline(
                                                                            child: DropdownButton<ProductModdelList>(
                                                                          /*  value: proController
                                                            .productItem,*/
                                                                          isDense:
                                                                              true,
                                                                          onChanged:
                                                                              (ProductModdelList? val) {
                                                                            FocusScope.of(context).requestFocus(new FocusNode());

                                                                            setState(() {
                                                                              proController.check = false;
                                                                              proController.productItem = val;
                                                                              final controllerq = TextEditingController();
                                                                              final controllerpr = TextEditingController();

                                                                              if (proController.productListSele.value.length == 0) {
                                                                                controllerq.text = proController.productItem!.quantitySel.toString();
                                                                                controllerpr.text = proController.productItem!.net_price_sel.toString();

                                                                                proController.productListSele.add(TableComboModel(quan: controllerq, pric: controllerpr, itemPro: proController.productItem!));
                                                                                proController.check = true;
                                                                              } else {
                                                                                for (int i = 0; i < proController.productListSele.length; i++) {
                                                                                  if (proController.productListSele[i].itemPro.id.toString() == proController.productItem!.id.toString()) {
                                                                                    proController.productListSele[i].itemPro.quantitySel = proController.productListSele[i].itemPro.quantitySel + 1;
                                                                                    proController.productListSele[i].quan.text = proController.productListSele[i].itemPro.quantitySel.toString();

                                                                                    proController.check = true;
                                                                                  }
                                                                                }
                                                                              }
                                                                              if (proController.check == false) {
                                                                                controllerq.text = proController.productItem!.quantitySel.toString();
                                                                                controllerpr.text = proController.productItem!.net_price_sel.toString();

                                                                                proController.productListSele.add(TableComboModel(quan: controllerq, pric: controllerpr, itemPro: proController.productItem!));
                                                                              }
                                                                            });
                                                                          },
                                                                          items: proController
                                                                              .productList
                                                                              .map((final value) {
                                                                            return DropdownMenuItem<ProductModdelList>(
                                                                              value: value,
                                                                              child: new Text(value.name, style: TextStyle()),
                                                                            );
                                                                          }).toList(),
                                                                          isExpanded:
                                                                              true,
                                                                          iconEnabledColor:
                                                                              Color(0xFF002e80),
                                                                          hint:
                                                                              Text(
                                                                            S.of(context).product,
                                                                            style:
                                                                                TextStyle(
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
                                                              height: 10,
                                                            ),
                                                            proController
                                                                        .productListSele
                                                                        .value
                                                                        .length ==
                                                                    0
                                                                ? Visibility(
                                                                    child: Text(
                                                                        ''),
                                                                    visible:
                                                                        false,
                                                                  )
                                                                : Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                    child:
                                                                        _dataBody())
                                                          ],
                                                        ))
                                          : proController.proItem!.id == '3'
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          S.of(context).fileu,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF002e80),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 0),
                                                        child: Container(
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          5),
                                                              child: TextField(
                                                                controller:
                                                                    proController
                                                                        .digi,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                decoration:
                                                                    InputDecoration(
                                                                        contentPadding: EdgeInsets.all(
                                                                            15),
                                                                        labelStyle: TextStyle(
                                                                            color: Color(
                                                                                0xFF002e80)),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            new UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.transparent),
                                                                        ),
// and:

                                                                        suffixStyle: TextStyle(
                                                                            color: Color(
                                                                                0xFF002e80)),
                                                                        hintText: S
                                                                            .of(
                                                                                context)
                                                                            .fileu,
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              )),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Color(
                                                                        0xFF002e80),
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        0)
                                                              ]),
                                                        )),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          ' * ' +
                                                              S
                                                                  .of(context)
                                                                  .digita,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF002e80),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 0,
                                                    ),
                                                    Center(
                                                        child: proController
                                                                    .imageFileDig ==
                                                                null
                                                            ? InkWell(
                                                                onTap: () {
                                                                  _onImageButtonPressed(
                                                                      ImageSource
                                                                          .gallery,
                                                                      context:
                                                                          context);
                                                                },
                                                                child: Lottie.asset(
                                                                    'assets/images/attach.json',
                                                                    width: 200,
                                                                    height:
                                                                        200))
                                                            :  InkWell(
                                                            onTap: () {
                                                              _onImageButtonPressed(
                                                                  ImageSource
                                                                      .gallery,
                                                                  context:
                                                                  context);
                                                            },
                                                            child:Image.file(
                                                                File(proController
                                                                    .imageFileDig!
                                                                    .path),
                                                                height: 300,
                                                                width:
                                                                    Get.width,
                                                              ))),
                                                  ],
                                                )
                                              : Visibility(
                                                  child: Text(''),
                                                  visible: false,
                                                )
                                  : Visibility(
                                      child: Text(''),
                                      visible: false,
                                    ),
                             /* proController.proItem != null
                                  ? proController.proItem!.id == '1'
                                      ? Obx(() => ListView.builder(
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        0, 15, 0, 0.0),
                                                    child: Container(
                                                      width: Get.width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0.0),
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
                                                                      blurRadius:
                                                                          1,
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
                                                                          WarehouseModelList>(
                                                                value: proController
                                                                    .supAdvdList[
                                                                        index]
                                                                    .supItemAdd,
                                                                isDense: true,
                                                                onChanged:
                                                                    (WarehouseModelList?
                                                                        val) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          new FocusNode());

                                                                  setState(() {
                                                                    proController
                                                                        .supAdvdList[
                                                                            index]
                                                                        .supItemAdd = val!;
                                                                  });
                                                                },
                                                                items: proController
                                                                    .supAdvdList[
                                                                        index]
                                                                    .supAddList
                                                                    .map<
                                                                        DropdownMenuItem<
                                                                            WarehouseModelList>>((WarehouseModelList
                                                                        value) {
                                                                  return DropdownMenuItem<
                                                                      WarehouseModelList>(
                                                                    value:
                                                                        value,
                                                                    child: new Text(
                                                                        value
                                                                            .name,
                                                                        style:
                                                                            TextStyle()),
                                                                  );
                                                                }).toList(),
                                                                isExpanded:
                                                                    true,
                                                                iconEnabledColor:
                                                                    Color(
                                                                        0xFF002e80),
                                                                hint: Text(
                                                                  S
                                                                      .of(context)
                                                                      .prot,
                                                                  style:
                                                                      TextStyle(
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
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width:
                                                                Get.width / 2.3,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            5),
                                                                child:
                                                                    TextField(
                                                                  controller: proController
                                                                      .supAdvdList[
                                                                          index]
                                                                      .supn,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF002e80)),
                                                                  decoration: InputDecoration(
                                                                      contentPadding: EdgeInsets.all(15),
                                                                      labelStyle: TextStyle(color: Color(0xFF002e80)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: new UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.transparent),
                                                                      ),
// and:

                                                                      suffixStyle: TextStyle(color: Color(0xFF002e80)),
                                                                      hintText: S.of(context).supno,
                                                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
                                                                )),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Color(
                                                                          0xFF002e80),
                                                                      blurRadius:
                                                                          2,
                                                                      spreadRadius:
                                                                          0)
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width:
                                                                Get.width / 2.3,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            5),
                                                                child:
                                                                    TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller: proController
                                                                      .supAdvdList[
                                                                          index]
                                                                      .supp,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF002e80)),
                                                                  decoration: InputDecoration(
                                                                      contentPadding: EdgeInsets.all(15),
                                                                      labelStyle: TextStyle(color: Color(0xFF002e80)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: new UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.transparent),
                                                                      ),
// and:

                                                                      suffixStyle: TextStyle(color: Color(0xFF002e80)),
                                                                      hintText: S.of(context).supp,
                                                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
                                                                )),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Color(
                                                                          0xFF002e80),
                                                                      blurRadius:
                                                                          2,
                                                                      spreadRadius:
                                                                          0)
                                                                ]),
                                                          )
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            },
                                            itemCount: proController
                                                .supAdvdList.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                          ))
                                      : Visibility(
                                          child: Text(''),
                                          visible: false,
                                        )
                                  : Visibility(
                                      child: Text(''),
                                      visible: false,
                                    ),*/
                              proController.proItem != null
                                  ? SizedBox(
                                      height: 20,
                                    )
                                  : Visibility(
                                      child: Text(''),
                                      visible: false,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  Scrollbar _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return Scrollbar(
      controller: _horizontalScrollController,
      isAlwaysShown: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _horizontalScrollController,
        child: DataTable(
          border:
              TableBorder.all(color: Colors.black.withOpacity(0.2), width: 1),
          columns: [
            DataColumn(
              label: Text(S.of(context).productn),
            ),
            DataColumn(
              label: Text(S.of(context).Quantity),
            ),
            DataColumn(
              label: Text(S.of(context).Price),
            ),
            DataColumn(
              label: Text(S.of(context).delete),
            ),
            // Lets add one more column to show a delete button
          ],
          rows: proController.productListSele
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(
                      employee.itemPro.name.toString(),
                      textAlign: TextAlign.center,
                    ),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {},
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        controller: employee.quan,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          employee.itemPro.quantitySel =
                              int.parse(employee.quan.text);
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF002e80)),
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(15),
                            labelStyle: TextStyle(color: Color(0xFF002e80)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
// and:

                            suffixStyle: TextStyle(color: Color(0xFF002e80)),
                            hintText: employee.itemPro.quantitySel.toString(),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 13)),
                      ),
                    ),
                    onTap: () {},
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,

                        controller: employee.pric,
                        textAlign: TextAlign.center,
                        onChanged: (val) {
                          employee.itemPro.net_price_sel = employee.pric.text;
                        },
                        style: TextStyle(color: Color(0xFF002e80)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            labelStyle: TextStyle(color: Color(0xFF002e80)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
// and:

                            suffixStyle: TextStyle(color: Color(0xFF002e80)),
                            hintText: employee.itemPro.net_price_sel.toString(),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 13)),
                      ),
                    ),
                    onTap: () {},
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      proController.productItem!.quantitySel = 1;
                      proController.productItem!.net_price_sel =
                          proController.productItem!.net_price;
                      for (int u = 0;
                          u < proController.productListSele.length;
                          u++) {
                        if (employee.itemPro.id ==
                            proController.productListSele[u].itemPro.id) {
                          setState(() {
                            proController.productListSele.removeAt(u);
                          });
                        }
                      }
                    },
                  )),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}
