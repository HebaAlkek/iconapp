import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/customer_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/country_state_package.dart';
import 'package:icon/model/customer_group_model.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/price_group_model.dart';

class StepOneCustomerAdd extends StatefulWidget {
  @override
  _StepOneCustomerAdd createState() => _StepOneCustomerAdd();
}

class _StepOneCustomerAdd extends State<StepOneCustomerAdd>
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
            height: Get.height,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
              S.of(context).customerg,
                    style: TextStyle(
                        color: Color(0xFF002e80),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF002e80),
                                      blurRadius: 1,
                                      spreadRadius: 0)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<CustomerGroupList>(
                                value: customerController.groupItem,
                                isDense: true,
                                onChanged: (CustomerGroupList? val) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  setState(() {
                                    customerController.groupItem = val;
                                  });
                                },
                                items: customerController.customerList.value
                                    .map((final value) {
                                  return DropdownMenuItem<CustomerGroupList>(
                                    value: value,
                                    child: new Text(value.name,
                                        style: TextStyle()),
                                  );
                                }).toList(),
                                isExpanded: true,
                                iconEnabledColor: Color(0xFF002e80),
                                hint: Text(
                                  S.of(context).customerg,
                                  style: TextStyle(
                                    color: Colors.black,
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
                        color: Color(0xFF002e80),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF002e80),
                                      blurRadius: 1,
                                      spreadRadius: 0)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<PriceGroupList>(
                                value: customerController.priceItem,
                                isDense: true,
                                onChanged: (PriceGroupList? val) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  setState(() {
                                    customerController.priceItem = val;
                                  });
                                },
                                items: customerController.priList.value
                                    .map((final value) {
                                  return DropdownMenuItem<PriceGroupList>(
                                    value: value,
                                    child: new Text(value.name,
                                        style: TextStyle()),
                                  );
                                }).toList(),
                                isExpanded: true,
                                iconEnabledColor: Color(0xFF002e80),
                                hint: Text(
                                  S.of(context).priceg,
                                  style: TextStyle(
                                    color: Colors.black,
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
                        color: Color(0xFF002e80),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  CountryStateCityPicker(
                    country: customerController.country,
                    state: customerController.state,
                    city: customerController.city,
                    textFieldInputBorder: UnderlineInputBorder(),
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
