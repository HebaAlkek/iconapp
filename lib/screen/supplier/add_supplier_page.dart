import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/supplier_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/country_state_package.dart';
import 'package:icon/helper/stepper_package.dart';
import 'package:icon/model/supplier_model.dart';

import 'package:lottie/lottie.dart';

class AddSupplierPage extends StatefulWidget {
  final String type;
  final SupplierModelList item;

  AddSupplierPage(this.type, this.item);

  @override
  _AddSupplierPage createState() => _AddSupplierPage();
}

class _AddSupplierPage extends State<AddSupplierPage>
    with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  SupplierController supController = Get.put(SupplierController());

  @override
  void initState() {
    // Get.delete<supController>();

    supController.country.text = '';
    supController.city.text = '';
    supController.state.text = '';
    supController.companyN.text = '';
    supController.name.text = '';
    supController.vatNum.text = '';
    supController.gstNum.text = '';
    supController.email.text = '';
    supController.phone.text = '';
    supController.address.text = '';
    supController.postCode.text = '';
    if (widget.type == '2') {
      supController.country.text =
          widget.item.country == 'null' ? '' : widget.item.country;
      supController.city.text =
          widget.item.city == 'null' ? '' : widget.item.city;
      supController.state.text =
          widget.item.state == 'null' ? '' : widget.item.state;
      supController.companyN.text = widget.item.company;
      supController.name.text = widget.item.person;
      supController.vatNum.text =
          widget.item.vat_no == 'null' ? '' : widget.item.vat_no;
      supController.gstNum.text =
          widget.item.gst_no == 'null' ? '' : widget.item.gst_no;
      supController.email.text =
          widget.item.email == 'null' ? '' : widget.item.email;
      supController.phone.text =
          widget.item.phone == 'null' ? '' : widget.item.phone;
      supController.address.text =
          widget.item.address == 'null' ? '' : widget.item.address;
      supController.postCode.text =
          widget.item.postal_code == 'null' ? '' : widget.item.postal_code;
    }
    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
          title: Text(S.of(context).addsup,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  height: Get.height,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Obx(() => supController.currentStep.value == 0
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        minHeight: 100,
                                        maxHeight: double.infinity),
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              ' * ' + S.of(context).Company,
                                              style: TextStyle(
                                                  color: Color(0xFF002e80),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController
                                                                .companyN,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .Company,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              ' * ' + S.of(context).Name,
                                              style: TextStyle(
                                                  color: Color(0xFF002e80),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController.name,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .Name,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController
                                                                .vatNum,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .vat,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController
                                                                .gstNum,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .gst,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController.email,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .Email,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController.phone,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .Phone,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            supController
                                                                .address,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .Address,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 10,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 5),
                                                      child: TextField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        controller:
                                                            supController
                                                                .postCode,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF002e80)),
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                labelStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent),
                                                                ),
// and:

                                                                suffixStyle: TextStyle(
                                                                    color: Color(
                                                                        0xFF002e80)),
                                                                hintText: S
                                                                    .of(context)
                                                                    .postal,
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                      )),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFF002e80),
                                                            blurRadius: 2,
                                                            spreadRadius: 0)
                                                      ]),
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        )),
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).location,
                                      style: TextStyle(
                                          color: Color(0xFF002e80),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    CountryStateCityPicker(
                                      country: supController.country,
                                      state: supController.state,
                                      city: supController.city,
                                      textFieldInputBorder:
                                          UnderlineInputBorder(),
                                    ),
                                  ],
                                ),
                              )),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => supController.currentStep.value == 0
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF002e80),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          child: Text(S.of(context).Next,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    onTap: () {
                                      if (supController.name.text == '' ||
                                          supController.companyN.text == '') {
                                        Get.snackbar(S.of(context).Error,
                                            S.of(context).insetdata,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.6));
                                      } else {
                                        supController.currentStep.value = 1;
                                      }
                                    }),
                              ],
                            ),
                          )),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF002e80),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          child: Text(
                                              widget.type == '1'
                                                  ? S.of(context).add
                                                  : S.of(context).edit,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    onTap: () {
                                      if (widget.type == '1') {
                                        supController.AddSupplier();
                                      } else {
                                       supController.EditSupplier(widget.item.id);
                                      }
                                    }),
                                InkWell(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xFF002e80)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          child: Text(S.of(context).Back,
                                              style: TextStyle(
                                                  color: Color(0xFF002e80),
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    onTap: () {
                                      supController.currentStep.value--;
                                    }),
                              ],
                            ),
                          )),
                    ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
