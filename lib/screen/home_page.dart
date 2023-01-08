import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:charset_converter/charset_converter.dart';
import 'package:convert/convert.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/screen/purchases/purchases_page.dart';
import 'package:icon/screen/ref_list_page.dart';
import 'package:icon/screen/supplier/supplier_page.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:io';

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/retrive_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/lazy.dart';
import 'package:icon/screen/add_brand_page.dart';
import 'package:icon/screen/add_category_screen.dart';
import 'package:icon/screen/add_customer_page.dart';
import 'package:icon/screen/add_product_page.dart';
import 'package:icon/screen/add_sub_categoru_screen.dart';
import 'package:icon/screen/auth_screen.dart';
import 'package:icon/screen/bar_code_retrive_page.dart';
import 'package:icon/screen/category_page.dart';
import 'package:icon/screen/change_password_screen.dart';
import 'package:icon/screen/electric_scan.dart';
import 'package:icon/screen/invoice_details_page.dart';
import 'package:icon/screen/pos_widget.dart';
import 'package:icon/screen/product_page.dart';
import 'package:icon/screen/report/report_page.dart';
import 'package:icon/screen/report/report_sale_page.dart';
import 'package:icon/screen/retive_page.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  PosController posController = Get.put(PosController());
  RetriveController rev = Get.put(RetriveController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isChecked = false;
  bool isCheckedscan = false;
  bool clickS = false;
  String? useers;
  List<String> val = [];
  TextEditingController bar = TextEditingController();

  String hexToAscii(String hexString) => List.generate(
        hexString.length ~/ 2,
        (i) => String.fromCharCode(
            int.parse(hexString.substring(i * 2, (i * 2) + 2), radix: 16)),
      ).join();

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      useers = prefs.getString('user');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getData();
    posController.getPosDefault();
    super.initState();
  }

  Future<bool> showApp(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 5),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                posController.languagee == 'en'
                    ? Text('Do you want to exit app?')
                    : Text('هل تريد بالتأكيد الخروج من التطبيق؟',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005189)),
                        textAlign: TextAlign.center),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          exit(0);
                        },
                        child: posController.languagee == 'en'
                            ? Text('Yes')
                            : Text('موافق'),
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
                      child: Text(S.of(context).Cancel,
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showApp(context),
      child: ZoomDrawer(
        controller: zoomDrawerController,
        borderRadius: 24,
        style: DrawerStyle.Style1,
        openCurve: Curves.fastOutSlowIn,
        //  disableGesture: false,
        mainScreenTapClose: false,
        isRtl: posController.languagee.value == 'en' ? false : true,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        duration: const Duration(milliseconds: 500),
        backgroundColor: Colors.white,
        //   menuBackgroundColor: Colors.white,
        showShadow: true,
        angle: 0.0,
        clipMainScreen: true,
        menuScreen: Scaffold(
            backgroundColor: Color(0xFF005189).withOpacity(0.6),
            body: Padding(
                padding: EdgeInsets.fromLTRB(10, 80, 10, 15),
                child: ListView(
                  children: [
                    Obx(() => posController.permission.value.length != 0
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  posController.logog != ''
                                      ? Image.network(
                                          posController.logog,
                                          width: Get.width / 4,
                                        )
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/psersn.jpg'),
                                                  fit: BoxFit.fill)),
                                        ),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Text(
                                        useers == null
                                            ? S.of(context).usern
                                            : useers!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ))
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              posController.proLstPArams == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.delete<ProductAllController>();

                                        Get.to(() => ProductPage());
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_business_outlined,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                child: Text(
                                                  S.of(context).addp,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ))
                                          ],
                                        ),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.cusListView == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => CategoryPage('4'));
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person_add_alt,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                child: Text(
                                                  S.of(context).addc,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ))
                                          ],
                                        ),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.cusListView == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => CategoryPage('1'));
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add_to_photos,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).addcat,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => CategoryPage('2'));
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.note_add_outlined,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).addsubc,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => CategoryPage('3'));
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add_to_drive,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).addBrand,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.proLstPArams == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.suppListView == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => SupplierPage());
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.widgets_outlined,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).supplier,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.suppListView == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.purListView == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => PurchasesPage(
                                              posController.WareL.value,
                                            ));
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .account_balance_wallet_outlined,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).puschae,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.purListView == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.reportTaxView == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => ReportPage());
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .report_gmailerrorred_outlined,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).taxR,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.reportTaxView == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              posController.reportSaleView == '1'
                                  ? InkWell(
                                      onTap: () {
                                        zoomDrawerController.toggle!();
                                        Get.to(() => ReportSalePage());
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.report_problem_outlined,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).saleR,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.reportSaleView == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
//AQ/YtNix2YPYqSDZhtis2K8CDjMxMDIwMjY1MTQwMDAzAxMyMDIwLTAzLTAxIDAwOjAwOjAwBAYxMzQ1MDAFBzYzMTkuMDU=

                                  Get.to(() => QRViewExampleElectric(
                                        resultcode: (result) async {
                                          val.clear();
                                          print(result);
                                          bool isValid =
                                              isBase64(result); // false
                                          print(isValid.toString());
                                          if (isValid == true) {
                                            result = base64.normalize(
                                                result.replaceAll(
                                                    "\n", "")); //replace all
                                            final hefx = base64Decode(result)
                                                .map((e) => e
                                                    .toRadixString(16)
                                                    .padLeft(2, '0'))
                                                .join();
                                            print(hefx);
                                            //  final number = int.parse('13', radix: 16);
                                            String firstlen =
                                                hefx.substring(2, 4);
                                            final firstval =
                                                int.parse(firstlen, radix: 16) *
                                                    2;
                                            int lastlengtho = 4 + firstval;
                                            String tago =
                                                hefx.substring(4, lastlengtho);
                                            print('tago' + tago);

                                            HexDecoder hexEncoder = hex.decoder;
                                            var hexData = hex.decode(tago);
                                            var bytes = utf8.decode(hexData);

                                            val.add(bytes);

                                            String seclen = hefx.substring(
                                                lastlengtho + 2,
                                                lastlengtho + 4);
                                            print(seclen);
                                            final secval =
                                                int.parse(seclen, radix: 16) *
                                                    2;
                                            print(secval);
                                            String tagotwo = hefx.substring(
                                                lastlengtho + 4,
                                                lastlengtho + 4 + secval);
                                            print('tagotwo' + tagotwo);
                                            var hexDataTwo =
                                                hex.decode(tagotwo);
                                            var bytesTow =
                                                utf8.decode(hexDataTwo);
                                            val.add(bytesTow);

                                            String thirdlen = hefx.substring(
                                                lastlengtho + 4 + secval + 2,
                                                lastlengtho + 4 + secval + 4);
                                            print(thirdlen);
                                            final thirdval =
                                                int.parse(thirdlen, radix: 16) *
                                                    2;
                                            print(thirdval);
                                            String tagothird = hefx.substring(
                                                lastlengtho + 4 + secval + 4,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval);
                                            print('tagothird' + tagothird);
                                            var hexDataThree =
                                                hex.decode(tagothird);
                                            var bytesThree =
                                                utf8.decode(hexDataThree);
                                            val.add(bytesThree);

                                            String fourlen = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    2,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4);
                                            print(fourlen);
                                            final fourval =
                                                int.parse(fourlen, radix: 16) *
                                                    2;
                                            print(fourval);
                                            String tagofour = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval);
                                            print('tagofour' + tagofour);
                                            var hexDatafour =
                                                hex.decode(tagofour);
                                            var bytesFour =
                                                utf8.decode(hexDatafour);
                                            val.add(bytesFour);

                                            String fivelen = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    2,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    4);
                                            print(fivelen);
                                            final fiveval =
                                                int.parse(fivelen, radix: 16) *
                                                    2;
                                            print(fiveval);
                                            String tagofive = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    4,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    4 +
                                                    fiveval);
                                            print('tagofive' + tagofive);
                                            var hexDatafive =
                                                hex.decode(tagofive);
                                            var bytesFive =
                                                utf8.decode(hexDatafive);
                                            val.add(bytesFive);
                                            print(val);
                                            Get.to(
                                                () => InvoiceDeailsPage(val));
                                          } else {
                                            Get.back();
                                            Get.snackbar(S.of(context).Error,
                                                S.of(context).errorqr,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.6));
                                          }
                                        },
                                      ));
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.qr_code_scanner_sharp,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).qrc,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              posController.returList == '1'
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          bar.text = '';
                                          isChecked = false;
                                          clickS = false;
                                          isCheckedscan = false;
                                        });
                                        zoomDrawerController.toggle!();

                                        _scaffoldKey.currentState!
                                            .showBottomSheet((context) {
                                          return new StatefulBuilder(
                                            builder: (context, setSate) {
                                              return Container(
                                                height: isChecked == false
                                                    ? 400
                                                    : 450,
                                                width: Get.width,
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 20,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    topRight:
                                                        Radius.circular(25),
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 30),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .returnsale,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Color(
                                                                    0xFF002e80)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  0,
                                                                  10,
                                                                  0.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              InkWell(
                                                                child: Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color: Color(
                                                                      0xFF002e80),
                                                                ),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: Get.width,
                                                      height: 1,
                                                      color: Color(0xFF002e80)
                                                          .withOpacity(0.1),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setSate(() {
                                                          isChecked =
                                                              !isChecked;
                                                          isCheckedscan = false;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                            checkColor:
                                                                Colors.white,
                                                            value: isChecked,
                                                            shape:
                                                                CircleBorder(),
                                                            onChanged:
                                                                (bool? value) {
                                                              setSate(() {
                                                                isChecked =
                                                                    value!;
                                                                isCheckedscan =
                                                                    false;
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .entert,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF002e80),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    isChecked == false
                                                        ? Visibility(
                                                            child: Text(''),
                                                            visible: false,
                                                          )
                                                        : Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                    20, 0),
                                                            child: Container(
                                                              child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          5),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        bar,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    // Moves focus to next.

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

                                                                        errorText: ErrorBarcodeText,
                                                                        errorStyle: TextStyle(color: Colors.red),
                                                                        hintText: S.of(context).salen,
                                                                        hintStyle: TextStyle(
                                                                          color:
                                                                              Color(0xFF002e80),
                                                                        )),
                                                                  )),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(10),
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
                                                          ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setSate(() {
                                                          isCheckedscan =
                                                              !isCheckedscan;
                                                          isChecked = false;
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                            checkColor:
                                                                Colors.white,
                                                            value:
                                                                isCheckedscan,
                                                            shape:
                                                                CircleBorder(),
                                                            onChanged:
                                                                (bool? value) {
                                                              setSate(() {
                                                                isCheckedscan =
                                                                    value!;
                                                                isChecked =
                                                                    false;
                                                              });
                                                            },
                                                          ),
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .enterb,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF002e80),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (isChecked == true) {
                                                          setSate(() {
                                                            clickS = true;
                                                          });
                                                          if (ErrorBarcodeText ==
                                                              null) {
                                                            Get.back();
                                                            Get.to(() =>
                                                                RefPage(
                                                                    bar.text,
                                                                    '1'));

                                                            //   Get.to(() => HomePage());

                                                          }
                                                        } else {
                                                          Get.back();

                                                          Get.to(() =>
                                                              BarcodePage(
                                                                resultcode:
                                                                    (result) {
                                                                  print(result);

                                                                  /*          Get.to(() =>
                                                          RefPage(result));*/
                                                                  Get.to(() =>
                                                                      RetrivePage(
                                                                          result,
                                                                          '1'));
                                                                },
                                                              ));
                                                        }
                                                      },
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  30, 0, 30, 0),
                                                          child: Container(
                                                            width: Get.width,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            20,
                                                                            0,
                                                                            20),
                                                                child: Text(
                                                                  S
                                                                      .of(context)
                                                                      .Submit,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15),
                                                                )),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              gradient:
                                                                  LinearGradient(
                                                                      colors: [
                                                                    Color(0xFF002e80)
                                                                        .withOpacity(
                                                                            0.4),
                                                                    Color(0xFF002e80)
                                                                        .withOpacity(
                                                                            0.7),
                                                                    Color(
                                                                        0xFF002e80)
                                                                  ]),
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        });

                                        /* Get.to(() => BarcodePage(
                              resultcode: (result) {
                                print(result);

                                Get.to(() => RetrivePage(result));
                              },
                            ));*/
                                      },
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.keyboard_return_outlined,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Text(
                                                    S.of(context).addr,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          )),
                                    )
                                  : Visibility(child: Text(''), visible: false),
                              posController.returList == '1'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: Get.width,
                                        color: Colors.white.withOpacity(0.3),
                                      ))
                                  : Visibility(child: Text(''), visible: false),
                              Obx(() => InkWell(
                                  onTap: () {
                                    posController.getPosDefault();
                                    posController.changeLang(context);
                                    zoomDrawerController.toggle!();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              posController.languagee.value !=
                                                      'ar'
                                                  ? 'تغيير إلى ' + 'العربية'
                                                  : 'Change to ' + 'English',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )),
                                      ],
                                    ),
                                  ))),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                  onTap: () {
                                    zoomDrawerController.toggle!();
                                    Get.to(() => ChangePasswordPage());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).changep,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                  onTap: () async {
                                    final SharedPreferences sharedPrefs =
                                        await SharedPreferences.getInstance();
                                    sharedPrefs.clear();
                                    sharedPrefs.setString(
                                        'lang', posController.languagee.value);
                                    posController.proLstPArams = '';
                                    posController.proAdd = '';
                                    posController.proEdit = '';
                                    posController.proLstDelete = '';
                                    posController.suppListView = '';
                                    posController.suppAdd = '';
                                    posController.suppEdit = '';
                                    posController.suppDelete = '';
                                    posController.cusListView = '';
                                    posController.cusAdd = '';
                                    posController.cusEdit = '';
                                    posController.cusDelete = '';
                                    posController.purListView = '';
                                    posController.purAdd = '';
                                    posController.purEdit = '';
                                    posController.purDelete = '';
                                    posController.reportSaleView = '';
                                    posController.reportTaxView = '';
                                    posController.permission.clear();
                                    Get.offAll(() => AuthPage());
                                    zoomDrawerController.toggle!();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).logout,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )),
                                      ],
                                    ),
                                  ))
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  posController.logog != ''
                                      ? Image.network(
                                          posController.logog,
                                          width: Get.width / 4,
                                        )
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/psersn.jpg'),
                                                  fit: BoxFit.fill)),
                                        ),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Text(
                                        useers == null
                                            ? S.of(context).usern
                                            : useers!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ))
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                  onTap: () {
                                    zoomDrawerController.toggle!();
                                    Get.delete<ProductAllController>();

                                    Get.to(() => ProductPage());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_business_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).addp,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                  onTap: () {
                                    zoomDrawerController.toggle!();
                                    Get.to(() => CategoryPage('4'));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_add_alt,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).addc,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => CategoryPage('1'));
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_to_photos,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).addcat,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => CategoryPage('2'));
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.note_add_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).addsubc,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => CategoryPage('3'));
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_to_drive,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).addBrand,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => SupplierPage());
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.widgets_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).supplier,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => PurchasesPage(
                                        posController.WareL.value,
                                      ));
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.account_balance_wallet_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).puschae,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => ReportPage());
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.report_gmailerrorred_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).taxR,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
                                  Get.to(() => ReportSalePage());
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.report_problem_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).saleR,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  zoomDrawerController.toggle!();
//AQ/YtNix2YPYqSDZhtis2K8CDjMxMDIwMjY1MTQwMDAzAxMyMDIwLTAzLTAxIDAwOjAwOjAwBAYxMzQ1MDAFBzYzMTkuMDU=

                                  Get.to(() => QRViewExampleElectric(
                                        resultcode: (result) async {
                                          val.clear();
                                          print(result);
                                          bool isValid =
                                              isBase64(result); // false
                                          print(isValid.toString());
                                          if (isValid == true) {
                                            result = base64.normalize(
                                                result.replaceAll(
                                                    "\n", "")); //replace all
                                            final hefx = base64Decode(result)
                                                .map((e) => e
                                                    .toRadixString(16)
                                                    .padLeft(2, '0'))
                                                .join();
                                            print(hefx);
                                            //  final number = int.parse('13', radix: 16);
                                            String firstlen =
                                                hefx.substring(2, 4);
                                            final firstval =
                                                int.parse(firstlen, radix: 16) *
                                                    2;
                                            int lastlengtho = 4 + firstval;
                                            String tago =
                                                hefx.substring(4, lastlengtho);
                                            print('tago' + tago);

                                            HexDecoder hexEncoder = hex.decoder;
                                            var hexData = hex.decode(tago);
                                            var bytes = utf8.decode(hexData);

                                            val.add(bytes);

                                            String seclen = hefx.substring(
                                                lastlengtho + 2,
                                                lastlengtho + 4);
                                            print(seclen);
                                            final secval =
                                                int.parse(seclen, radix: 16) *
                                                    2;
                                            print(secval);
                                            String tagotwo = hefx.substring(
                                                lastlengtho + 4,
                                                lastlengtho + 4 + secval);
                                            print('tagotwo' + tagotwo);
                                            var hexDataTwo =
                                                hex.decode(tagotwo);
                                            var bytesTow =
                                                utf8.decode(hexDataTwo);
                                            val.add(bytesTow);

                                            String thirdlen = hefx.substring(
                                                lastlengtho + 4 + secval + 2,
                                                lastlengtho + 4 + secval + 4);
                                            print(thirdlen);
                                            final thirdval =
                                                int.parse(thirdlen, radix: 16) *
                                                    2;
                                            print(thirdval);
                                            String tagothird = hefx.substring(
                                                lastlengtho + 4 + secval + 4,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval);
                                            print('tagothird' + tagothird);
                                            var hexDataThree =
                                                hex.decode(tagothird);
                                            var bytesThree =
                                                utf8.decode(hexDataThree);
                                            val.add(bytesThree);

                                            String fourlen = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    2,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4);
                                            print(fourlen);
                                            final fourval =
                                                int.parse(fourlen, radix: 16) *
                                                    2;
                                            print(fourval);
                                            String tagofour = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval);
                                            print('tagofour' + tagofour);
                                            var hexDatafour =
                                                hex.decode(tagofour);
                                            var bytesFour =
                                                utf8.decode(hexDatafour);
                                            val.add(bytesFour);

                                            String fivelen = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    2,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    4);
                                            print(fivelen);
                                            final fiveval =
                                                int.parse(fivelen, radix: 16) *
                                                    2;
                                            print(fiveval);
                                            String tagofive = hefx.substring(
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    4,
                                                lastlengtho +
                                                    4 +
                                                    secval +
                                                    4 +
                                                    thirdval +
                                                    4 +
                                                    fourval +
                                                    4 +
                                                    fiveval);
                                            print('tagofive' + tagofive);
                                            var hexDatafive =
                                                hex.decode(tagofive);
                                            var bytesFive =
                                                utf8.decode(hexDatafive);
                                            val.add(bytesFive);
                                            print(val);
                                            Get.to(
                                                () => InvoiceDeailsPage(val));
                                          } else {
                                            Get.back();
                                            Get.snackbar(S.of(context).Error,
                                                S.of(context).errorqr,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.6));
                                          }
                                        },
                                      ));
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.qr_code_scanner_sharp,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).qrc,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    bar.text = '';
                                    isChecked = false;
                                    clickS = false;
                                    isCheckedscan = false;
                                  });
                                  zoomDrawerController.toggle!();

                                  _scaffoldKey.currentState!
                                      .showBottomSheet((context) {
                                    return new StatefulBuilder(
                                      builder: (context, setSate) {
                                        return Container(
                                          height:
                                              isChecked == false ? 400 : 450,
                                          width: Get.width,
                                          alignment: Alignment.topCenter,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 20,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 30),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      S.of(context).returnsale,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Color(
                                                              0xFF002e80)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 0, 10, 0.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          child: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            color: Color(
                                                                0xFF002e80),
                                                          ),
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: Get.width,
                                                height: 1,
                                                color: Color(0xFF002e80)
                                                    .withOpacity(0.1),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setSate(() {
                                                    isChecked = !isChecked;
                                                    isCheckedscan = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                      checkColor: Colors.white,
                                                      value: isChecked,
                                                      shape: CircleBorder(),
                                                      onChanged: (bool? value) {
                                                        setSate(() {
                                                          isChecked = value!;
                                                          isCheckedscan = false;
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      S.of(context).entert,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              isChecked == false
                                                  ? Visibility(
                                                      child: Text(''),
                                                      visible: false,
                                                    )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 20, 0),
                                                      child: Container(
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 5, 5),
                                                            child: TextField(
                                                              controller: bar,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              // Moves focus to next.

                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF002e80)),
                                                              decoration:
                                                                  InputDecoration(
                                                                      contentPadding:
                                                                          EdgeInsets.all(
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

                                                                      errorText:
                                                                          ErrorBarcodeText,
                                                                      errorStyle: TextStyle(
                                                                          color: Colors
                                                                              .red),
                                                                      hintText: S
                                                                          .of(
                                                                              context)
                                                                          .salen,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF002e80),
                                                                      )),
                                                            )),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color(
                                                                      0xFF002e80),
                                                                  blurRadius: 2,
                                                                  spreadRadius:
                                                                      0)
                                                            ]),
                                                      ),
                                                    ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setSate(() {
                                                    isCheckedscan =
                                                        !isCheckedscan;
                                                    isChecked = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                      checkColor: Colors.white,
                                                      value: isCheckedscan,
                                                      shape: CircleBorder(),
                                                      onChanged: (bool? value) {
                                                        setSate(() {
                                                          isCheckedscan =
                                                              value!;
                                                          isChecked = false;
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      S.of(context).enterb,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  if (isChecked == true) {
                                                    setSate(() {
                                                      clickS = true;
                                                    });
                                                    if (ErrorBarcodeText ==
                                                        null) {
                                                      Get.back();
                                                      Get.to(() => RefPage(
                                                          bar.text, '1'));

                                                      //   Get.to(() => HomePage());

                                                    }
                                                  } else {
                                                    Get.back();

                                                    Get.to(() => BarcodePage(
                                                          resultcode: (result) {
                                                            print(result);

                                                            /*          Get.to(() =>
                                                          RefPage(result));*/
                                                            Get.to(() =>
                                                                RetrivePage(
                                                                    result,
                                                                    '1'));
                                                          },
                                                        ));
                                                  }
                                                },
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            30, 0, 30, 0),
                                                    child: Container(
                                                      width: Get.width,
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 20, 0, 20),
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .Submit,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          )),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color(0xFF002e80)
                                                                  .withOpacity(
                                                                      0.4),
                                                              Color(0xFF002e80)
                                                                  .withOpacity(
                                                                      0.7),
                                                              Color(0xFF002e80)
                                                            ]),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  });

                                  /* Get.to(() => BarcodePage(
                              resultcode: (result) {
                                print(result);

                                Get.to(() => RetrivePage(result));
                              },
                            ));*/
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.keyboard_return_outlined,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).addr,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              Obx(() => InkWell(
                                  onTap: () {
                                    posController.getPosDefault();
                                    posController.changeLang(context);
                                    zoomDrawerController.toggle!();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              posController.languagee.value !=
                                                      'ar'
                                                  ? 'تغيير إلى ' + 'العربية'
                                                  : 'Change to ' + 'English',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )),
                                      ],
                                    ),
                                  ))),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                  onTap: () {
                                    zoomDrawerController.toggle!();
                                    Get.to(() => ChangePasswordPage());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).changep,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ))
                                      ],
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    height: 1,
                                    width: Get.width,
                                    color: Colors.white.withOpacity(0.3),
                                  )),
                              InkWell(
                                  onTap: () async {
                                    final SharedPreferences sharedPrefs =
                                        await SharedPreferences.getInstance();
                                    sharedPrefs.clear();
                                    sharedPrefs.setString(
                                        'lang', posController.languagee.value);

                                    Get.offAll(() => AuthPage());
                                    zoomDrawerController.toggle!();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            child: Text(
                                              S.of(context).logout,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )),
                                      ],
                                    ),
                                  ))
                            ],
                          ))
                  ],
                ))),
        mainScreen: Scaffold(body: Body(), key: _scaffoldKey),
      ),
    );
  }

  String? get ErrorBarcodeText {
    if (clickS == true) {
      // at any time, we can get the text from _controller.value.text
      final text = bar.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String isertu = S.of(context).pleaseesn;

        return isertu;
      }
    }
    // return null if the text is valid
    return null;
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PosPage(
          controller: controller, zoomDrawerController: zoomDrawerController),
    );
  }
}
