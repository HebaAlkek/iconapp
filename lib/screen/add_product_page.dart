import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/add_product/add-Product_three_page.dart';
import 'package:icon/screen/add_product/add_product_four_page.dart';
import 'package:icon/screen/add_product/add_product_two_page.dart';
import 'package:icon/screen/home_page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'add_product/add_product_one_page.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPage createState() => _AddProductPage();
}

class _AddProductPage extends State<AddProductPage>
    with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  ProductController proController = Get.put(ProductController());
  ProductAllController proAllController = Get.put(ProductAllController());

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
          title: Text(S.of(context).addp,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: Obx(() => Stack(
              children: [
                proController.currentStep.value == 1
                    ? StepOneProductAdd()
                    : proController.currentStep.value == 2
                        ? StepFourProductAdd()
                        : proController.currentStep.value == 3
                            ? StepTwoProductAdd()
                            : StepThreeProductAdd(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              proController.removeStep(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF002e80).withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  S.of(context).Back,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          proController.currentStep.value == 1
                                              ? Colors.grey
                                              : Color(0xFF002e80),
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          StepProgressIndicator(
                            totalSteps: 4,
                            currentStep: proController.currentStep.value,
                            roundedEdges: Radius.circular(10),
                            selectedColor: Color(0xFF002e80),
                            unselectedColor: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              proController.nextStep(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF002e80).withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  proController.currentStep.value != 4
                                      ? S.of(context).Next
                                      : S.of(context).Add,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002e80),
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
