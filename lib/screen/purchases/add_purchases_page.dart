import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/controller/purchases_controller.dart';
import 'package:icon/controller/supplier_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/country_state_package.dart';
import 'package:icon/helper/stepper_package.dart';
import 'package:icon/model/custom_mode_arabic.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/supplier_model.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:icon/screen/qr_page.dart';

import 'package:lottie/lottie.dart';

class statusModel {
  String nameEn;
  String nameAr;

  statusModel(this.nameEn, this.nameAr);
}

class AddPurchasesPage extends StatefulWidget {
  List<dynamic> wareList;

  AddPurchasesPage(this.wareList);

  @override
  _AddPurchasesPage createState() => _AddPurchasesPage();
}

class _AddPurchasesPage extends State<AddPurchasesPage>
    with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  TextEditingController search = TextEditingController();
  TextEditingController searchpro = TextEditingController();

  PurchasesController purController = Get.put(PurchasesController());
  WarehouseModelList? wareItem;
  final _horizontalScrollController = ScrollController();

  SupplierController subController = Get.put(SupplierController());
  SupplierModelList? subItem;
  ProductController proController = Get.put(ProductController());

  List<statusModel> liststatus = [
    statusModel('received', 'تم الاستلام'),
    statusModel('pending', 'عملية معلقة'),
    statusModel('ordered', 'تم الطلب')
  ];
  statusModel? statusItem;

  @override
  void initState() {
    proController.getProduct();

    subController.getSupplierList();

    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
   Obx(()=>         purController.currentStep.value == 0
       ?Visibility(child: Text(''),visible: false,):            Padding(
       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
       child: Row(children: [
         InkWell(
           onTap: () {
             Get.to(() => QRViewExample(
               resultcode: (result) {
                 posController.getProductByCodetoAddPurchases(result);
               },
             ));
           },

           child: Padding(
             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
             child: Icon(
               Icons.qr_code_scanner_sharp,
               color: Colors.white,
               size: 20,

             ),
           ),
         ),

       ],)))


          ],
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
          title: Text(S.of(context).addpur,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Obx(() => subController.isLoading.value == true
            ? Center(
                child: Lottie.asset('assets/images/loading.json',
                    width: 90, height: 90),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Container(
                        height: Get.height,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Obx(() =>
                                  purController.currentStep.value == 0
                                      ? Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  minHeight: 100,
                                                  maxHeight: double.infinity),
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        ' * ' +
                                                            S.of(context).date,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Obx(
                                                        () => InkWell(
                                                          onTap: () {
                                                            DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions:
                                                                    true,

                                                                locale: posController.languagee=='en'?LocaleType.en:LocaleType.ar,
                                                                minTime: DateTime(
                                                                    1910, 1, 1),
                                                                maxTime: DateTime(
                                                                    3000, 1, 1),
                                                                theme: DatePickerTheme(
                                                                    headerColor:
                                                                        Color(0xFF002e80).withOpacity(
                                                                            0.3),

                                                                    backgroundColor: Colors
                                                                        .white,
                                                                    itemStyle: TextStyle(
                                                                        color: Color(0xFF002e80),
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 18),
                                                                    doneStyle: TextStyle(color: Colors.white, fontSize: 16)), onChanged: (date) {
                                                              print('change $date in time zone ' +
                                                                  date.timeZoneOffset
                                                                      .inHours
                                                                      .toString());
                                                              purController
                                                                      .dates
                                                                      .value =
                                                                  date
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          10);
                                                            }, onConfirm: (date) {
                                                              print(
                                                                  'confirm $date');
                                                              purController
                                                                      .dates
                                                                      .value =
                                                                  date
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          10);
                                                            }, currentTime: DateTime.now());
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
                                                                child: Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            25,
                                                                            15,
                                                                            25,
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          purController.dates.value == ''
                                                                              ? S.of(context).dates
                                                                              : purController.dates.value,
                                                                          style: TextStyle(
                                                                              color: purController.dates.value == '' ? Colors.grey : Color(0xFF002e80),
                                                                              fontSize: 16),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down,
                                                                          color:
                                                                              Color(0xFF002e80),
                                                                        )
                                                                      ],
                                                                    )),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.circular(10),
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
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        ' * ' +
                                                            S
                                                                .of(context)
                                                                .selectw,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 5, 0, 0.0),
                                                        child: Container(
                                                          width: Get.width,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.0),
                                                            child: Center(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    color: Colors.white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Color(
                                                                              0xFF002e80),
                                                                          blurRadius:
                                                                              2,
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
                                                                          child:
                                                                              DropdownButton<WarehouseModelList>(
                                                                    value:
                                                                        wareItem,
                                                                    isDense:
                                                                        true,
                                                                    onChanged:
                                                                        (WarehouseModelList?
                                                                            val) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              new FocusNode());

                                                                      setState(
                                                                          () {
                                                                        wareItem =
                                                                            val;
                                                                      });
                                                                    },
                                                                    items: widget
                                                                        .wareList
                                                                        .map(
                                                                            (final value) {
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
                                                                          .selectw,
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
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        S.of(context).suppl,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 5, 0, 0.0),
                                                        child: Container(
                                                          width: Get.width,
                                                          child: InkWell(
                                                            onTap: openAlertBox,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
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
                                                                                blurRadius: 2,
                                                                                spreadRadius: 0)
                                                                          ]),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            10.0,
                                                                            15,
                                                                            10,
                                                                            15),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              5,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                subItem == null ? S.of(context).suppl : subItem!.person,
                                                                                style: TextStyle(fontSize: 16),
                                                                              ),
                                                                              new Spacer(),
                                                                              Icon(
                                                                                Icons.arrow_drop_down_outlined,
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
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        ' * ' +
                                                            S
                                                                .of(context)
                                                                .purstate,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 5, 0, 0.0),
                                                        child: Container(
                                                          width: Get.width,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.0),
                                                            child: Center(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    color: Colors.white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Color(
                                                                              0xFF002e80),
                                                                          blurRadius:
                                                                              2,
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
                                                                          child:
                                                                              DropdownButton<statusModel>(
                                                                    value:
                                                                        statusItem,
                                                                    isDense:
                                                                        true,
                                                                    onChanged:
                                                                        (statusModel?
                                                                            val) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              new FocusNode());

                                                                      setState(
                                                                          () {
                                                                        statusItem =
                                                                            val;
                                                                      });
                                                                    },
                                                                    items: liststatus
                                                                        .map(
                                                                            (final value) {
                                                                      return DropdownMenuItem<
                                                                          statusModel>(
                                                                        value:
                                                                            value,
                                                                        child: new Text(
                                                                            posController.languagee == 'en'
                                                                                ? value.nameEn
                                                                                : value.nameAr,
                                                                            style: TextStyle()),
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
                                                                          .purstate,
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
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        S.of(context).note,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
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
                                                                child:
                                                                    TextField(
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  controller:
                                                                      purController
                                                                          .note,
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
                                                                      hintText: S.of(context).Company,
                                                                      hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      )),
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
                                                          )),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ))
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    S.of(context).addp,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 15, 0, 0.0),
                                                child: InkWell(
                                                    onTap: openAlertBoxProduct,
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
                                                                          2,
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
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      S
                                                                          .of(context)
                                                                          .product,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    new Spacer(),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down_outlined,
                                                                      color: Color(
                                                                          0xFF002e80),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              proController.productListSele
                                                          .value.length ==
                                                      0
                                                  ? Visibility(
                                                      child: Text(''),
                                                      visible: false,
                                                    )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 10),
                                                      child: _dataBody())
                                            ],
                                          ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => purController.currentStep.value == 0
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF002e80),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 5, 15, 5),
                                                child: Text(S.of(context).Next,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                          onTap: () {
                                            if (purController.dates == '' ||
                                                wareItem == null ||
                                                statusItem == null) {
                                              Get.snackbar(S.of(context).Error,
                                                  S.of(context).insetdata,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.6));
                                            } else {
                                              purController.currentStep.value =
                                                  1;
                                            }
                                          }),
                                    ],
                                  ),
                                )),
                          )
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF002e80),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 5, 15, 5),
                                                child: Text(S.of(context).add,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                          onTap: () {
                                            //  purController.AddSupplier();
                                            for (int i = 0;
                                                i <
                                                    proController
                                                        .productListSele.length;
                                                i++) {
                                              proController.productListSele[i]
                                                      .itemPro.quantity =
                                                  proController
                                                      .productListSele[i]
                                                      .itemPro
                                                      .quantitySel;
                                            }
                                            List<ProductModdelList> prolist =
                                                [];

                                            for (int i = 0;
                                                i <
                                                    proController
                                                        .productListSele.length;
                                                i++) {
                                              prolist.add(proController
                                                  .productListSele[i].itemPro);
                                            }
                                            if (posController.languagee ==
                                                'en') {
                                              purController.AddPurchase(
                                                  context,
                                                  wareItem!,
                                                  subItem!,
                                                  statusItem!.nameEn,
                                                  prolist);
                                            } else {
                                              purController.AddPurchase(
                                                  context,
                                                  wareItem!,
                                                  subItem!,
                                                  statusItem!.nameEn,
                                                  prolist);
                                            }
                                          }),
                                      InkWell(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color(0xFF002e80)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 5, 15, 5),
                                                child: Text(S.of(context).Back,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                          onTap: () {
                                            purController.currentStep.value--;
                                          }),
                                    ],
                                  ),
                                )),
                          ))
                  ],
                ),
              )));
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
          headingRowColor:
              MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
          columns: [
            DataColumn(
              label: Text(S.of(context).productn,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text(S.of(context).arabic,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text(S.of(context).Quantity,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text(S.of(context).Price,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text(S.of(context).delete,
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Text(
                      employee.itemPro.second_name.toString(),
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
                          if (employee.quan.text != '') {
                            employee.itemPro.quantitySel =
                                int.parse(employee.quan.text.toString());
                          }
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
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.3)),
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
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.3)),
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
                          S.of(context).suppl,
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
                                dummySearchList
                                    .addAll(subController.supplierListSearch);
                                if (val.isNotEmpty) {
                                  final dummyListData = [];
                                  dummySearchList.forEach((item) {
                                    if (item.person.contains(val)) {
                                      dummyListData.add(item);
                                    }
                                  });
                                  setstat(() {
                                    subController.supplierList.clear();
                                    subController.supplierList
                                        .addAll(dummyListData);
                                  });
                                  return;
                                } else {
                                  setstat(() {
                                    subController.supplierList.clear();
                                    subController.supplierList.addAll(
                                        subController.supplierListSearch);
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
                                          Text(subController
                                              .supplierList[index].person),
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    subItem = subController.supplierList[index];
                                    subController.supplierList.clear();
                                    subController.supplierList.addAll(
                                        subController.supplierListSearch);
                                    search.text = '';
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: subController.supplierList.length,
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

  openAlertBoxProduct() {
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
                          S.of(context).search,
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
                              controller: searchpro,
                              onChanged: (val) {
                                //filterSearchResults(val);
                                final dummySearchList = [];
                                dummySearchList
                                    .addAll(proController.productListSearch);
                                if (val.isNotEmpty) {
                                  final dummyListData = [];
                                  if(posController.languagee=='en'){
                                  dummySearchList.forEach((item) {
                                    if (item.name.toString().toLowerCase().contains(val.toString().toLowerCase())) {
                                      dummyListData.add(item);
                                    }
                                  });}else{

                                    dummySearchList.forEach((item) {
                                      if (item.second_name.contains(val)) {
                                        dummyListData.add(item);
                                      }
                                    });
                                  }
                                  setstat(() {
                                    proController.productList.clear();
                                    proController.productList
                                        .addAll(dummyListData);
                                  });
                                  return;
                                } else {
                                  setstat(() {
                                    proController.productList.clear();
                                    proController.productList.addAll(
                                        proController.productListSearch);
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
                                      posController.languagee=='en'?    Text(proController
                                              .productList[index].name):
                                      Text(proController
                                          .productList[index].second_name),
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  setState(() {
                                    proController.check = false;
                                    proController.productItem =
                                        proController.productList[index];
                                    final controllerq = TextEditingController();
                                    final controllerpr =
                                        TextEditingController();

                                    if (proController
                                            .productListSele.value.length ==
                                        0) {
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
                                                  proController.productItem!));
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
                                            proController.productItem!.id
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
                                                  proController.productItem!));
                                    }
                                  });
                                  proController.productList.clear();
                                  proController.productList.addAll(
                                      proController.productListSearch);
                                  searchpro.text='';
                                  Navigator.pop(context);
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount:searchpro.text!=''? proController.productList.length:5,
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
