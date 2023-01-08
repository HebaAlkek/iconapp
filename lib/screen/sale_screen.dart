import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/store_rpo.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:icon/screen/step_two_sale.dart';
import 'package:icon/widget/product_item_card.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class SaleScreen extends StatefulWidget {
  List<ProductModdelList> proLast;
  List<dynamic> wareList;
  List<dynamic> customerList;
  List<dynamic> billerList;

  List<CartMode> proSelect;
  ValueChanged<String> change;
  String langSett;
  String defaultc;
  String defaultb;
  String defaulw;

  SaleScreen(
      {required this.proLast,
      required this.wareList,
      required this.customerList,
      required this.billerList,
      required this.proSelect,
      required this.change,
      required this.langSett,
      required this.defaultc,
      required this.defaultb,
      required this.defaulw});

  @override
  _SaleScreen createState() => _SaleScreen();
}

class _SaleScreen extends State<SaleScreen> with TickerProviderStateMixin {
  TextEditingController priceC = TextEditingController();
  int quantity = 0;
  List<dynamic> customerListLAst = [];
  List<ProductModdelList> alarmLpro = <ProductModdelList>[];

  double price = 0.0;
  WarehouseModelList? wareItem;

  CustomerModelList? customerItem;
  List<CartMode> alarmLi = <CartMode>[];
  PosController posController = Get.put(PosController());
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    customerListLAst.addAll(widget.customerList);
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < widget.proSelect[0].prList.listStorePro.length; i++) {
        quantity =
            quantity + widget.proSelect[0].prList.listStorePro[i].quantity;
        if (widget.proSelect[0].prList.listStorePro[i].tax_method.toString() !=
            'exclusive') {
          price = price +
              (double.parse(widget.proSelect[0].prList.listStorePro[i].price) *
                  widget.proSelect[0].prList.listStorePro[i].quantity);
        } else {
          if (widget.proSelect[0].prList.listStorePro[i].texes.type
                  .toString() ==
              'percentage') {
            price = price +
                ((((double.parse(widget.proSelect[0].prList.listStorePro[i]
                                    .price) *
                                double.parse(widget.proSelect[0].prList
                                    .listStorePro[i].texes.rate)) /
                            100) +
                        double.parse(
                            widget.proSelect[0].prList.listStorePro[i].price)) *
                    widget.proSelect[0].prList.listStorePro[i].quantity);
          } else {
            price = price +
                ((double.parse(widget
                            .proSelect[0].prList.listStorePro[i].texes.rate) +
                        double.parse(
                            widget.proSelect[0].prList.listStorePro[i].price)) *
                    widget.proSelect[0].prList.listStorePro[i].quantity);
          }
        }
      }
    });

    for (int i = 0; i < widget.wareList.length; i++) {
      if (widget.wareList[i].id.toString() == widget.defaulw) {
        setState(() {
          wareItem = widget.wareList[i];
          //    wareItem!.name = widget.wareList[i].name;
          //  wareItem!.id = widget.wareList[i].id;
        });
      }
    }
    for (int i = 0; i < customerListLAst.length; i++) {
      if (customerListLAst[i].id.toString() == widget.defaultc) {
        setState(() {
          customerItem = customerListLAst[i];
          customerItem!.check = true;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () async {
                  final SharedPreferences sharedPrefs =
                      await SharedPreferences.getInstance();

                  sharedPrefs.remove('cartOrder');
                  if (widget.proSelect.length > 0) {
                    alarmLi.add(CartMode(
                        prList: ProStore(
                            listStorePro:
                                widget.proSelect[0].prList.listStorePro),
                        quan: int.parse(quantity.toString()),
                        total: double.parse(price.toString())));
                    String fgfh = json.encode(
                      alarmLi
                          .map<Map<String, dynamic>>(
                              (music) => CartMode.toMap(music))
                          .toList(),
                    );
                    sharedPrefs.setString('cartOrder', fgfh);
                  } else {
                    sharedPrefs.remove('cartOrder');
                  }
                  widget.change('1');
                  Get.back();
                },
                child: Icon(
                  posController.languagee.value == 'en'
                      ? Icons.keyboard_arrow_left_sharp
                      : Icons.keyboard_arrow_right,
                  color: Colors.white,
                )),
            actions: [
              widget.proSelect.length != 0
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          if (wareItem == null) {
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
                              message: S.of(context).selectw,
                            )..show(context);
                          } else if (customerItem == null) {
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
                                message: S.of(context).selectc)
                              ..show(context);
                          } else {
                            if (price.toString().split('.')[1].length > 3) {
                              showMaterialModalBottomSheet(
                                  expand: false,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                  ),
                                  builder: (context) => StepTwoSalePage(
                                        billerList: widget.billerList,
                                        quantity: quantity.toString(),
                                        total: price.toStringAsFixed(2),
                                        cusId: customerItem!.id,
                                        wareId: wareItem!.id,
                                        products: widget
                                            .proSelect[0].prList.listStorePro,
                                        langsett: widget.langSett,
                                        defaultb: widget.defaultb,
                                      ));
                            } else {
                              showMaterialModalBottomSheet(
                                  expand: false,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                  ),
                                  builder: (context) => StepTwoSalePage(
                                        billerList: widget.billerList,
                                        quantity: quantity.toString(),
                                        total: price.toStringAsFixed(2),
                                        cusId: customerItem!.id,
                                        wareId: wareItem!.id,
                                        products: widget
                                            .proSelect[0].prList.listStorePro,
                                        langsett: widget.langSett,
                                        defaultb: widget.defaultb,
                                      ));
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child:  Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(children: [
                              Text(S.of(context).Next,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward)
                            ]),
                          ),
                        ),
                      ),
                    )
                  : Visibility(
                      child: Text(''),
                      visible: false,
                    ),
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
            title: Text(S.of(context).Sales,
                style: TextStyle(fontSize: 22.0, color: Colors.white)),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    children: [
                      Container(
                        color: Color(0xFF002e80).withOpacity(0.1),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).selectw,
                                style: TextStyle(
                                    color: Color(0xFF002e80),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 5, 0, 0.0),
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
                                                  color: Colors.grey,
                                                  blurRadius: 1,
                                                  spreadRadius: 0)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 15, 10, 15),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<
                                                  WarehouseModelList>(
                                            value: wareItem,
                                            isDense: true,
                                            onChanged:
                                                (WarehouseModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());

                                              setState(() {
                                                wareItem = val;
                                              });
                                            },
                                            items: widget.wareList
                                                .map((final value) {
                                              return DropdownMenuItem<
                                                  WarehouseModelList>(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle()),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            iconEnabledColor: Color(0xFF002e80),
                                            hint: Text(
                                              S.of(context).selectw,
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
                                S.of(context).selectc,
                                style: TextStyle(
                                    color: Color(0xFF002e80),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              InkWell(
                                onTap: openAlertBox,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0.0),
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
                                                    color: Colors.grey,
                                                    blurRadius: 2,
                                                    spreadRadius: 0)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10.0, 15, 10, 15),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    customerItem == null
                                                        ? ''
                                                        : customerItem!.name,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  new Spacer(),
                                                  Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: Color(0xFF002e80),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              /*     Padding(
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
                                                  color: Colors.grey,
                                                  blurRadius: 2,
                                                  spreadRadius: 0)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 15, 10, 15),
                                          child: DropdownButtonHideUnderline(
                                              child: DropdownButton<
                                                  CustomerModelList>(value: customerItem,
                                            isDense: true,
                                            onChanged:
                                                (CustomerModelList? val) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());

                                              setState(() {
                                                customerItem = val;
                                              });
                                            },
                                            items: widget.customerList
                                                .map((final value) {
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
                                              S.of(context).selectc,
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
                              ),*/
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
                                    quantity.toString() + S.of(context).Items,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                                    price.toStringAsFixed(2) +
                                        ' ' +
                                        posController.currency.value,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            widget.proSelect.length == 0
                                ? Visibility(
                                    child: Text(''),
                                    visible: false,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) {

                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 1,
                                                    spreadRadius: 0)
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              widget
                                                                  .proSelect[0]
                                                                  .prList
                                                                  .listStorePro[
                                                                      index]
                                                                  .image_url),
                                                          fit: BoxFit.fill)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      posController.languagee
                                                                  .value ==
                                                              'en'
                                                          ? Container(
                                                              width:
                                                                  Get.width / 3,
                                                              child: Text(
                                                                widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            )
                                                          : Container(
                                                              width:
                                                                  Get.width / 3,
                                                              child: Text(
                                                                widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .second_name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 10),
                                                        child: Row(
                                                          children: [
                                                            widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .tax_method
                                                                        .toString() !=
                                                                    'exclusive'
                                                                ? Text(
                                                                    S.of(context).price +
                                                                        widget
                                                                            .proSelect[0]
                                                                            .prList
                                                                            .listStorePro[index]
                                                                            .price
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                : widget
                                                                            .proSelect[
                                                                                0]
                                                                            .prList
                                                                            .listStorePro[
                                                                                index]
                                                                            .texes
                                                                            .type
                                                                            .toString() ==
                                                                        'percentage'
                                                                    ? (((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100) + double.parse(widget.proSelect[0].prList.listStorePro[index].price)).toString().split('.')[1].length >
                                                                            3
                                                                        ? Text(
                                                                            S.of(context).price +
                                                                                (((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100) + double.parse(widget.proSelect[0].prList.listStorePro[index].price)).toString().split('.')[0] +
                                                                                '.' +
                                                                                (((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100) + double.parse(widget.proSelect[0].prList.listStorePro[index].price)).toString().split('.')[1].substring(0, 3),
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )
                                                                        : Text(
                                                                            S.of(context).price +
                                                                                (((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100) + double.parse(widget.proSelect[0].prList.listStorePro[index].price)).toString().split('.')[0] +
                                                                                '.' +
                                                                                (((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100) + double.parse(widget.proSelect[0].prList.listStorePro[index].price)).toString().split('.')[1].substring(0, 1),
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )
                                                                    : Text(
                                                                        S.of(context).price +
                                                                            (double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate) + double.parse(widget.proSelect[0].prList.listStorePro[index].price)).toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                            InkWell(
                                                              onTap: () {
                                                                showAnimatedDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      true,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return ClassicGeneralDialogWidget(
                                                                      titleText: S
                                                                          .of(context)
                                                                          .editp,
                                                                      actions: [
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              width: Get.width,
                                                                              child: TextField(
                                                                                keyboardType: TextInputType.number,
                                                                                controller: priceC,
                                                                                style: TextStyle(color: Color(0xFF002e80)),
                                                                                decoration: InputDecoration(
                                                                                    contentPadding: EdgeInsets.all(15),
                                                                                    labelStyle: TextStyle(color: Color(0xFF002e80)),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(
                                                                                        color: Color(0xFF002e80),
                                                                                      ),
                                                                                    ),
                                                                                    enabledBorder: new UnderlineInputBorder(
                                                                                      borderSide: BorderSide(color: Color(0xFF002e80)),
                                                                                    ),
// and:

                                                                                    hintText: widget.proSelect[0].prList.listStorePro[index].price.toString(),
                                                                                    hintStyle: TextStyle(
                                                                                      color: Colors.grey,
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  InkWell(
                                                                                    onTap: () async {
                                                                                      Get.dialog(
                                                                                        Center(
                                                                                          child: Lottie.asset('assets/images/loading.json', width: 90, height: 90),
                                                                                        ),
                                                                                      );
                                                                                      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                                                                                      if (widget.proSelect[0].prList.listStorePro[index].tax_method.toString() != 'exclusive') {
                                                                                        if (priceC.text == null || priceC.text == '' || priceC.text == 'null') {
                                                                                          Navigator.pop(context);
                                                                                        } else {
                                                                                          setState(() {
                                                                                            price = (price) - (widget.proSelect[0].prList.listStorePro[index].quantity * double.parse(widget.proSelect[0].prList.listStorePro[index].price));
                                                                                            widget.proSelect[0].prList.listStorePro[index].price = int.parse(priceC.text).toString();
                                                                                            price = (price) + (widget.proSelect[0].prList.listStorePro[index].quantity * double.parse(widget.proSelect[0].prList.listStorePro[index].price));
                                                                                          });
                                                                                        }
                                                                                      } else {
                                                                                        if (priceC.text == null || priceC.text == '' || priceC.text == 'null') {
                                                                                          Navigator.pop(context);
                                                                                        } else {
                                                                                          if (widget.proSelect[0].prList.listStorePro[index].texes.type.toString() != 'percentage') {
                                                                                            setState(() {
                                                                                              price = (price) - (widget.proSelect[0].prList.listStorePro[index].quantity * double.parse(widget.proSelect[0].prList.listStorePro[index].price));
                                                                                              widget.proSelect[0].prList.listStorePro[index].price = priceC.text.toString();
                                                                                              price = (price) + (widget.proSelect[0].prList.listStorePro[index].quantity * double.parse(widget.proSelect[0].prList.listStorePro[index].price));
                                                                                            });
                                                                                          } else {
                                                                                            setState(() {
                                                                                              price = (price) - (widget.proSelect[0].prList.listStorePro[index].quantity * double.parse(widget.proSelect[0].prList.listStorePro[index].unit_price));
                                                                                              widget.proSelect[0].prList.listStorePro[index].price = priceC.text.toString();
                                                                                              price = (price) + (widget.proSelect[0].prList.listStorePro[index].quantity * ((double.parse(widget.proSelect[0].prList.listStorePro[index].price)) + (((double.parse(widget.proSelect[0].prList.listStorePro[index].price)) * (double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate))) / 100)));
                                                                                            });
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                      priceC.clear();
                                                                                      sharedPrefs.remove('cartOrder');
                                                                                      alarmLi.add(CartMode(prList: ProStore(listStorePro: widget.proSelect[0].prList.listStorePro), quan: int.parse(quantity.toString()), total: double.parse(price.toString())));
                                                                                      String fgfh = json.encode(
                                                                                        alarmLi.map<Map<String, dynamic>>((music) => CartMode.toMap(music)).toList(),
                                                                                      );
                                                                                      sharedPrefs.setString('cartOrder', fgfh);
                                                                                      Navigator.pop(context);
                                                                                      //     widget.change('1');
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                                                                        child: Container(
                                                                                          width: Get.width / 5,
                                                                                          child: Padding(
                                                                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                                              child: Text(
                                                                                                S.of(context).Edit,
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002e80), fontSize: 15),
                                                                                              )),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: Color(0xFF002e80))),
                                                                                        )),
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      priceC.clear();
                                                                                      //  widget.change('1');

                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Padding(
                                                                                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                                                                        child: Container(
                                                                                          width: Get.width / 5,
                                                                                          child: Padding(
                                                                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                                              child: Text(
                                                                                                S.of(context).Cancel,
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 15),
                                                                                              )),
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: Colors.red)),
                                                                                        )),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    );
                                                                  },
                                                                  animationType:
                                                                      DialogTransitionType
                                                                          .size,
                                                                  curve: Curves
                                                                      .fastOutSlowIn,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                child: Icon(
                                                                  Icons
                                                                      .mode_edit,
                                                                  color: Color(
                                                                      0xFF002e80),
                                                                  size: 14,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                new Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () async {
                                                              Get.dialog(
                                                                  Center(
                                                                    child: Lottie.asset(
                                                                        'assets/images/loading.json',
                                                                        width:
                                                                            90,
                                                                        height:
                                                                            90),
                                                                  ),
                                                                  barrierDismissible:
                                                                      false);

                                                              final SharedPreferences
                                                                  sharedPrefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              setState(() {
                                                                widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .quantity = widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .quantity +
                                                                    1;
                                                                quantity =
                                                                    quantity +
                                                                        1;
                                                                if (widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .tax_method
                                                                        .toString() !=
                                                                    'exclusive') {
                                                                  price = price +
                                                                      double.parse(widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .price);
                                                                } else {
                                                                  if (widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .texes
                                                                          .type
                                                                          .toString() !=
                                                                      'percentage') {
                                                                    setState(
                                                                        () {
                                                                      price = (price) +
                                                                          (double.parse(widget.proSelect[0].prList.listStorePro[index].price) +
                                                                              double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate));
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      price = (price) +
                                                                          (double.parse(widget.proSelect[0].prList.listStorePro[index].price) +
                                                                              ((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100));
                                                                    });
                                                                  }
                                                                }
                                                                sharedPrefs.remove(
                                                                    'lastpro');
                                                                alarmLi.add(CartMode(
                                                                    prList: ProStore(
                                                                        listStorePro: widget
                                                                            .proSelect[
                                                                                0]
                                                                            .prList
                                                                            .listStorePro),
                                                                    quan: int.parse(
                                                                        quantity
                                                                            .toString()),
                                                                    total: double
                                                                        .parse(price
                                                                            .toString())));

                                                                for (int y = 0;
                                                                    y <
                                                                        posController
                                                                            .itemsPro
                                                                            .value
                                                                            .length;
                                                                    y++) {
                                                                  if (posController
                                                                          .itemsPro
                                                                          .value[
                                                                              y]
                                                                          .id ==
                                                                      widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .id) {
                                                                    posController
                                                                        .itemsPro
                                                                        .value[
                                                                            y]
                                                                        .quantity = posController
                                                                            .itemsPro
                                                                            .value[y]
                                                                            .quantity +
                                                                        1;
                                                                  }
                                                                }

                                                                String fgfh =
                                                                    json.encode(
                                                                  alarmLi
                                                                      .map<
                                                                          Map<String,
                                                                              dynamic>>((music) =>
                                                                          CartMode.toMap(
                                                                              music))
                                                                      .toList(),
                                                                );
                                                                sharedPrefs
                                                                    .setString(
                                                                        'cartOrder',
                                                                        fgfh);

                                                                String lastpro =
                                                                    json.encode(
                                                                  alarmLi[0]
                                                                      .prList
                                                                      .listStorePro
                                                                      .map<
                                                                          Map<String,
                                                                              dynamic>>((music) =>
                                                                          ProductModdelList.toMavp(
                                                                              music))
                                                                      .toList(),
                                                                );
                                                                sharedPrefs
                                                                    .setString(
                                                                        'lastpro',
                                                                        lastpro);
                                                              });
                                                              widget
                                                                      .proSelect[0]
                                                                      .prList
                                                                      .listStorePro[
                                                                          index]
                                                                      .quanText
                                                                      .text =
                                                                  widget
                                                                      .proSelect[
                                                                          0]
                                                                      .prList
                                                                      .listStorePro[
                                                                          index]
                                                                      .quantity
                                                                      .toString();
                                                              //   Future.delayed(const Duration(seconds: 10), () {
                                                              Get.back();
                                                            },
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
                                                                        .all(3),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 13,
                                                                ),
                                                              ),
                                                            )),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 0, 10, 0),
                                                          child: Container(
                                                              width: 50,
                                                              height: 30,
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
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
                                                              child: Center(
                                                                  child:
                                                                      TextField(
                                                                controller: widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .quanText,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                // Moves focus to next.
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:(val) async {
                                                                  print(val);
                                                                  if (val ==
                                                                      '' ||
                                                                      val ==
                                                                          null ||
                                                                      val ==
                                                                          'null') {
                                                                    val = '1';
                                                                  }
                                                                  widget
                                                                      .proSelect[
                                                                  0]
                                                                      .prList
                                                                      .listStorePro[
                                                                  index]
                                                                      .quantity = int.parse(val);

                                                                  final SharedPreferences
                                                                  sharedPrefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                                  setState(() {
                                                                    quantity =
                                                                    0;
                                                                    price=0;
                                                                    for (int y =
                                                                    0;
                                                                    y < widget.proSelect[0].prList.listStorePro.length;
                                                                    y++) {
                                                                      quantity = quantity +
                                                                         widget
                                                                              .proSelect[0]
                                                                              .prList
                                                                              .listStorePro[y]
                                                                              .quantity;

                                                                      if (widget
                                                                          .proSelect[0]
                                                                          .prList
                                                                          .listStorePro[y]
                                                                          .tax_method
                                                                          .toString() !=
                                                                          'exclusive') {
                                                                        price = price +
                                                                            (   double.parse(widget.proSelect[0].prList.listStorePro[y].price)*  widget
                                                                                .proSelect[
                                                                            0]
                                                                                .prList
                                                                                .listStorePro[
                                                                            y]
                                                                                .quantity);
                                                                      } else {
                                                                        if (widget.proSelect[0].prList.listStorePro[y].texes.type.toString() !=
                                                                            'percentage') {
                                                                          setState(
                                                                                  () {

                                                                                price =
                                                                                    (price) + ((double.parse(widget.proSelect[0].prList.listStorePro[y].price)*  widget
                                                                                        .proSelect[
                                                                                    0]
                                                                                        .prList
                                                                                        .listStorePro[
                                                                                    y]
                                                                                        .quantity) + double.parse(widget.proSelect[0].prList.listStorePro[y].texes.rate));
                                                                              });
                                                                        } else {
                                                                          setState(
                                                                                  () {
                                                                                price =
                                                                                    (price) + ((double.parse(widget.proSelect[0].prList.listStorePro[y].price)* widget
                                                                                        .proSelect[
                                                                                    0]
                                                                                        .prList
                                                                                        .listStorePro[
                                                                                    y]
                                                                                        .quantity) + ((double.parse(widget.proSelect[0].prList.listStorePro[y].price) * double.parse(widget.proSelect[0].prList.listStorePro[y].texes.rate)) / 100));
                                                                              });
                                                                        }
                                                                      }
                                                                    }

                                                                    sharedPrefs
                                                                        .remove(
                                                                        'lastpro');
                                                                    alarmLi.add(CartMode(
                                                                        prList: ProStore(
                                                                            listStorePro: widget
                                                                                .proSelect[
                                                                            0]
                                                                                .prList
                                                                                .listStorePro),
                                                                        quan: int.parse(quantity
                                                                            .toString()),
                                                                        total: double.parse(
                                                                            price.toString())));

                                                                    for (int y =
                                                                    0;
                                                                    y < posController.itemsPro.value.length;
                                                                    y++) {
                                                                      if (posController
                                                                          .itemsPro
                                                                          .value[
                                                                      y]
                                                                          .id ==
                                                                          widget
                                                                              .proSelect[0]
                                                                              .prList
                                                                              .listStorePro[index]
                                                                              .id) {
                                                                        posController
                                                                            .itemsPro
                                                                            .value[
                                                                        y]
                                                                            .quantity =int.parse(val);
                                                                      }
                                                                    }

                                                                    String
                                                                    fgfh =
                                                                    json.encode(
                                                                      alarmLi
                                                                          .map<Map<String, dynamic>>((music) =>
                                                                          CartMode.toMap(music))
                                                                          .toList(),
                                                                    );
                                                                    sharedPrefs
                                                                        .setString(
                                                                        'cartOrder',
                                                                        fgfh);

                                                                    String
                                                                    lastpro =
                                                                    json.encode(
                                                                      alarmLi[0]
                                                                          .prList
                                                                          .listStorePro
                                                                          .map<Map<String, dynamic>>((music) =>
                                                                          ProductModdelList.toMavp(music))
                                                                          .toList(),
                                                                    );
                                                                    sharedPrefs.setString(
                                                                        'lastpro',
                                                                        lastpro);
                                                                  });
                                                                } ,
                                                                onSubmitted:
                                                                    (val) async {
                                                                      print(val);
                                                                      if (val ==
                                                                          '' ||
                                                                          val ==
                                                                              null ||
                                                                          val ==
                                                                              'null') {
                                                                        val = '1';
                                                                      }
                                                                      widget
                                                                          .proSelect[
                                                                      0]
                                                                          .prList
                                                                          .listStorePro[
                                                                      index]
                                                                          .quantity = int.parse(val);
                                                                      widget
                                                                          .proSelect[
                                                                      0]
                                                                          .prList
                                                                          .listStorePro[
                                                                      index]
                                                                          .quanText
                                                                          .text =
                                                                          widget
                                                                              .proSelect[
                                                                          0]
                                                                              .prList
                                                                              .listStorePro[
                                                                          index]
                                                                              .quantity
                                                                              .toString();
                                                                      final SharedPreferences
                                                                      sharedPrefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                      setState(() {
                                                                        quantity =
                                                                        0;
                                                                        price=0;
                                                                        for (int y =
                                                                        0;
                                                                        y < widget.proSelect[0].prList.listStorePro.length;
                                                                        y++) {
                                                                          quantity = quantity +
                                                                              int.parse(widget
                                                                                  .proSelect[0]
                                                                                  .prList
                                                                                  .listStorePro[y]
                                                                                  .quanText
                                                                                  .text);

                                                                          if (widget
                                                                              .proSelect[0]
                                                                              .prList
                                                                              .listStorePro[y]
                                                                              .tax_method
                                                                              .toString() !=
                                                                              'exclusive') {
                                                                            price = price +
                                                                                (   double.parse(widget.proSelect[0].prList.listStorePro[y].price)*  widget
                                                                                    .proSelect[
                                                                                0]
                                                                                    .prList
                                                                                    .listStorePro[
                                                                                y]
                                                                                    .quantity);
                                                                          } else {
                                                                            if (widget.proSelect[0].prList.listStorePro[y].texes.type.toString() !=
                                                                                'percentage') {
                                                                              setState(
                                                                                      () {

                                                                                    price =
                                                                                        (price) + ((double.parse(widget.proSelect[0].prList.listStorePro[y].price)*  widget
                                                                                            .proSelect[
                                                                                        0]
                                                                                            .prList
                                                                                            .listStorePro[
                                                                                        y]
                                                                                            .quantity) + double.parse(widget.proSelect[0].prList.listStorePro[y].texes.rate));
                                                                                  });
                                                                            } else {
                                                                              setState(
                                                                                      () {
                                                                                    price =
                                                                                        (price) + ((double.parse(widget.proSelect[0].prList.listStorePro[y].price)* widget
                                                                                            .proSelect[
                                                                                        0]
                                                                                            .prList
                                                                                            .listStorePro[
                                                                                        y]
                                                                                            .quantity) + ((double.parse(widget.proSelect[0].prList.listStorePro[y].price) * double.parse(widget.proSelect[0].prList.listStorePro[y].texes.rate)) / 100));
                                                                                  });
                                                                            }
                                                                          }
                                                                        }

                                                                        sharedPrefs
                                                                            .remove(
                                                                            'lastpro');
                                                                        alarmLi.add(CartMode(
                                                                            prList: ProStore(
                                                                                listStorePro: widget
                                                                                    .proSelect[
                                                                                0]
                                                                                    .prList
                                                                                    .listStorePro),
                                                                            quan: int.parse(quantity
                                                                                .toString()),
                                                                            total: double.parse(
                                                                                price.toString())));

                                                                        for (int y =
                                                                        0;
                                                                        y < posController.itemsPro.value.length;
                                                                        y++) {
                                                                          if (posController
                                                                              .itemsPro
                                                                              .value[
                                                                          y]
                                                                              .id ==
                                                                              widget
                                                                                  .proSelect[0]
                                                                                  .prList
                                                                                  .listStorePro[index]
                                                                                  .id) {
                                                                            posController
                                                                                .itemsPro
                                                                                .value[
                                                                            y]
                                                                                .quantity =int.parse(val);
                                                                          }
                                                                        }

                                                                        String
                                                                        fgfh =
                                                                        json.encode(
                                                                          alarmLi
                                                                              .map<Map<String, dynamic>>((music) =>
                                                                              CartMode.toMap(music))
                                                                              .toList(),
                                                                        );
                                                                        sharedPrefs
                                                                            .setString(
                                                                            'cartOrder',
                                                                            fgfh);

                                                                        String
                                                                        lastpro =
                                                                        json.encode(
                                                                          alarmLi[0]
                                                                              .prList
                                                                              .listStorePro
                                                                              .map<Map<String, dynamic>>((music) =>
                                                                              ProductModdelList.toMavp(music))
                                                                              .toList(),
                                                                        );
                                                                        sharedPrefs.setString(
                                                                            'lastpro',
                                                                            lastpro);
                                                                      });
                                                                },
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                decoration:
                                                                    InputDecoration(
                                                                        contentPadding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            12),
                                                                        labelStyle: TextStyle(
                                                                            color: Color(
                                                                                0xFF002e80)),


// and:

                                                                        hintText: widget
                                                                            .proSelect[
                                                                                0]
                                                                            .prList
                                                                            .listStorePro[
                                                                                index]
                                                                            .quantity
                                                                            .toString(),
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF002e80),
                                                                        )),
                                                              ))),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            Get.dialog(
                                                              Center(
                                                                child: Lottie.asset(
                                                                    'assets/images/loading.json',
                                                                    width: 90,
                                                                    height: 90),
                                                              ),
                                                            );
                                                            final SharedPreferences
                                                                sharedPrefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            setState(() {
                                                              if (widget
                                                                      .proSelect[
                                                                          0]
                                                                      .prList
                                                                      .listStorePro[
                                                                          index]
                                                                      .quantity >
                                                                  1) {
                                                                widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .quantity = widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .quantity -
                                                                    1;
                                                                quantity =
                                                                    quantity -
                                                                        1;
                                                                if (widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .tax_method
                                                                        .toString() !=
                                                                    'exclusive') {
                                                                  price = price -
                                                                      double.parse(widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .price);
                                                                } else {
                                                                  if (widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .texes
                                                                          .type
                                                                          .toString() !=
                                                                      'percentage') {
                                                                    setState(
                                                                        () {
                                                                      price = (price) -
                                                                          (double.parse(widget.proSelect[0].prList.listStorePro[index].price) +
                                                                              double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate));
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      price = (price) -
                                                                          ((double.parse(widget.proSelect[0].prList.listStorePro[index].price) +
                                                                              ((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) / 100)));
                                                                    });
                                                                  }
                                                                }
                                                                sharedPrefs.remove(
                                                                    'lastpro');
                                                                alarmLi.add(CartMode(
                                                                    prList: ProStore(
                                                                        listStorePro: widget
                                                                            .proSelect[
                                                                                0]
                                                                            .prList
                                                                            .listStorePro),
                                                                    quan: int.parse(
                                                                        quantity
                                                                            .toString()),
                                                                    total: double
                                                                        .parse(price
                                                                            .toString())));

                                                                for (int y = 0;
                                                                    y <
                                                                        posController
                                                                            .itemsPro
                                                                            .value
                                                                            .length;
                                                                    y++) {
                                                                  if (posController
                                                                          .itemsPro
                                                                          .value[
                                                                              y]
                                                                          .id ==
                                                                      widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .id) {
                                                                    posController
                                                                        .itemsPro
                                                                        .value[
                                                                            y]
                                                                        .quantity = posController
                                                                            .itemsPro
                                                                            .value[y]
                                                                            .quantity -
                                                                        1;
                                                                  }
                                                                }

                                                                String fgfh =
                                                                    json.encode(
                                                                  alarmLi
                                                                      .map<
                                                                          Map<String,
                                                                              dynamic>>((music) =>
                                                                          CartMode.toMap(
                                                                              music))
                                                                      .toList(),
                                                                );
                                                                sharedPrefs
                                                                    .setString(
                                                                        'cartOrder',
                                                                        fgfh);

                                                                String lastpro =
                                                                    json.encode(
                                                                  alarmLi[0]
                                                                      .prList
                                                                      .listStorePro
                                                                      .map<
                                                                          Map<String,
                                                                              dynamic>>((music) =>
                                                                          ProductModdelList.toMavp(
                                                                              music))
                                                                      .toList(),
                                                                );
                                                                sharedPrefs
                                                                    .setString(
                                                                        'lastpro',
                                                                        lastpro);
                                                                //  widget.change('1');
                                                              }
                                                            });
                                                            widget
                                                                    .proSelect[0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .quanText
                                                                    .text =
                                                                widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .quantity
                                                                    .toString();
                                                            Get.back();
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 0),
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
                                                                        .all(3),
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 13,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        final SharedPreferences
                                                            sharedPrefs =
                                                            await SharedPreferences
                                                                .getInstance();

                                                        setState(() {
                                                          quantity = quantity -
                                                              widget
                                                                  .proSelect[0]
                                                                  .prList
                                                                  .listStorePro[
                                                                      index]
                                                                  .quantity;
                                                          if (widget
                                                                  .proSelect[0]
                                                                  .prList
                                                                  .listStorePro[
                                                                      index]
                                                                  .tax_method
                                                                  .toString() !=
                                                              'exclusive') {
                                                            price = price -
                                                                (double.parse(widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .price) *
                                                                    widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .quantity);

                                                            widget.proSelect[0]
                                                                .total = widget
                                                                    .proSelect[
                                                                        0]
                                                                    .total -
                                                                (double.parse(widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .price) *
                                                                    widget
                                                                        .proSelect[
                                                                            0]
                                                                        .prList
                                                                        .listStorePro[
                                                                            index]
                                                                        .quantity);
                                                          } else {
                                                            if (widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .texes
                                                                    .type
                                                                    .toString() ==
                                                                'percentage') {
                                                              price = price -
                                                                  ((((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) /
                                                                              100) +
                                                                          double.parse(widget
                                                                              .proSelect[
                                                                                  0]
                                                                              .prList
                                                                              .listStorePro[
                                                                                  index]
                                                                              .price)) *
                                                                      widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .quantity);
                                                              widget
                                                                  .proSelect[0]
                                                                  .total = widget
                                                                      .proSelect[
                                                                          0]
                                                                      .total -
                                                                  ((((double.parse(widget.proSelect[0].prList.listStorePro[index].price) * double.parse(widget.proSelect[0].prList.listStorePro[index].texes.rate)) /
                                                                              100) +
                                                                          double.parse(widget
                                                                              .proSelect[
                                                                                  0]
                                                                              .prList
                                                                              .listStorePro[
                                                                                  index]
                                                                              .price)) *
                                                                      widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .quantity);
                                                            } else {
                                                              price = price -
                                                                  ((double.parse(widget
                                                                              .proSelect[
                                                                                  0]
                                                                              .prList
                                                                              .listStorePro[
                                                                                  index]
                                                                              .texes
                                                                              .rate) +
                                                                          double.parse(widget
                                                                              .proSelect[
                                                                                  0]
                                                                              .prList
                                                                              .listStorePro[
                                                                                  index]
                                                                              .price)) *
                                                                      widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .quantity);
                                                              widget
                                                                  .proSelect[0]
                                                                  .total = widget
                                                                      .proSelect[
                                                                          0]
                                                                      .total -
                                                                  ((double.parse(widget
                                                                              .proSelect[
                                                                                  0]
                                                                              .prList
                                                                              .listStorePro[
                                                                                  index]
                                                                              .texes
                                                                              .rate) +
                                                                          double.parse(widget
                                                                              .proSelect[
                                                                                  0]
                                                                              .prList
                                                                              .listStorePro[
                                                                                  index]
                                                                              .price)) *
                                                                      widget
                                                                          .proSelect[
                                                                              0]
                                                                          .prList
                                                                          .listStorePro[
                                                                              index]
                                                                          .quantity);
                                                            }
                                                          }
                                                          widget.proSelect[0]
                                                              .quan = widget
                                                                  .proSelect[0]
                                                                  .quan -
                                                              widget
                                                                  .proSelect[0]
                                                                  .prList
                                                                  .listStorePro[
                                                                      index]
                                                                  .quantity;
                                                          setState(() {
                                                            widget
                                                                .proSelect[0]
                                                                .prList
                                                                .listStorePro[
                                                                    index]
                                                                .quantity = 0;
                                                          });
                                                          for (int y = 0;
                                                              y <
                                                                  posController
                                                                      .itemsPro
                                                                      .value
                                                                      .length;
                                                              y++) {
                                                            if (posController
                                                                    .itemsPro
                                                                    .value[y]
                                                                    .id
                                                                    .toString() ==
                                                                widget
                                                                    .proSelect[
                                                                        0]
                                                                    .prList
                                                                    .listStorePro[
                                                                        index]
                                                                    .id
                                                                    .toString()) {
                                                              posController
                                                                  .itemsPro
                                                                  .value[y]
                                                                  .quantity = 0;
                                                            }
                                                          }
                                                          alarmLi.clear();
                                                          alarmLpro.clear();
                                                          widget
                                                              .proSelect[0]
                                                              .prList
                                                              .listStorePro
                                                              .removeAt(index);
                                                          sharedPrefs.remove(
                                                              'cartOrder');
                                                          sharedPrefs.remove(
                                                              'lastpro');
                                                          if (widget
                                                                  .proSelect[0]
                                                                  .prList
                                                                  .listStorePro
                                                                  .length >
                                                              0) {
                                                            alarmLpro.addAll(widget
                                                                .proSelect[0]
                                                                .prList
                                                                .listStorePro);

                                                            String lastpro =
                                                                json.encode(
                                                              alarmLpro
                                                                  .map<
                                                                      Map<String,
                                                                          dynamic>>((music) =>
                                                                      ProductModdelList
                                                                          .toMavp(
                                                                              music))
                                                                  .toList(),
                                                            );

                                                            sharedPrefs
                                                                .setString(
                                                                    'lastpro',
                                                                    lastpro);
                                                            alarmLi.add(CartMode(
                                                                prList: ProStore(
                                                                    listStorePro:
                                                                        alarmLpro),
                                                                quan: int.parse(
                                                                    quantity
                                                                        .toString()),
                                                                total: double
                                                                    .parse(price
                                                                        .toString())));
                                                            String fgfh =
                                                                json.encode(
                                                              alarmLi
                                                                  .map<
                                                                      Map<String,
                                                                          dynamic>>((music) =>
                                                                      CartMode.toMap(
                                                                          music))
                                                                  .toList(),
                                                            );
                                                            sharedPrefs
                                                                .setString(
                                                                    'cartOrder',
                                                                    fgfh);
                                                            //      widget.change('2');
                                                          } else {
                                                            widget
                                                                .proSelect[0]
                                                                .prList
                                                                .listStorePro
                                                                .clear();
                                                            alarmLi.clear();
                                                            widget.proSelect[0]
                                                                .total = 0;
                                                            widget.proSelect[0]
                                                                .quan = 0;
                                                            alarmLpro.clear();
                                                            sharedPrefs.remove(
                                                                'cartOrder');
                                                            sharedPrefs.remove(
                                                                'lastpro');
                                                            widget.change('2');
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
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
                                                                  15, 5, 15, 5),
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .delete,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF002e80),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: widget.proSelect[0].prList
                                        .listStorePro.length,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
            shrinkWrap: true,
          )),
      onWillPop: () async {
        final SharedPreferences sharedPrefs =
            await SharedPreferences.getInstance();
        sharedPrefs.remove('cartOrder');
        if (widget.proSelect.length > 0) {
          alarmLi.add(CartMode(
              prList: ProStore(
                  listStorePro: widget.proSelect[0].prList.listStorePro),
              quan: int.parse(quantity.toString()),
              total: double.parse(price.toString())));
          String fgfh = json.encode(
            alarmLi
                .map<Map<String, dynamic>>((music) => CartMode.toMap(music))
                .toList(),
          );
          sharedPrefs.setString('cartOrder', fgfh);
        } else {
          sharedPrefs.remove('cartOrder');
        }
        Navigator.pop(context);
        widget.change('1');
        return true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (context, setstat) {
                return Container(
                  width: Get.width / 1.2,
                  child: ListView(shrinkWrap: true, children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          S.of(context).selectc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                            child: TextField(
                              controller: search,
                              onChanged: (val) {
                                //filterSearchResults(val);
                                final dummySearchList = [];
                                dummySearchList.addAll(customerListLAst);
                                if (val.isNotEmpty) {
                                  final dummyListData = [];
                                  dummySearchList.forEach((item) {
                                    if (item.name.contains(val)) {
                                      dummyListData.add(item);
                                    }
                                  });
                                  setstat(() {
                                    customerListLAst.clear();
                                    customerListLAst.addAll(dummyListData);
                                  });
                                  return;
                                } else {
                                  setstat(() {
                                    customerListLAst.clear();
                                    customerListLAst
                                        .addAll(widget.customerList);
                                  });
                                }
                              },
                              style: TextStyle(color: Color(0xFF002e80)),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  labelStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF002e80),
                                    ),
                                  ),
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF002e80)),
                                  ),
// and:
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xFF002e80),
                                    size: 18,
                                  ),
                                  hintText: S.of(context).searchh,
                                  hintStyle: TextStyle(
                                    color: Color(0xFF002e80),
                                  )),
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(customerListLAst[index].name),
                                          new Spacer(),
                                          customerListLAst[index]
                                                      .id
                                                      .toString() ==
                                                  customerItem!.id.toString()
                                              ? Icon(Icons.check,
                                                  color: Color(0xFF002e80))
                                              : Visibility(
                                                  child: Text(''),
                                                  visible: false,
                                                )
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    customerItem = customerListLAst[index];
                                    customerListLAst.clear();
                                    customerListLAst
                                        .addAll(widget.customerList);
                                    search.text = '';
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: customerListLAst.length,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ],
                    )
                  ]),
                );
              },
            ),
          );
        });
  }
}
