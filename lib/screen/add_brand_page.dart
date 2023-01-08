import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/category_controller.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/home_page.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddBeandPage extends StatefulWidget {
  String editType;
  var items;

  AddBeandPage(this.editType, this.items);
  @override
  _AddBeandPage createState() => _AddBeandPage();
}

class _AddBeandPage extends State<AddBeandPage> with TickerProviderStateMixin {
  // TextEditingController slug = TextEditingController();
  PosController posController = Get.put(PosController());

  CategoryController catController = Get.put(CategoryController());
  final _horizontalScrollController = ScrollController();
  PickedFile? imageFile;
  Future<void> setData() async {
    catController.brandCode.text = widget.items.code;
    catController.brandName.text = widget.items.name;
    catController.brandDes.text = widget.items.description;
  }
  @override
  void initState() {
    if (widget.items != null) {
      setData();
    } else {
      catController.brandCode.text = '';
      catController.brandName.text = '';
      catController.brandDes.text = '';
      imageFile = null;
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    final pickedFile = await ImagePicker().getImage(
      maxWidth: 800,
      maxHeight: 150,
      imageQuality: 100,
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
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
        title: Text(S.of(context).addBrand,
            style: TextStyle(fontSize: 22.0, color: Colors.white)),
        centerTitle: true,
      ),
      body:widget.items == null
          ? Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
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
                          S.of(context).brandcode,
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
                                    textInputAction: TextInputAction.next,

                                    controller: catController.brandCode,
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
                                        hintText: S.of(context).brandcode,
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
                          ' * ' + S.of(context).brandname,
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
                                    textInputAction: TextInputAction.next,

                                    controller: catController.brandName,
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
                                        hintText: S.of(context).brandname,
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
                          S.of(context).desc,
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
                                    textInputAction: TextInputAction.done,

                                    controller: catController.brandDes,
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
                                        hintText: S.of(context).desc,
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
                        Row(
                          children: [
                            Text(
                              S.of(context).brandImg,
                              style: TextStyle(
                                  color: Color(0xFF002e80),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            new Spacer(),
                            imageFile==null?Visibility(child: Text(''),visible: false,):InkWell(child: Icon(Icons.delete_forever_sharp,color: Color(0xFF002e80)),
                              onTap: (){
                                setState(() {
                                  imageFile=null;
                                });
                              },)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: imageFile == null
                                ? InkWell(
                                    onTap: () {
                                      _onImageButtonPressed(ImageSource.gallery,
                                          context: context);
                                    },
                                    child: Lottie.asset(
                                        'assets/images/attach.json',
                                        width: 200,
                                        height: 200))
                                :  InkWell(
                                onTap: () {
                                  _onImageButtonPressed(ImageSource.gallery,
                                      context: context);
                                },
                                child: Image.file(
                                    File(imageFile!.path),
                                    height: 300,
                                    width: Get.width,
                                  ))),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (imageFile != null) {
                              catController.addBrand(context, imageFile!);
                            } else {
                              catController.addBrand(context, PickedFile(''));
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(
                                width: Get.width,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Text(
                                      S.of(context).add,
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )):
      Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
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
                          S.of(context).brandcode,
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
                                    controller: catController.brandCode,
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
                                        hintText: S.of(context).brandcode,
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
                          ' * ' + S.of(context).brandname,
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
                                    controller: catController.brandName,
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
                                        hintText: S.of(context).brandname,
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
                          S.of(context).desc,
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
                                    controller: catController.brandDes,
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
                                        hintText: S.of(context).desc,
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
                        Row(
                          children: [
                            Text(
                              S.of(context).brandImg,
                              style: TextStyle(
                                  color: Color(0xFF002e80),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            new Spacer(),
                            imageFile==null?Visibility(child: Text(''),visible: false,):InkWell(child: Icon(Icons.delete_forever_sharp,color: Color(0xFF002e80)),
                              onTap: (){
                                setState(() {
                                  imageFile=null;
                                });
                              },)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: imageFile == null
                                ? widget.items.image == 'null'
                                ? InkWell(
                                onTap: () {
                                  _onImageButtonPressed(
                                      ImageSource.gallery,
                                      context: context);
                                },
                                child: Lottie.asset(
                                    'assets/images/attach.json',
                                    width: 200,
                                    height: 200))
                                : InkWell(
                                onTap: () {
                                  _onImageButtonPressed(
                                      ImageSource.gallery,
                                      context: context);
                                },
                                child: Image.network(
                                  'https://heba.icon-pos.com/assets/uploads/' +
                                      widget.items.image,
                                  height: 300,
                                  width: Get.width,
                                ))
                                :InkWell(
                                onTap: () {
                                  _onImageButtonPressed(
                                      ImageSource.gallery,
                                      context: context);
                                },
                                child: Image.file(
                              File(imageFile!.path),
                              height: 300,
                              width: Get.width,
                            ))),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (imageFile != null) {
                              catController.editBrand(
                                  context, imageFile!, widget.items.id);
                            } else {
                              catController.editBrand(
                                  context, PickedFile(''), widget.items.id);
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(
                                width: Get.width,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: Text(
                                      S.of(context).edit,
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
                        ),
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
