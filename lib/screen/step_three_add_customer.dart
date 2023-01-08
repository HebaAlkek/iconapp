import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/customer_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/customer_model.dart';

class StepThreeCustomerAdd extends StatefulWidget {
  @override
  _StepThreeCustomerAdd createState() => _StepThreeCustomerAdd();
}

class _StepThreeCustomerAdd extends State<StepThreeCustomerAdd>
    with TickerProviderStateMixin {
  CustomerController customerController = Get.put(CustomerController());

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
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Container(
            color: Colors.white,
            //height: Get.height,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).customero,
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
                              controller: customerController.customerFO,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
// and:

                                  suffixStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  hintText: S.of(context).customero,
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
                    S.of(context).customert,
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
                              controller: customerController.customerFT,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
// and:

                                  suffixStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  hintText: S.of(context).customert,
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
                    S.of(context).customerth,
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
                              controller: customerController.customerFTh,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
// and:

                                  suffixStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  hintText: S.of(context).customerth,
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
                    S.of(context).customerf,
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
                              controller: customerController.customerFF,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
// and:

                                  suffixStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  hintText: S.of(context).customerf,
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
                    S.of(context).customerfi,
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
                              controller: customerController.customerFFi,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
// and:

                                  suffixStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  hintText: S.of(context).customerfi,
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
                    S.of(context).customerse,
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
                              controller: customerController.customerFSe,
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
// and:

                                  suffixStyle:
                                      TextStyle(color: Color(0xFF002e80)),
                                  hintText: S.of(context).customerse,
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
                ],
              ),
            ),
          ),
        )
      ],
      shrinkWrap: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
