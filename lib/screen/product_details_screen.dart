import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/store_rpo.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final ProductModdelList productItem;

  ProductDetails({required this.productItem});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetails();
  }
}

class _ProductDetails extends State<ProductDetails> {
  bool click = false;
  List<CartMode> alarmLi = <CartMode>[];
  List<ProductModdelList> last = [];
  List<ProStore> test = [];
  List<ProductModdelList> alarmLpro = <ProductModdelList>[];

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
                                  S.of(context).Productdetails,
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
                              padding: EdgeInsets.fromLTRB(1, 10, 1, 5),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: widget.productItem.image_url !=
                              'https://heba.icon-pos.com/assets/uploads/no_image.png'
                              ?Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 270,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.productItem.image_url),
                                            fit: BoxFit.fitHeight)),
                                  )            : Container(
                                    height: Get.height / 8,
                                    alignment: Alignment.topCenter,
                                    width: Get.width / 4,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),child: Center(child: Image.asset('assets/images/pro.png',width: 50,height: 50,)),
                                  )),
                            )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Center(
                              child: Text(
                                widget.productItem.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NeoSansArabicRegular',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF002e80)),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Center(
                              child: Text(
                                widget.productItem.second_name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'NeoSansArabicRegular',
                                    fontSize: 16,
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
                                          S.of(context).Type,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.type)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).Brand,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.brandItem.name)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).cat,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.mainCat.name)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).unit,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.unitItem.name)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).price,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.price)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).TaxRate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.texes.name)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).TaxMethod,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.productItem.tax_method)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              QrImage(
                                data: widget.productItem.code,
                                version: QrVersions.auto,
                                size: 100.0,
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
