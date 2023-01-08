import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/store_rpo.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetails extends StatefulWidget {
  var Item;
  String type;

  CategoryDetails({required this.Item, required this.type});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryDetails();
  }
}

class _CategoryDetails extends State<CategoryDetails> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Container(
        height: Get.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white,
        ),
        constraints: BoxConstraints(minHeight: 50, maxHeight: double.infinity),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Stack(
            children: [
              ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF002e80),
                                    spreadRadius: 0,
                                    blurRadius: 1)
                              ]),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  widget.type == '1'
                                      ? S.of(context).catdesub
                                      : S.of(context).catde,
                                  style: TextStyle(
                                    fontFamily: 'NeoSansArabicRegular',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Icon(Icons.cancel_outlined),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Center(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(1, 0, 1, 5),
                              child: widget.Item.image != 'null'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 270,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://heba.icon-pos.com/assets/uploads/' +
                                                        widget.Item.image),
                                                fit: BoxFit.fitHeight)),
                                      ))
                                  : Container(
                                      height: Get.height / 8,
                                      alignment: Alignment.topCenter,
                                      width: Get.width / 4,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.category_outlined,
                                          color: Color(0xFF002e80),
                                          size: 40,
                                        ),
                                      ),
                                    ),
                            )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                            child: Center(
                              child: Text(
                                widget.Item.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NeoSansArabicRegular',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002e80)),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).code,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.Item.code)
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      widget.type != '1'
                                          ? Visibility(
                                              child: Text(''),
                                              visible: false,
                                            )
                                          : widget.Item.catName == ''
                                              ? Visibility(
                                                  child: Text(''),
                                                  visible: false,
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        S.of(context).maincat +
                                                            ' : ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 10, 0),
                                                        child: Text(
                                                          widget.Item.catName,
                                                          style: TextStyle(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                    ],
                                  ),
                                  widget.Item.description == ''
                                      ? Visibility(
                                          child: Text(''),
                                          visible: false,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                S.of(context).desc + ' : ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  widget.Item.description == ''
                                      ? Visibility(
                                          child: Text(''),
                                          visible: false,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                widget.Item.description,
                                                style: TextStyle(),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
