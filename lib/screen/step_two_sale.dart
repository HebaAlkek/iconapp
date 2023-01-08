import 'dart:convert';
import 'dart:ui';

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';

import 'package:icon/model/customer_model.dart';
import 'package:icon/model/paylist_model.dart';
import 'package:icon/model/produce_model.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addWidget {
  TextEditingController texts;
  PayMOdelList cuss;

  addWidget({required this.texts, required this.cuss});
}

class StepTwoSalePage extends StatefulWidget {
  List<dynamic> billerList;
  final String quantity;
  String total;
  final String cusId;
  final String wareId;
  final List<ProductModdelList> products;
  final String langsett;
  String defaultb;

  StepTwoSalePage(
      {required this.billerList,
      required this.quantity,
      required this.total,
      required this.cusId,
      required this.wareId,
      required this.products,
      required this.langsett,
      required this.defaultb});

  @override
  _StepTwoSalePage createState() => _StepTwoSalePage();
}

class _StepTwoSalePage extends State<StepTwoSalePage>
    with TickerProviderStateMixin {
  TextEditingController saleNote = TextEditingController();
  TextEditingController pricef = TextEditingController();
  CustomerModelList? payItem;
  PosController posController = Get.put(PosController());

  List<TextEditingController> _controllers = [];
  CustomerModelList? billerItem;
  List<PayMOdelList> payList = [];
  List<addWidget> _fields = [];
  double tax = 0.0;
  double priceWithoutTax = 0.0;
  bool selected = false;

  List<String> proIds = [];
  List<String> proPricese = [];
  List<String> proQuantity = [];

  @override
  void initState() {
    // TODO: implement initState
    payList.add(
        PayMOdelList(id: '1', name: 'cash', namren: 'cash', namear: 'نقدا'));
    payList.add(PayMOdelList(
        id: '2', name: 'cc', namren: 'cc', namear: 'بطاقة ائتمان'));
    payList.add(
        PayMOdelList(id: '3', name: 'other', namren: 'other', namear: 'أخرى'));
    for (int y = 0; y < widget.products.length; y++) {
      double subSum = ((double.parse(widget.products[y].unit_price) -
              double.parse(widget.products[y].net_price))) *
          widget.products[y].quantity;
      double tr = double.parse(subSum.toStringAsFixed(2));
      tax = tax + tr;

      priceWithoutTax = priceWithoutTax +
          (double.parse(widget.products[y].net_price) *
              widget.products[y].quantity);
    }
/*    if (widget.total.split('.')[1].length > 3) {
      pricef.text = widget.total.split('.')[0] +
          '.' +
          widget.total.split('.')[1].substring(0, 3);
    } else if (widget.total.split('.')[1].length == 2) {
      pricef.text = widget.total.split('.')[0] +
          '.' +
          widget.total.split('.')[1].substring(0, 2);
    } else {
      pricef.text = widget.total.split('.')[0] +
          '.' +
          widget.total.split('.')[1].substring(0, 1);
    }*/
    pricef.text = double.parse(widget.total).toStringAsFixed(2);
    _fields.add(addWidget(texts: pricef, cuss: payList[0]));

    for (int i = 0; i < widget.products.length; i++) {
      setState(() {
        proIds.add(widget.products[i].id);
        proPricese.add(widget.products[i].price);
        proQuantity.add(widget.products[i].quantity.toString());
      });
    }
    for (int i = 0; i < widget.billerList.length; i++) {
      if (widget.billerList[i].id.toString() == widget.defaultb) {
        setState(() {
          billerItem = widget.billerList[i];
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
        backgroundColor: Colors.white,
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
          title: Text(S.of(context).done,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          actions: [
           Center(
              child: InkWell(
                onTap: () async{

                  SharedPreferences sharedPrefs =
                      await SharedPreferences.getInstance();
                  if (billerItem == null) {
                    Flushbar(
                      borderRadius: 8,

                      padding: EdgeInsets.all(10),
                      backgroundGradient: LinearGradient(
                        colors: [
                          Color(0xFF002e80).withOpacity(0.4),
                          Color(0xFF002e80).withOpacity(0.7),
                          Color(0xFF002e80)
                        ],
                        stops: [0.5, 0.8, 1],
                      ),
                      duration: Duration(seconds: 1),
                      boxShadows: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(3, 3),
                          blurRadius: 3,
                        ),
                      ],
                      // All of the previous Flushbars could be dismissed by swiping down
                      // now we want to swipe to the sides
                      dismissDirection:
                      FlushbarDismissDirection.HORIZONTAL,
                      // The default curve is Curves.easeOut
                      forwardAnimationCurve:
                      Curves.fastLinearToSlowEaseIn,
                      title: S.of(context).Error,
                      message: S.of(context).pleaseb,
                    )..show(context);
                  } else {

                    double sum = 0.0;
                    for (int u = 0; u < _fields.length; u++) {
                      sum = sum +
                          double.parse(_fields[u].texts.text);
                    }
                    if (sum > double.parse(widget.total)) {
                      Flushbar(
                        borderRadius: 8,

                        padding: EdgeInsets.all(10),
                        backgroundGradient: LinearGradient(
                          colors: [
                            Color(0xFF002e80).withOpacity(0.4),
                            Color(0xFF002e80).withOpacity(0.7),
                            Color(0xFF002e80)
                          ],
                          stops: [0.5, 0.8, 1],
                        ),
                        duration: Duration(seconds: 3),
                        boxShadows: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                          ),
                        ],
                        // All of the previous Flushbars could be dismissed by swiping down
                        // now we want to swipe to the sides
                        dismissDirection:
                        FlushbarDismissDirection.HORIZONTAL,
                        // The default curve is Curves.easeOut
                        forwardAnimationCurve:
                        Curves.fastLinearToSlowEaseIn,
                        title: S.of(context).Error,
                        message: S.of(context).max,
                      )..show(context);
                    } else if (sum < double.parse(widget.total)) {
                      Flushbar(
                        borderRadius: 8,

                        padding: EdgeInsets.all(10),
                        backgroundGradient: LinearGradient(
                          colors: [
                            Color(0xFF002e80).withOpacity(0.4),
                            Color(0xFF002e80).withOpacity(0.7),
                            Color(0xFF002e80)
                          ],
                          stops: [0.5, 0.8, 1],
                        ),
                        duration: Duration(seconds: 3),
                        boxShadows: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                          ),
                        ],
                        // All of the previous Flushbars could be dismissed by swiping down
                        // now we want to swipe to the sides
                        dismissDirection:
                        FlushbarDismissDirection.HORIZONTAL,
                        // The default curve is Curves.easeOut
                        forwardAnimationCurve:
                        Curves.fastLinearToSlowEaseIn,
                        title: S.of(context).Error,
                        message: S.of(context).min,
                      )..show(context);
                    } else {
                      Get.dialog( Center(
                        child: Lottie.asset('assets/images/loading.json',
                            width: 90, height: 90),
                      ));
                      String? token =
                      sharedPrefs.getString('token');

                      String? userid = sharedPrefs.getString(
                        'userid',
                      );
                      List<String> amountList = [];
                      List<String> paidList = [];

                      double amountz = 0;
                      for (int i = 1; i < _fields.length; i++) {
                        amountz = double.parse(widget.total) -
                            (double.parse(_fields[i].texts.text));
                      }
                      PayMOdelList type = _fields[0].cuss;
                      final last = TextEditingController();
                      last.text = amountz.toString();
                      _fields.removeAt(0);
                      _fields.insert(
                          0, addWidget(cuss: type, texts: last));
                      for (int i = 0; i < _fields.length; i++) {
                        if (i == 0) {
                          amountList.add(pricef.text);
                          paidList.add(_fields[i].cuss.name);
                        } else {
                          amountList.add(_fields[i].texts.text);
                          paidList.add(_fields[i].cuss.name);
                        }
                      }
                      print('widget.cusId' + widget.cusId);
                      print('widget.wareId' + widget.wareId);
                      print('billerItem!.id' + billerItem!.id);

                      dio.FormData data =
                      new dio.FormData.fromMap({
                        "token": token,
                        "customer": widget.cusId,
                        "pos_note":saleNote.text,
                        "warehouse": widget.wareId,
                        "biller": billerItem!.id,
                        "total_items": widget.quantity,
                        "created_by": userid,
                        "amount-paid": widget.total
                      });
                      for (int i = 0; i < proIds.length; i++) {
                        data.fields.add(MapEntry("product_id[$i]",
                            proIds[i].toString()));
                      }
                      for (int i = 0;
                      i < proPricese.length;
                      i++) {
                        data.fields.add(MapEntry(
                            "real_unit_price[$i]",
                            proPricese[i].toString()));
                      }
                      for (int i = 0;
                      i < proPricese.length;
                      i++) {
                        data.fields.add(MapEntry("unit_price[$i]",
                            proPricese[i].toString()));
                      }
                      for (int i = 0;
                      i < proQuantity.length;
                      i++) {
                        data.fields.add(MapEntry("quantity[$i]",
                            proQuantity[i].toString()));
                      }

                      for (int i = 0;
                      i < amountList.length;
                      i++) {
                        data.fields.add(MapEntry("amount[$i]",
                            amountList[i].toString()));
                      }
                      for (int i = 0;
                      i < proQuantity.length;
                      i++) {
                        data.fields.add(MapEntry(
                            "product_base_quantity[$i]",
                            proQuantity[i].toString()));
                      }
                      for (int i = 0; i < paidList.length; i++) {
                        data.fields.add(MapEntry("paid_by[$i]",
                            paidList[i].toString()));
                      }
                      print(data.fields);

                      posController.AddSale(data, context);
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(children: [
                    Text(S.of(context).pay,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward)
                  ]),
                ),
              ),
            )

          ],
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                color: Colors.white,
                //  height: Get.height,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).selectb,
                        style: TextStyle(
                            color: Color(0xFF002e80),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0.0),
                        child: Container(
                          width: Get.width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                      child: DropdownButton<CustomerModelList>(
                                    value: billerItem,
                                    isDense: true,
                                    onChanged: (CustomerModelList? val) {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());

                                      setState(() {
                                        billerItem = val;
                                      });
                                    },
                                    items: widget.billerList.map((final value) {
                                      return DropdownMenuItem<
                                          CustomerModelList>(
                                        value: value,
                                        child: new Text(value.name,
                                            style: TextStyle()),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    iconEnabledColor: Color(0xFF002e80),
                                    hint: Text(
                                      S.of(context).biller,
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
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: Get.width,
                        color: Color(0xFF002e80).withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        S.of(context).adddetails,
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
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                child: TextField(
                                  controller: saleNote,
                                  style: TextStyle(color: Color(0xFF002e80)),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      labelStyle:
                                          TextStyle(color: Color(0xFF002e80)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: new UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
// and:

                                      suffixStyle:
                                          TextStyle(color: Color(0xFF002e80)),
                                      hintText: S.of(context).saleN,
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      )),
                                )),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF002e80),
                                      blurRadius: 2,
                                      spreadRadius: 0)
                                ]),
                          )),

                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).paying,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              if (_fields.length == 3) {
                              } else {
                                if (_fields.length == 1) {
                                  final controller = TextEditingController();
                                  controller.text = (double.parse(pricef.text) -
                                          double.parse(_fields[0].texts.text))
                                      .toString();
                                  final bilItem = CustomerModelList(
                                      company: '', name: '', id: '');
                                  if (_fields[0].cuss.name == payList[0].name) {
                                    setState(() {
                                      _fields.add(addWidget(
                                          texts: controller, cuss: payList[1]));
                                    });
                                  } else if (_fields[0].cuss.name ==
                                          payList[1].name ||
                                      _fields[0].cuss.name == payList[2].name) {
                                    setState(() {
                                      _fields.add(addWidget(
                                          texts: controller, cuss: payList[0]));
                                    });
                                  }
                                } else {
                                  final controller = TextEditingController();
                                  final bilItem = CustomerModelList(
                                      company: '', name: '', id: '');
                                  List<PayMOdelList> _fieldsFirst = [];
                                  _fieldsFirst.addAll(payList);
                                  for (int u = 0; u < payList.length; u++) {
                                    for (int y = 0; y < _fields.length; y++) {
                                      if (_fields[y].cuss.name ==
                                          payList[u].name) {
                                        _fieldsFirst.remove(payList[u]);
                                      }
                                    }
                                  }

                                  setState(() {
                                    _fields.add(addWidget(
                                        texts: controller,
                                        cuss: _fieldsFirst[0]));
                                  });
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xFF002e80),
                                  ),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF002e80),
                                  size: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _fields.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Container(
                                      width: Get.width / 4.5,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 12, 10, 12),
                                          child: TextField(
                                            controller: _fields[index].texts,
                                            keyboardType: TextInputType.number,
                                            onEditingComplete: () {
                                              print('rtyu');
                                            },
                                            onChanged: (val) {
                                              print(pricef.text);
                                              if (val == '' || val == 'null') {
                                                if (_fields.length == 2) {
                                                  if (index == 0) {
                                                    setState(() {
                                                      _fields[1].texts.text =
                                                          (double.parse(widget
                                                                      .total) -
                                                                  (0.0))
                                                              .toString();
                                                      _fields[1]
                                                          .texts
                                                          .text = double.parse(
                                                              _fields[1]
                                                                  .texts
                                                                  .text)
                                                          .toStringAsFixed(2);
                                                    });
                                                  }
                                                }
                                              } else {
                                                if (_fields.length == 2) {
                                                  if (index == 0) {
                                                    setState(() {
                                                      _fields[1]
                                                          .texts
                                                          .text = (double.parse(
                                                                  widget
                                                                      .total) -
                                                              double.parse(
                                                                  _fields[index]
                                                                      .texts
                                                                      .text))
                                                          .toString();
                                                      _fields[1]
                                                          .texts
                                                          .text = double.parse(
                                                              _fields[1]
                                                                  .texts
                                                                  .text)
                                                          .toStringAsFixed(2);
                                                    });
                                                  }
                                                }
                                              }

                                              print(_fields[1].texts.text);

                                              print(widget.total);
                                            },
                                            style: TextStyle(
                                                color: Color(0xFF002e80)),
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true,
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
                                                hintText: index == 0
                                                    ? widget.total
                                                                .split('.')[1]
                                                                .length >
                                                            3
                                                        ? widget.total
                                                                .split('.')[0] +
                                                            '.' +
                                                            widget.total
                                                                .split('.')[1]
                                                                .substring(0, 2)
                                                        : widget.total
                                                                .split('.')[0] +
                                                            '.' +
                                                            widget.total
                                                                .split('.')[1]
                                                                .substring(0, 1)
                                                    : S.of(context).Amount,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                                  child: Container(
                                    width: index != 0
                                        ? Get.width / 2.2
                                        : Get.width / 1.7,
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
                                                10.0, 10, 10, 10),
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton<
                                                    PayMOdelList>(
                                              value: _fields[index].cuss,
                                              isDense: true,
                                              onChanged: (PayMOdelList? val) {
                                                selected = false;
                                                for (int i = 0;
                                                    i < _fields.length;
                                                    i++) {
                                                  if (_fields[i].cuss.name ==
                                                      val!.name) {
                                                    selected = true;
                                                  }
                                                }
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                if (selected == false) {
                                                  setState(() {
                                                    _fields[index].cuss = val!;
                                                  });
                                                } else {
                                                  if (_fields[index].cuss.name ==
                                                val!.name) {

                                                }else{
                                                  Get.snackbar(
                                                      S.of(context).Error,
                                                      S.of(context).payerror);
                                                }}
                                              },
                                              items: payList.map((final value) {
                                                return DropdownMenuItem<
                                                    PayMOdelList>(
                                                  value: value,
                                                  child: new Text(
                                                      posController.languagee ==
                                                              'en'
                                                          ? value.namren
                                                          : value.namear,
                                                      style: TextStyle()),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              iconEnabledColor:
                                                  Color(0xFF002e80),
                                              hint: Text(
                                                S.of(context).paying,
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
                                index == 0
                                    ? Visibility(
                                        child: Text(''),
                                        visible: false,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            _fields.removeAt(index);
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: Color(0xFF002e80),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: Get.width,
                        color: Color(0xFF002e80).withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Quantity,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            widget.quantity + S.of(context).Items,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).pri,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            priceWithoutTax.toString().split('.')[1].length > 3
                                ? priceWithoutTax.toString().split('.')[0] +
                                    '.' +
                                    priceWithoutTax
                                        .toString()
                                        .split('.')[1]
                                        .substring(0, 2) +
                                    ' ' +
                                    posController.currency.value
                                : priceWithoutTax.toString() +
                                    ' ' +
                                    posController.currency.value,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).taxpr,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            tax.toString().split('.')[1].length > 3
                                ? tax.toString().split('.')[0] +
                                    '.' +
                                    tax
                                        .toString()
                                        .split('.')[1]
                                        .substring(0, 2) +
                                    ' ' +
                                    posController.currency.value
                                : tax.toString() +
                                    ' ' +
                                    posController.currency.value,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Total,
                            style: TextStyle(
                                color: Color(0xFF002e80),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            widget.total.toString().split('.')[1].length > 3
                                ? widget.total.toString().split('.')[0] +
                                    '.' +
                                    widget.total
                                        .toString()
                                        .split('.')[1]
                                        .substring(0, 2) +
                                    ' ' +
                                    posController.currency.value
                                : widget.total.toString() +
                                    ' ' +
                                    posController.currency.value,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    /*  Obx(() => posController.isLoadingAdd.value == true
                          ? Center(
                              child: Lottie.asset('assets/images/loading.json',
                                  width: 90, height: 90),
                            )
                          : InkWell(
                              onTap: () async {
                                SharedPreferences sharedPrefs =
                                    await SharedPreferences.getInstance();
                                if (billerItem == null) {
                                  Flushbar(
                                    borderRadius: 8,

                                    padding: EdgeInsets.all(10),
                                    backgroundGradient: LinearGradient(
                                      colors: [
                                        Color(0xFF002e80).withOpacity(0.4),
                                        Color(0xFF002e80).withOpacity(0.7),
                                        Color(0xFF002e80)
                                      ],
                                      stops: [0.5, 0.8, 1],
                                    ),
                                    duration: Duration(seconds: 1),
                                    boxShadows: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                      ),
                                    ],
                                    // All of the previous Flushbars could be dismissed by swiping down
                                    // now we want to swipe to the sides
                                    dismissDirection:
                                        FlushbarDismissDirection.HORIZONTAL,
                                    // The default curve is Curves.easeOut
                                    forwardAnimationCurve:
                                        Curves.fastLinearToSlowEaseIn,
                                    title: S.of(context).Error,
                                    message: S.of(context).pleaseb,
                                  )..show(context);
                                } else {
                                  double sum = 0.0;
                                  for (int u = 0; u < _fields.length; u++) {
                                    sum = sum +
                                        double.parse(_fields[u].texts.text);
                                  }
                                  if (sum > double.parse(widget.total)) {
                                    Flushbar(
                                      borderRadius: 8,

                                      padding: EdgeInsets.all(10),
                                      backgroundGradient: LinearGradient(
                                        colors: [
                                          Color(0xFF002e80).withOpacity(0.4),
                                          Color(0xFF002e80).withOpacity(0.7),
                                          Color(0xFF002e80)
                                        ],
                                        stops: [0.5, 0.8, 1],
                                      ),
                                      duration: Duration(seconds: 3),
                                      boxShadows: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(3, 3),
                                          blurRadius: 3,
                                        ),
                                      ],
                                      // All of the previous Flushbars could be dismissed by swiping down
                                      // now we want to swipe to the sides
                                      dismissDirection:
                                          FlushbarDismissDirection.HORIZONTAL,
                                      // The default curve is Curves.easeOut
                                      forwardAnimationCurve:
                                          Curves.fastLinearToSlowEaseIn,
                                      title: S.of(context).Error,
                                      message: S.of(context).max,
                                    )..show(context);
                                  } else if (sum < double.parse(widget.total)) {
                                    Flushbar(
                                      borderRadius: 8,

                                      padding: EdgeInsets.all(10),
                                      backgroundGradient: LinearGradient(
                                        colors: [
                                          Color(0xFF002e80).withOpacity(0.4),
                                          Color(0xFF002e80).withOpacity(0.7),
                                          Color(0xFF002e80)
                                        ],
                                        stops: [0.5, 0.8, 1],
                                      ),
                                      duration: Duration(seconds: 3),
                                      boxShadows: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(3, 3),
                                          blurRadius: 3,
                                        ),
                                      ],
                                      // All of the previous Flushbars could be dismissed by swiping down
                                      // now we want to swipe to the sides
                                      dismissDirection:
                                          FlushbarDismissDirection.HORIZONTAL,
                                      // The default curve is Curves.easeOut
                                      forwardAnimationCurve:
                                          Curves.fastLinearToSlowEaseIn,
                                      title: S.of(context).Error,
                                      message: S.of(context).min,
                                    )..show(context);
                                  } else {
                                    String? token =
                                        sharedPrefs.getString('token');

                                    String? userid = sharedPrefs.getString(
                                      'userid',
                                    );
                                    List<String> amountList = [];
                                    List<String> paidList = [];

                                    double amountz = 0;
                                    for (int i = 1; i < _fields.length; i++) {
                                      amountz = double.parse(widget.total) -
                                          (double.parse(_fields[i].texts.text));
                                    }
                                    PayMOdelList type = _fields[0].cuss;
                                    final last = TextEditingController();
                                    last.text = amountz.toString();
                                    _fields.removeAt(0);
                                    _fields.insert(
                                        0, addWidget(cuss: type, texts: last));
                                    for (int i = 0; i < _fields.length; i++) {
                                      if (i == 0) {
                                        amountList.add(pricef.text);
                                        paidList.add(_fields[i].cuss.name);
                                      } else {
                                        amountList.add(_fields[i].texts.text);
                                        paidList.add(_fields[i].cuss.name);
                                      }
                                    }
                                    print('widget.cusId' + widget.cusId);
                                    print('widget.wareId' + widget.wareId);
                                    print('billerItem!.id' + billerItem!.id);

                                    dio.FormData data =
                                        new dio.FormData.fromMap({
                                      "token": token,
                                      "customer": widget.cusId,
                                      "warehouse": widget.wareId,
                                      "biller": billerItem!.id,
                                      "total_items": widget.quantity,
                                      "created_by": userid,
                                      "amount-paid": widget.total
                                    });
                                    for (int i = 0; i < proIds.length; i++) {
                                      data.fields.add(MapEntry("product_id[$i]",
                                          proIds[i].toString()));
                                    }
                                    for (int i = 0;
                                        i < proPricese.length;
                                        i++) {
                                      data.fields.add(MapEntry(
                                          "real_unit_price[$i]",
                                          proPricese[i].toString()));
                                    }
                                    for (int i = 0;
                                        i < proPricese.length;
                                        i++) {
                                      data.fields.add(MapEntry("unit_price[$i]",
                                          proPricese[i].toString()));
                                    }
                                    for (int i = 0;
                                        i < proQuantity.length;
                                        i++) {
                                      data.fields.add(MapEntry("quantity[$i]",
                                          proQuantity[i].toString()));
                                    }

                                    for (int i = 0;
                                        i < amountList.length;
                                        i++) {
                                      data.fields.add(MapEntry("amount[$i]",
                                          amountList[i].toString()));
                                    }
                                    for (int i = 0;
                                        i < proQuantity.length;
                                        i++) {
                                      data.fields.add(MapEntry(
                                          "product_base_quantity[$i]",
                                          proQuantity[i].toString()));
                                    }
                                    for (int i = 0; i < paidList.length; i++) {
                                      data.fields.add(MapEntry("paid_by[$i]",
                                          paidList[i].toString()));
                                    }
                                    print(data.fields);

                                    posController.AddSale(data, context);
                                  }
                                }
                              },
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(55, 15, 55, 15),
                                        child: Text(
                                          S.of(context).pay,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color(0xFF002e80).withOpacity(0.4),
                                        Color(0xFF002e80).withOpacity(0.7),
                                        Color(0xFF002e80)
                                      ]),
                                    ),
                                  )),
                            )),*/
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
          shrinkWrap: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
