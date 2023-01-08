import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/home_page.dart';
import 'package:icon/screen/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool click = false;
  PosController posController = Get.put(PosController());
  bool showp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    posController.changeLang(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Color(0xFF002e80),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            posController.languagee.value != 'en'
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
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
                  child: Image.network(posController.logog,width: Get.width/2,
                  height: Get.height/11,),
                ),
                //                                Image.asset('assets/images/minilogo.png'),
                SizedBox(
                  height: 70,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: TextField(
                            controller: username,
                            textInputAction: TextInputAction.next,
                            // Moves focus to next.

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
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
// and:
                                prefixIcon: Icon(
                                  Icons.person_outline_outlined,
                                  color: Color(0xFF002e80),
                                  size: 18,
                                ),
                                errorText: _errorTextName,
                                errorStyle: TextStyle(color: Colors.red),
                                hintText: S.of(context).usern,
                                hintStyle: TextStyle(
                                  color: Color(0xFF002e80),
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
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: TextField(
                            controller: pass,
                            textInputAction: TextInputAction.done,
                            // Moves focus to next.

                            obscureText: showp == false ? true : false,
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
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
// and:
                                errorText: _errorTextPass,
                                errorStyle: TextStyle(color: Colors.red),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF002e80),
                                  size: 18,
                                ),
                                suffixIcon: InkWell(
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Color(0xFF002e80),
                                    size: 18,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showp = !showp;
                                    });
                                  },
                                ),
                                hintText: S.of(context).Password,
                                hintStyle: TextStyle(
                                  color: Color(0xFF002e80),
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
                  height: 40,
                ),
                Obx(
                  () => posController.isLoadingAuth.value == false
                      ? InkWell(
                          onTap: () async {
                            setState(() {
                              click = true;
                            });

                            if (_errorTextName == null &&
                                _errorTextPass == null) {
                              posController.checkAuth(
                                  username.text, pass.text, context);
                              //   Get.to(() => HomePage());

                            } else {}
                            //  Get.to(()=> HomePage());
                          },
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(
                                width: Get.width,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Text(
                                      S.of(context).Login,
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
                        )
                      : Lottie.asset('assets/images/loading.json',
                          width: 90, height: 90),
                )
                /*  Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: GlowText(
                                    'Forget Password?',
                                    glowColor: Color(0xFF002e80).withOpacity(0.4),
                                    style: TextStyle(
                                        color: Color(0xFF002e80),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),

                                )*/
              ],
            ),
          ],
          shrinkWrap: true,
        ),
      ),
    );
  }

  String? get _errorTextPass {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = pass.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String inserp = S.of(context).isertp;
        return inserp;
      }
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextName {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = username.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String isertu = S.of(context).isertu;

        return isertu;
      }
    }
    // return null if the text is valid
    return null;
  }
}
