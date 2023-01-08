import 'package:icon/screen/login_page_trial.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:convert/convert.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:http/http.dart' as http;
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/electric_scan.dart';
import 'package:icon/screen/invoice_details_page.dart';
import 'package:icon/screen/login_screen.dart';
import 'package:icon/screen/qr_page.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPage createState() => new _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  TextEditingController subcon = TextEditingController();
  bool click = false;
  String? lang;
  String last = '';
  PosController posController = Get.put(PosController());
  List<String> val = [];

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Stack(
            children: [
              Center(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        posController.changeLang(context);
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 30, 20, 0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.language,
                                              color: Color(0xFF002e80),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                posController.languagee.value !=
                                                        'en'
                                                    ? 'English'
                                                    : 'العربية',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF002e80)),
                                              ),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xFF002e80),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 50),
                                  child: Image.asset('assets/images/pos.png'),
                                ),
                                //SizedBox(height: 50,),

                                //       Image.asset('assets/images/minilogo.png'),
                                SizedBox(
                                  height: 70,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: Container(
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          child: TextField(
                                            controller: subcon,
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
                                                prefixIcon: Icon(
                                                  Icons.language,
                                                  color: Color(0xFF002e80),
                                                  size: 18,
                                                ),
                                                suffixText: '.icon-pos.com',
                                                errorText: _errorText,
                                                suffixStyle: TextStyle(
                                                    color: Color(0xFF002e80)),
                                                hintText: S.of(context).subd,
                                                hintStyle: TextStyle(
                                                  color: Color(0xFF002e80),
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
                                  height: 10,
                                ),

                                Obx(() => posController.isLoadingLogo == false
                                    ? InkWell(
                                        onTap: () {
                                          posController.isLoadingLogo(true);

                                          getStatusCode();
                                          //    Get.to(()=>LoginPage());
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                30, 0, 30, 10),
                                            child: Container(
                                              width: Get.width,
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 20, 0, 20),
                                                  child: Text(
                                                    S.of(context).Submit,
                                                    textAlign: TextAlign.center,
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
                                      )
                                    : Lottie.asset('assets/images/loading.json',
                                        width: 90, height: 90)),
                                SizedBox(
                                  height: 30,
                                ),
                                Obx(() => posController.isLoadingAuth == false
                                    ? InkWell(
                                        onTap: () async {
                                          Get.to(() => LoginPageTrial());

                                     /*     final prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.setString('baseurl',
                                              'https://icon-pos.com');
                                          posController.getLogoTrail(context);*/


                                        },
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              30, 0, 30, 10),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 20),
                                              child: Text(
                                                S.of(context).guest,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color(0xFF002e80),
                                                    fontSize: 15),
                                              )),
                                        ),
                                      )
                                    : Lottie.asset('assets/images/loading.json',
                                        width: 90, height: 90)),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: InkWell(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFF002e80)),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                                Icons.qr_code_scanner_sharp,
                                                size: 35,
                                                color: Color(0xFF002e80)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          S.of(context).qrc,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF002e80)),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      Get.to(() => QRViewExampleElectric(
                                            resultcode: (result) async {
                                              val.clear();
                                              print(result);
                                              bool isValid =
                                                  isBase64(result); // false
                                              print(isValid.toString());
                                              if (isValid == true) {
                                                result = base64.normalize(
                                                    result.replaceAll("\n",
                                                        "")); //replace all
                                                final hefx =
                                                    base64Decode(result)
                                                        .map((e) => e
                                                            .toRadixString(16)
                                                            .padLeft(2, '0'))
                                                        .join();
                                                print(hefx);
                                                //  final number = int.parse('13', radix: 16);
                                                String firstlen =
                                                    hefx.substring(2, 4);
                                                final firstval = int.parse(
                                                        firstlen,
                                                        radix: 16) *
                                                    2;
                                                int lastlengtho = 4 + firstval;
                                                String tago = hefx.substring(
                                                    4, lastlengtho);
                                                print('tago' + tago);

                                                HexDecoder hexEncoder =
                                                    hex.decoder;
                                                var hexData = hex.decode(tago);
                                                var bytes =
                                                    utf8.decode(hexData);

                                                val.add(bytes);

                                                String seclen = hefx.substring(
                                                    lastlengtho + 2,
                                                    lastlengtho + 4);
                                                print(seclen);
                                                final secval = int.parse(seclen,
                                                        radix: 16) *
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

                                                String thirdlen =
                                                    hefx.substring(
                                                        lastlengtho +
                                                            4 +
                                                            secval +
                                                            2,
                                                        lastlengtho +
                                                            4 +
                                                            secval +
                                                            4);
                                                print(thirdlen);
                                                final thirdval = int.parse(
                                                        thirdlen,
                                                        radix: 16) *
                                                    2;
                                                print(thirdval);
                                                String tagothird =
                                                    hefx.substring(
                                                        lastlengtho +
                                                            4 +
                                                            secval +
                                                            4,
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
                                                final fourval = int.parse(
                                                        fourlen,
                                                        radix: 16) *
                                                    2;
                                                print(fourval);
                                                String tagofour =
                                                    hefx.substring(
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
                                                final fiveval = int.parse(
                                                        fivelen,
                                                        radix: 16) *
                                                    2;
                                                print(fiveval);
                                                String tagofive =
                                                    hefx.substring(
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
                                                Get.off(() =>
                                                    InvoiceDeailsPage(val));
                                              } else {
                                                Get.back();
                                                Get.snackbar(
                                                    S.of(context).Error,
                                                    S.of(context).errorqr,
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.6));
                                              }
                                            },
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(

                    color: Colors.white,
                  ),
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child:
                          InkWell(
                            child: Text(
                              'https://icon-pos.com',
                              style: TextStyle(
                                  color: Color(0xFF002e80),
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              _launchURLBrowser();
                            },

                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://icon-pos.com')))
      throw 'Could not launch https://icon-pos.com';
  }
  _launchURLBrowser() async {
    const url = 'https://icon-pos.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getStatusCode() async {
    setState(() {
      click = true;
    });
    if (_errorText == null) {
      http.Response response =
          await http.get(Uri.parse('https://' + subcon.text + '.icon-pos.com'));
      if (response.statusCode == 200) {
        print('exists');

        // Get.offAll(() => LoginPage());

        posController.getLogo(context, subcon.text);
      } else {
        print('not exists');

        posController.isLoadingLogo(false);
        showInfoFlushbar(context);
      }
    }else{
      posController.isLoadingLogo(false);

    }
  }

  void showInfoFlushbar(BuildContext context) {
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
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: S.of(context).Error,
      message: S.of(context).notexit,
    )..show(context);
  }

  String? get _errorText {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = subcon.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String insertSub = S.of(context).insertsub;
        return insertSub;
      }
    }
    // return null if the text is valid
    return null;
  }
}
