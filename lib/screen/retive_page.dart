import 'dart:ui';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/retrive_controller.dart';
import 'package:icon/generated/l10n.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RetrivePage extends StatefulWidget {
  String result;
  String type;

  RetrivePage(this.result, this.type);

  @override
  _RetrivePage createState() => _RetrivePage();
}

class _RetrivePage extends State<RetrivePage> with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());

  RetriveController revController = Get.put(RetriveController());

  @override
  void initState() {
    if (widget.type == '1') {
      revController.getRetriveSale(widget.result, context);
    } else {
      revController.getPurDetails(widget.result, context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () async {
                Get.back();
              },
              child: Icon(
                posController.languagee.value == 'en'
                    ? Icons.keyboard_arrow_left_sharp
                    : Icons.keyboard_arrow_right,
                color: Colors.white,
              )),
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
          title: Text(S.of(context).addr,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Obx(() => revController.isLoading.value == true
            ? Center(
                child: Lottie.asset('assets/images/loading.json',
                    width: 90, height: 90),
              )
            : revController.revProductListLast.value.isEmpty
                ? Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 8.0),
                      child: Center(
                        child: Lottie.asset('assets/images/nodata.json',
                            height: 250, width: 250),
                      ),
                    ),
                  )
                : revController.quanvisi.value == 0.0
                    ? Container(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 50, 10, 8.0),
                          child: Center(
                            child: Lottie.asset('assets/images/nodata.json',
                                height: 250, width: 250),
                          ),
                        ),
                      )
                    : ListView(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).Products,
                                          style: TextStyle(
                                              color: Color(0xFF002e80),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          itemBuilder: (context, index) {
                                            return revController
                                                        .revProductListLast
                                                        .value[index]
                                                        .qtybase
                                                        .toString()
                                                        .split('.')[0]
                                                        .toString() ==
                                                    '0'
                                                ? Visibility(
                                                    child: Text(''),
                                                    visible: false,
                                                  )
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                blurRadius: 1,
                                                                spreadRadius: 0)
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 10, 10, 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        Get.width /
                                                                            3,
                                                                    child: Text(
                                                                      posController.languagee ==
                                                                              'en'
                                                                          ? revController
                                                                              .revProductListLast
                                                                              .value[
                                                                                  index]
                                                                              .name
                                                                          : revController
                                                                              .revProductListLast
                                                                              .value[index]
                                                                              .second_name,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          S.of(context).price +
                                                                              double.parse(revController.revProductListLast.value[index].lastPrice.toString()).toStringAsFixed(2),
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                            ','),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          S.of(context).Quantity +
                                                                              ' : ' +
                                                                              revController.revProductListLast.value[index].qtybase.toString().split('.')[0].toString(),
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )
                                                                        /*: revController
                                                                              .revProductListLast
                                                                              .value[index]
                                                                              .type_tax
                                                                              .toString() ==
                                                                          '1'
                                                                      ? Text(
                                                                          S.of(context).price +
                                                                              (((double.parse(revController.revProductListLast.value[index].unit_price) * double.parse(revController.revProductListLast.value[index].rate)) / 100) + double.parse(revController.revProductListLast.value[index].unit_price)).toStringAsFixed(2),
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )
                                                                      : Text(
                                                                          S.of(context).price +
                                                                              (double.parse(revController.revProductListLast.value[index].rate) + double.parse(revController.revProductListLast.value[index].unit_price)).toString(),
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )*/
                                                                        ,
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            new Spacer(),
                                                            InkWell(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 1),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .valRet ==
                                                                    int.parse(revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .qtybase
                                                                        .toString()
                                                                        .split(
                                                                            '.')[0])) {
                                                                  Get.snackbar(
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .Error,
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .maxerr,
                                                                      backgroundColor: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.6));
                                                                } else {
                                                                  setState(() {
                                                                    revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .valRet = revController
                                                                            .revProductListLast
                                                                            .value[index]
                                                                            .valRet +
                                                                        1;
                                                                    revController
                                                                            .quantityFirst =
                                                                        revController.quantityFirst +
                                                                            1;
                                                                  });

                                                                  setState(() {
                                                                    revController
                                                                        .totalprice
                                                                        .value = 0.0;
                                                                    revController
                                                                        .quantity
                                                                        .value = 0;
                                                                    revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .qty = (int.parse(revController.revProductListLast.value[index].qty.toString().split('.')[0]) -
                                                                            1)
                                                                        .toString();
                                                                  });
                                                                  setState(() {
                                                                    for (int i =
                                                                            0;
                                                                        i < revController.revProductListLast.length;
                                                                        i++) {
                                                                      revController
                                                                          .quantity
                                                                          .value = revController
                                                                              .quantity
                                                                              .value +
                                                                          int.parse(revController
                                                                              .revProductListLast
                                                                              .value[i]
                                                                              .qty
                                                                              .toString()
                                                                              .split('.')[0]);
                                                                      revController
                                                                          .totalprice
                                                                          .value = revController
                                                                              .totalprice
                                                                              .value +
                                                                          (int.parse(revController.revProductListLast.value[i].qty.toString().split('.')[0]) *
                                                                              double.parse(revController.revProductListLast.value[i].lastPrice));
                                                                    }
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(5),
                                                                  color: Colors.white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        blurRadius:
                                                                            1,
                                                                        spreadRadius:
                                                                            0)
                                                                  ]),
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                                  child: Text(
                                                                    revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .valRet
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  )),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            InkWell(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 1),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .valRet >
                                                                    0) {
                                                                  setState(() {
                                                                    revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .valRet = revController
                                                                            .revProductListLast
                                                                            .value[index]
                                                                            .valRet -
                                                                        1;
                                                                    revController
                                                                            .quantityFirst =
                                                                        revController.quantityFirst -
                                                                            1;
                                                                  });
                                                                  setState(() {
                                                                    revController
                                                                        .totalprice
                                                                        .value = 0.0;
                                                                    revController
                                                                        .quantity
                                                                        .value = 0;
                                                                    revController
                                                                        .revProductListLast
                                                                        .value[
                                                                            index]
                                                                        .qty = (int.parse(revController.revProductListLast.value[index].qty.toString().split('.')[0]) +
                                                                            1)
                                                                        .toString();
                                                                  });
                                                                  setState(() {
                                                                    for (int i =
                                                                            0;
                                                                        i < revController.revProductListLast.length;
                                                                        i++) {
                                                                      revController
                                                                          .quantity
                                                                          .value = revController
                                                                              .quantity
                                                                              .value +
                                                                          int.parse(revController
                                                                              .revProductListLast
                                                                              .value[i]
                                                                              .qty
                                                                              .toString()
                                                                              .split('.')[0]);
                                                                      revController
                                                                          .totalprice
                                                                          .value = revController
                                                                              .totalprice
                                                                              .value +
                                                                          (int.parse(revController.revProductListLast.value[i].qty.toString().split('.')[0]) *
                                                                              double.parse(revController.revProductListLast.value[i].lastPrice));
                                                                    }
                                                                  });
                                                                } else {}
                                                              },
                                                            ),
                                                            /*        Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Container(
                                                              width:
                                                                  Get.width / 6,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(5),
                                                                  color: Colors.white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        blurRadius:
                                                                            1,
                                                                        spreadRadius:
                                                                            0)
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            5,
                                                                            0,
                                                                            5),
                                                                child:
                                                                    TextField(
                                                                  controller: revController
                                                                      .revProductListLast
                                                                      .value[
                                                                          index]
                                                                      .quanText,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  onChanged:
                                                                      (val) {
                                                                    if (val !=
                                                                        '') {
                                                                      if (int.parse(
                                                                              val) >
                                                                          int.parse(revController
                                                                              .revProductListLast
                                                                              .value[index]
                                                                              .qtybase
                                                                              .toString()
                                                                              .split('.')[0])) {
                                                                        Get.snackbar(
                                                                            S.of(context).Error,
                                                                            S.of(context).maxerr,
                                                                            backgroundColor: Colors.grey.withOpacity(0.6));
                                                                        revController.revProductListLast.value[index].quanText.text = revController
                                                                            .revProductListLast
                                                                            .value[index]
                                                                            .qty
                                                                            .toString()
                                                                            .split('.')[0]
                                                                            .toString();
                                                                      } else {
                                                                        if (val !=
                                                                            '') {
                                                                          revController
                                                                              .totalprice
                                                                              .value = 0.0;
                                                                          revController
                                                                              .quantity
                                                                              .value = 0;
                                                                          revController
                                                                              .revProductListLast
                                                                              .value[index]
                                                                              .qty
                                                                         = val;
                                                                          for (int i = 0;
                                                                              i < revController.revProductListLast.length;
                                                                              i++) {
                                                                            revController.quantity.value =
                                                                                revController.quantity.value + int.parse(revController.revProductListLast.value[i].quanText.text);
                                                                            revController.totalprice.value =
                                                                                revController.totalprice.value + (int.parse(revController.revProductListLast.value[i].quanText.text) * double.parse(revController.revProductListLast.value[i].lastPrice));
                                                                          }
                                                                        } else {
                                                                          revController
                                                                              .quantity
                                                                              .value = 0;
                                                                          revController
                                                                              .totalprice
                                                                              .value = 0.0;

                                                                          for (int i = 0;
                                                                              i < revController.revProductListLast.length;
                                                                              i++) {
                                                                            revController.quantity.value =
                                                                                revController.quantity.value + int.parse(revController.revProductListLast.value[i].quanText.text);
                                                                            revController.totalprice.value =
                                                                                revController.totalprice.value + (int.parse(revController.revProductListLast.value[i].quanText.text) * double.parse(revController.revProductListLast.value[i].lastPrice));
                                                                          }
                                                                        }
                                                                      }
                                                                    } else {}
                                                                  },
                                                                  scrollPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF002e80)),
                                                                  decoration: InputDecoration(
                                                                      contentPadding: EdgeInsets.zero,
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
                                                                      isDense: true,
                                                                      suffixStyle: TextStyle(color: Color(0xFF002e80)),
                                                                      hintText: revController.revProductListLast.value[index].qty.toString().split('.')[0],
                                                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          */ /*        InkWell(
                                                            onTap: () async {
                                                              Get.dialog(
                                                                Center(
                                                                  child: Lottie.asset(
                                                                      'assets/images/loading.json',
                                                                      width: 90,
                                                                      height:
                                                                          90),
                                                                ),
                                                              );
                                                              final SharedPreferences
                                                                  sharedPrefs =
                                                                  await SharedPreferences
                                                                      .getInstance();

                                                              Get.back();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 1),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_downward_rounded,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )*/ /*
                                                        ],
                                                      ),*/
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                          },
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: revController
                                              .revProductListLast.value.length,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                S.of(context).Quantity,
                                                style: TextStyle(
                                                    color: Color(0xFF002e80),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                revController.quantityFirst
                                                        .toString() +
                                                    S.of(context).Items,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                S.of(context).Total,
                                                style: TextStyle(
                                                    color: Color(0xFF002e80),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                (double.parse(revController
                                                                .totalpriceFirst
                                                                .toString()) -
                                                            double.parse(
                                                                revController
                                                                    .totalprice
                                                                    .toString()))
                                                        .toStringAsFixed(2) +
                                                    ' ' +
                                                    posController
                                                        .currency.value,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(() => revController.isLoadingAdd.value ==
                                          true
                                      ? Center(
                                          child: Lottie.asset(
                                              'assets/images/loading.json',
                                              width: 90,
                                              height: 90),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            double last = (double.parse(
                                                    revController
                                                        .totalpriceFirst
                                                        .toString()) -
                                                double.parse(revController
                                                    .totalprice
                                                    .toString()));
                                            double lastq = double.parse(
                                                ((double.parse(revController
                                                            .quantityFirst
                                                            .toString()) -
                                                        double.parse(
                                                            revController
                                                                .quantity
                                                                .toString()))
                                                    .toString()));
                                            print(last.toStringAsFixed(2));
                                            print(revController.quantityFirst
                                                .toString());
                                            print(revController.totalpriceFirst
                                                .toString());
                                            print(revController.totalprice
                                                .toString());

                                            SharedPreferences sharedPrefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            String? token =
                                                sharedPrefs.getString('token');

                                            if (widget.type == '1') {
                                              dio.FormData data =
                                              new dio.FormData.fromMap({
                                                "token": token,
                                                "shipping": '0',
                                                "return_surcharge": '0',
                                                "amount-paid": (double.parse(
                                                    revController
                                                        .totalpriceFirst
                                                        .toString()) -
                                                    double.parse(revController
                                                        .totalprice
                                                        .toString()))
                                                    .toStringAsFixed(2),
                                                "paid_by": "cash",
                                                "pcc_type": "Visa",
                                                "total_items": revController
                                                    .quantityFirst
                                                    .toString()
                                              });

                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_id[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .id
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_type[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .product_type
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_code[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .code
                                                        .toString()));
                                              }
                                              if (posController.languagee ==
                                                  'en') {
                                                for (int i = 0;
                                                i <
                                                    revController
                                                        .revProductListLast
                                                        .value
                                                        .length;
                                                i++) {
                                                  data.fields.add(MapEntry(
                                                      "product_name[$i]",
                                                      revController
                                                          .revProductListLast
                                                          .value[i]
                                                          .name
                                                          .toString()));
                                                }
                                              } else {
                                                for (int i = 0;
                                                i <
                                                    revController
                                                        .revProductListLast
                                                        .value
                                                        .length;
                                                i++) {
                                                  data.fields.add(MapEntry(
                                                      "product_name[$i]",
                                                      revController
                                                          .revProductListLast
                                                          .value[i]
                                                          .second_name
                                                          .toString()));
                                                }
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "sale_item_id[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .sale_item_id
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "real_unit_price[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .real_unit_price
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "unit_price[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit_price
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "quantity[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .valRet
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_tax[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .tax_rate
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_unit[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_base_quantity[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .valRet
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "net_price[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit_price
                                                        .toString()));
                                              }
                                              revController.AddReturns(
                                                  data, context, widget.result);
                                            }else{
                                              dio.FormData data =
                                              new dio.FormData.fromMap({
                                                "token": token,
                                                "id": widget.result,
                                                "return_surcharge": '0',
                                               /* "amount-paid": (double.parse(
                                                    revController
                                                        .totalpriceFirst
                                                        .toString()) -
                                                    double.parse(revController
                                                        .totalprice
                                                        .toString()))
                                                    .toStringAsFixed(2),
                                                "paid_by": "cash",
                                                "pcc_type": "Visa",
                                                "total_items": revController
                                                    .quantityFirst
                                                    .toString()*/
                                              });

                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_id[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .id
                                                        .toString()));
                                              }

                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .code
                                                        .toString()));
                                              }


                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "real_unit_cost[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit_price
                                                        .toString()));

                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "unit_cost[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit_price
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "quantity[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .valRet
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_tax[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .tax_rate
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_unit[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "product_base_quantity[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .valRet
                                                        .toString()));
                                              }
                                              for (int i = 0;
                                              i <
                                                  revController
                                                      .revProductListLast
                                                      .value
                                                      .length;
                                              i++) {
                                                data.fields.add(MapEntry(
                                                    "net_cost[$i]",
                                                    revController
                                                        .revProductListLast
                                                        .value[i]
                                                        .unit_price
                                                        .toString()));
                                              }




                                              revController.AddReturnsPur(
                                                  data, context, widget.result);
                                            }
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  30, 0, 30, 0),
                                              child: Container(
                                                width: Get.width / 3,
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 15, 0, 15),
                                                    child: Text(
                                                      S.of(context).Submit,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    )),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color(0xFF002e80)
                                                        .withOpacity(0.4),
                                                    Color(0xFF002e80)
                                                        .withOpacity(0.7),
                                                    Color(0xFF002e80)
                                                  ]),
                                                ),
                                              )),
                                        ))
                                ],
                              ))
                        ],
                        shrinkWrap: true,
                      )));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
