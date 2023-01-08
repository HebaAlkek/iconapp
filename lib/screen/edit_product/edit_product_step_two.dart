import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/supModelAdd.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepTwoProductEdit extends StatefulWidget {

  @override
  _StepTwoProductEdit createState() => _StepTwoProductEdit();
}

class _StepTwoProductEdit extends State<StepTwoProductEdit>
    with TickerProviderStateMixin {
  // TextEditingController slug = TextEditingController();

  ProductAllController proAllController = Get.put(ProductAllController());
  final _horizontalScrollController = ScrollController();
  PickedFile? imageFile;

  @override
  void initState() {
    // TODO: implement initState
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
          child: ListView(
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
                          ' * ' + S.of(context).productn,
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
                                    controller: proAllController.productN,
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
                                        hintText: S.of(context).productn,
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
                          height: 20,
                        ),
                        Text(
                          ' * ' +   S.of(context).arabic,
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
                                    controller: proAllController.nameAra,
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
                                        hintText: S.of(context).arabic,
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
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :  SizedBox(
                          height: 20,
                        ),
                        /*  Text(
                          S.of(context).Slug,
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
                                    controller: slug,
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
                                        hintText: S.of(context).Slug,
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
                          height: 20,
                        ),*/
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :Text(
                          S.of(context).weight,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :SizedBox(
                          height: 10,
                        ),
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: proAllController.weight,
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
                                        hintText: S.of(context).weight,
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
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :

                        SizedBox(
                          height: 20,
                        ),
                        proAllController.proItem!.id.toString() != '1'?Visibility(child:Text(''),visible: false,) :
                        Text(
                          ' * ' +     S.of(context).cost,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        proAllController.proItem!.id.toString() != '1'?Visibility(child:Text(''),visible: false,) :SizedBox(
                          height: 10,
                        ),
                        proAllController.proItem!.id.toString() != '1'?Visibility(child:Text(''),visible: false,):Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: proAllController.cost,
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
                                        hintText: S.of(context).cost,
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

                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :SizedBox(
                          height: 20,
                        ),

                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :  Text(
                          ' * ' +  S.of(context).propi,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :   SizedBox(
                          height: 10,
                        ),
                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :    Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: proAllController.price,
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
                                        hintText: S.of(context).propi,
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
                          height: 20,
                        ),
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :Text(
                          S.of(context).alert,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :SizedBox(
                          height: 10,
                        ),
                        proAllController.proItem!.id.toString() == '3'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '4'?Visibility(child:Text(''),visible: false,) :
                        proAllController.proItem!.id.toString() == '2'?Visibility(child:Text(''),visible: false,) :Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: proAllController.alert,
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
                                        hintText: S.of(context).alert,
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
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

}
