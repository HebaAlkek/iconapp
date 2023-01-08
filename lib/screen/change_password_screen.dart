import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/home_page.dart';

import 'package:lottie/lottie.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPage createState() => new _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newsPass = TextEditingController();
  TextEditingController conPass = TextEditingController();
  final focus = FocusNode();
  final focus2 = FocusNode();

  bool click = false;
  PosController posController = Get.put(PosController());
  bool showp = false;
  bool showc = false;
  bool showo= false;
  @override
  Widget build(BuildContext context) {
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
        title: Text(S.of(context).changep,
            style: TextStyle(fontSize: 22.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 50),
                  child: Image.network(posController.logog,width: Get.width/2,
                      height: Get.height/11),
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
                          child: TextFormField(
                            controller: oldPass,
                            textInputAction: TextInputAction.next,
                            // Moves focus to next.
                            obscureText: showo == false ? true : false,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focus);
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
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
// and:
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 25,
                                ),
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
                                      showo = !showo;
                                    });
                                  },
                                ),
                                hintText: S.of(context).currentp,
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
                          child: TextFormField(
                            controller: newsPass,
                            textInputAction: TextInputAction.next,
                            // Moves focus to next.
                            obscureText: showp == false ? true : false,
                            focusNode: focus,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focus2);
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
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
// and:
                                errorText: _errorTextNewPass,
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
                                hintText: S.of(context).passnew,
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
                            controller: conPass,
                            textInputAction: TextInputAction.done,
                            // Moves focus to next.
                            obscureText: showc == false ? true : false,
                            focusNode: focus2,

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
                                errorText: _errorTextConPass,
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
                                      showc = !showc;
                                    });
                                  },
                                ),
                                hintText: S.of(context).conP,
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
                InkWell(
                  onTap: () async {
                    setState(() {
                      click = true;
                    });
                    if (_errorTextNewPass == null &&
                        _errorTextPass == null &&
                        _errorTextConPass == null) {
                      setState(() {
                        click = false;
                      });
                      Get.to(() => HomePage());
                    }

                    //  Get.to(() => HomePage());
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Container(
                        width: Get.width,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(
                              S.of(context).changep,
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
      final text = oldPass.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String inserp = S.of(context).isertp;
        return inserp;
      }/*else{
        if(posController.oldpass.value.toString() != oldPass.text.toString()){
          String inserp = S.of(context).oldpassincor;
          return inserp;

        }
      }*/
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextNewPass {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = newsPass.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String inserp = S.of(context).isertnp;
        return inserp;
      } else {
        if (newsPass.value.text != conPass.value.text) {
          String inserp = S.of(context).notmatch;
          return inserp;
        }
      }
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextConPass {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = conPass.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String inserp = S.of(context).isertcp;
        return inserp;
      } else {
        if (newsPass.value.text != conPass.value.text) {
          String inserp = S.of(context).notmatch;
          return inserp;
        }
      }
    }
    // return null if the text is valid
    return null;
  }
}
