import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/customer_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/customer_model.dart';

class StepTwoCustomerAdd extends StatefulWidget {
  @override
  _StepTwoCustomerAdd createState() => _StepTwoCustomerAdd();
}

class _StepTwoCustomerAdd extends State<StepTwoCustomerAdd>
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
                    S.of(context).Company,
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
                              controller: customerController.companyN,
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
                                  hintText: S.of(context).Company,
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
                    S.of(context).Name,
                    style: TextStyle(
                        color: Color(0xFF002e80),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
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
                              controller: customerController.name,
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
                                  hintText: S.of(context).Name,
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
                    S.of(context).vat,
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
                              controller: customerController.vatNum,
                              keyboardType: TextInputType.number,
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
                                  hintText: S.of(context).vat,
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
                    S.of(context).gst,
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
                              controller: customerController.gstNum,
                              keyboardType: TextInputType.number,
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
                                  hintText: S.of(context).gst,
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
                    S.of(context).Email,
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
                              controller: customerController.email,
                              keyboardType: TextInputType.emailAddress,
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
                                  hintText: S.of(context).Email,
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
                    S.of(context).Phone,
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
                              controller: customerController.phone,
                              keyboardType: TextInputType.number,
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
                                  hintText: S.of(context).Phone,
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
                    S.of(context).Address,
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
                              controller: customerController.address,
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
                                  hintText: S.of(context).Address,
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
                    S.of(context).postal,
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
                              controller: customerController.postCode,
                              keyboardType: TextInputType.number,
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
                                  hintText: S.of(context).postal,
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
