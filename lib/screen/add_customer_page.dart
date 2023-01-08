import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/customer_controller.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/country_state_package.dart';
import 'package:icon/helper/stepper_package.dart';
import 'package:icon/model/customer_group_model.dart';
import 'package:icon/model/price_group_model.dart';
import 'package:icon/screen/edit_customer/step_one_edit_customer.dart';

import 'package:lottie/lottie.dart';

import 'edit_customer/step_two_edit_customer.dart';

class AddCustomerPage extends StatefulWidget {
  String type;
  String id;

  AddCustomerPage(this.type, this.id);

  @override
  _AddCustomerPage createState() => _AddCustomerPage();
}

class _AddCustomerPage extends State<AddCustomerPage>
    with TickerProviderStateMixin {
  CustomerController customerController = Get.put(CustomerController());
  PosController posController = Get.put(PosController());

  @override
  void initState() {
    // Get.delete<CustomerController>();
    customerController.country.text = '';
    customerController.city.text = '';
    customerController.state.text = '';
    customerController.companyN.text = '';
    customerController.name.text = '';
    customerController.vatNum.text = '';
    customerController.gstNum.text = '';
    customerController.email.text = '';
    customerController.phone.text = '';
    customerController.address.text = '';
    customerController.postCode.text = '';
    if (widget.type == '1') {
      customerController.getCustomerList();
    } else {
      customerController.getCustomerDetails(widget.id);
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
          title: Text(S.of(context).addcu,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: widget.type == '1'
            ? Padding(
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
                              child: Obx(() => customerController
                                          .isLoading.value ==
                                      true
                                  ? Center(
                                      child: Lottie.asset(
                                          'assets/images/loading.json',
                                          width: 90,
                                          height: 90),
                                    )
                                  : customerController.currentStep.value == 0
                                      ? Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 10),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 10),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  minHeight: 100,
                                                  maxHeight: double.infinity),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).customerg,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF002e80),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 15, 0, 0.0),
                                                      child: Container(
                                                        width: Get.width,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0.0),
                                                          child: Center(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors.white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Color(
                                                                            0xFF002e80),
                                                                        blurRadius:
                                                                            1,
                                                                        spreadRadius:
                                                                            0)
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10.0,
                                                                        15,
                                                                        10,
                                                                        15),
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                        child: DropdownButton<
                                                                            CustomerGroupList>(
                                                                  value: customerController
                                                                      .groupItem,
                                                                  isDense: true,
                                                                  onChanged:
                                                                      (CustomerGroupList?
                                                                          val) {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            new FocusNode());

                                                                    setState(() {
                                                                      customerController
                                                                              .groupItem =
                                                                          val;
                                                                    });
                                                                  },
                                                                  items: customerController
                                                                      .customerList
                                                                      .map(
                                                                          (final value) {
                                                                    return DropdownMenuItem<
                                                                        CustomerGroupList>(
                                                                      value:
                                                                          value,
                                                                      child: new Text(
                                                                          value
                                                                              .name,
                                                                          style:
                                                                              TextStyle()),
                                                                    );
                                                                  }).toList(),
                                                                  isExpanded:
                                                                      true,
                                                                  iconEnabledColor:
                                                                      Color(
                                                                          0xFF002e80),
                                                                  hint: Text(
                                                                    S
                                                                        .of(context)
                                                                        .customerg,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      S.of(context).priceg,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF002e80),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 15, 0, 0.0),
                                                      child: Container(
                                                        width: Get.width,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0.0),
                                                          child: Center(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors.white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Color(
                                                                            0xFF002e80),
                                                                        blurRadius:
                                                                            1,
                                                                        spreadRadius:
                                                                            0)
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10.0,
                                                                        15,
                                                                        10,
                                                                        15),
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                        child: DropdownButton<
                                                                            PriceGroupList>(
                                                                  value: customerController
                                                                      .priceItem,
                                                                  isDense: true,
                                                                  onChanged:
                                                                      (PriceGroupList?
                                                                          val) {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            new FocusNode());

                                                                    setState(() {
                                                                      customerController
                                                                              .priceItem =
                                                                          val;
                                                                    });
                                                                  },
                                                                  items: customerController
                                                                      .priList
                                                                      .value
                                                                      .map(
                                                                          (final value) {
                                                                    return DropdownMenuItem<
                                                                        PriceGroupList>(
                                                                      value:
                                                                          value,
                                                                      child: new Text(
                                                                          value
                                                                              .name,
                                                                          style:
                                                                              TextStyle()),
                                                                    );
                                                                  }).toList(),
                                                                  isExpanded:
                                                                      true,
                                                                  iconEnabledColor:
                                                                      Color(
                                                                          0xFF002e80),
                                                                  hint: Text(
                                                                    S
                                                                        .of(context)
                                                                        .priceg,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      S.of(context).location,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF002e80),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    CountryStateCityPicker(
                                                      country: customerController
                                                          .country,
                                                      state: customerController
                                                          .state,
                                                      city:
                                                          customerController.city,
                                                      textFieldInputBorder:
                                                          UnderlineInputBorder(),
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                    ),
                                                    Center(
                                                      child: InkWell(
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Color(
                                                                          0xFF002e80)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            15,
                                                                            5,
                                                                            15,
                                                                            5),
                                                                child: Text(
                                                                    S
                                                                        .of(
                                                                            context)
                                                                        .Next,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF002e80),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                              )),
                                                          onTap: () {
                                                            customerController
                                                                .currentStep
                                                                .value++;
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                S.of(context).Company,
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
                                                              customerController
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
                                                S.of(context).Name,
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
                                                              customerController
                                                                  .name,
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
                                                              customerController
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
                                                              customerController
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
                                                              customerController
                                                                  .email,
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
                                                              customerController
                                                                  .phone,
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
                                                              customerController
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
                                                              customerController
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
                                          ),
                                        )),
                            ),
                          ],
                        ),
                      ),
                    ),
                   Obx(()=> customerController.currentStep.value == 0
                       ? Visibility(
                     child: Text(''),
                     visible: false,
                   )
                       : Align(
                     alignment: Alignment.bottomCenter,
                     child: Container(
                         color: Colors.white,
                         child: Padding(
                           padding:
                           const EdgeInsets.fromLTRB(15, 5, 15, 5.0),
                           child: Row(
                             mainAxisAlignment:
                             MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               InkWell(
                                   child: Container(
                                       decoration: BoxDecoration(
                                           color: Color(0xFF002e80),
                                           borderRadius:
                                           BorderRadius.circular(
                                               10)),
                                       child: Padding(
                                         padding: EdgeInsets.fromLTRB(
                                             15, 5, 15, 5),
                                         child: Text(S.of(context).add,
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontWeight:
                                                 FontWeight.bold)),
                                       )),
                                   onTap: () {
                                     customerController.nextStep(context,
                                         widget.type, widget.id);
                                   }),
                               InkWell(
                                   child: Container(
                                       decoration: BoxDecoration(
                                           border: Border.all(
                                               width: 1,
                                               color: Color(0xFF002e80)),
                                           borderRadius:
                                           BorderRadius.circular(
                                               10)),
                                       child: Padding(
                                         padding: EdgeInsets.fromLTRB(
                                             15, 5, 15, 5),
                                         child: Text(S.of(context).Back,
                                             style: TextStyle(
                                                 color:
                                                 Color(0xFF002e80),
                                                 fontWeight:
                                                 FontWeight.bold)),
                                       )),
                                   onTap: () {
                                     customerController
                                         .currentStep.value--;
                                   }),
                             ],
                           ),
                         )),
                   ))
                  ],
                ),
              )
            : ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Container(
                      color: Colors.white,
                      height: Get.height,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Obx(() =>
                            customerController.isLoadingDetails.value == true
                                ? Center(
                                    child: Lottie.asset(
                                        'assets/images/loading.json',
                                        width: 90,
                                        height: 90),
                                  )
                                : _buildStepper(StepperType.vertical)),
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

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = customerController.currentStep.value > 0;
    final canContinue = customerController.currentStep.value < 2;
    return CupertinoStepper(
      type: type,
      currentStep: customerController.currentStep.value,
      onStepTapped: (step) =>
          setState(() => customerController.currentStep.value = step),
      onStepCancel: canCancel
          ? () => setState(() => --customerController.currentStep.value)
          : null,
      onStepContinue: () {
        if (canContinue) {
          customerController.nextStep(context, widget.type, widget.id);
        } else {
          customerController.nextStep(context, widget.type, widget.id);
        }
      },
      steps: [
        for (var i = 0; i < 2; ++i)
          _buildStep(
              title: Text(S.of(context).Step + ' ${i + 1}'),
              isActive: i == customerController.currentStep.value,
              state: i == customerController.currentStep.value
                  ? StepState.editing
                  : i < customerController.currentStep.value
                      ? StepState.complete
                      : StepState.indexed,
              inde: customerController.currentStep.value),
      ],
    );
  }

  Step _buildStep(
      {required Widget title,
      StepState state = StepState.indexed,
      bool isActive = false,
      required int inde}) {
    return Step(
        title: title,
        subtitle: Text(S.of(context).addi),
        state: state,
        isActive: isActive,
        content: Container(
            constraints:
                BoxConstraints(minHeight: 100, maxHeight: double.infinity),
            height: Get.height / 1.5,
            child: inde == 0 ? StepOneCustomerEdit() : StepTwoCustomerEdit()));
  }
}
