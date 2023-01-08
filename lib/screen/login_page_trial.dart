import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPageTrial extends StatefulWidget {
  @override
  _LoginPageTrial createState() => new _LoginPageTrial();
}

class _LoginPageTrial extends State<LoginPageTrial> {
  TextEditingController username = TextEditingController();
  TextEditingController emailp = TextEditingController();
  TextEditingController phone = TextEditingController();

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
                  padding:
                  const EdgeInsets.fromLTRB(20, 0, 20, 50),
                  child: Image.asset('assets/images/pos.png'),
                ),

                //                                Image.asset('assets/images/minilogo.png'),
                SizedBox(
                  height: 30,
                ),
                Center(child:Text(S.of(context).additem,textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),)),
                SizedBox(
                  height: 30,
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
                            controller: emailp,
                            textInputAction: TextInputAction.next,
                            // Moves focus to next.
                            keyboardType: TextInputType.emailAddress,

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
                                  Icons.email_outlined,
                                  color: Color(0xFF002e80),
                                  size: 18,
                                ),

                                hintText: S.of(context).Email,
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
                            controller: phone,
                            textInputAction: TextInputAction.done,
                            // Moves focus to next.
keyboardType: TextInputType.phone,
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
                                errorText: _errorTextName,
                                errorStyle: TextStyle(color: Colors.red),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color(0xFF002e80),
                                  size: 18,
                                ),

                                hintText: S.of(context).Phone,
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

                        if (EmailValidator.validate(emailp
                            .text)) {
                          if(phone.text.length<10){
                            Get.snackbar(S.of(context).Error, S.of(context).validn,
                                backgroundColor: Colors.grey.withOpacity(0.6));
                          }else{
                            final prefs = await SharedPreferences
                                .getInstance();
                            prefs.setString('baseurl',
                                'https://icon-pos.com');
                            posController.getLogoTrail(emailp.text,phone.text,username.text,context);
                          }

                        } else {
                          Get.snackbar(S.of(context).Error, S.of(context).valid,
                              backgroundColor: Colors.grey.withOpacity(0.6));
                        }




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
/*
 void send() async {
    final Email email = Email(
      body:' Email :'+ emailp.text+' , \n Mobile Number : '+phone.text,
      subject: 'Icon App Trial',
      recipients: ['HebaAlkek@outlook.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email).whenComplete(() async {
print('com');

         */
/*  final prefs = await SharedPreferences
          .getInstance();
      prefs.setString('baseurl',
          'https://icon-pos.com');
      posController.getLogoTrail(context);*//*
});

    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

  }
*/
  String? get _errorTextPass {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = emailp.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String inserp = S.of(context).iserte;
        return inserp;
      }
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextName {
    if (click == true) {
      // at any time, we can get the text from _controller.value.text
      final text = phone.value.text;
      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code
      if (text.isEmpty) {
        String isertu = S.of(context).isertph;

        return isertu;
      }
    }
    // return null if the text is valid
    return null;
  }
}
class GoogleAuthApi {
  static final _googleSignIn =
  GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?> signIn() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }
}