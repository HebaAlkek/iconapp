import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/add_product/add-Product_three_page.dart';
import 'package:icon/screen/add_product/add_product_four_page.dart';
import 'package:icon/screen/add_product/add_product_two_page.dart';
import 'package:icon/screen/edit_product/edit_producr_step_three.dart';
import 'package:icon/screen/edit_product/edit_product_step_four.dart';
import 'package:icon/screen/edit_product/edit_product_step_one.dart';
import 'package:icon/screen/edit_product/edit_product_step_two.dart';
import 'package:icon/screen/home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class EditProductPage extends StatefulWidget {
  final String proId;

  EditProductPage(this.proId);

  @override
  _EditProductPage createState() => _EditProductPage();
}

class _EditProductPage extends State<EditProductPage>
    with TickerProviderStateMixin {

  ProductAllController proAllController = Get.put(ProductAllController());

  @override
  void initState() {
    proAllController.getDetailsProducr(
      widget.proId,
    );



    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                proAllController.languagee.value == 'en'
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
        body:  Obx(() => proAllController.isLoadingdetails.value == true
            ? Center(
          child: Lottie.asset('assets/images/loading.json',
              width: 90, height: 90),
        )
            : Stack(
          children: [
            proAllController.currentStep.value == 1
                ? StepOneProducEdit()
                : proAllController.currentStep.value == 2
                ? StepTwoProductEdit()
                : proAllController.currentStep.value == 3
                ? StepThreeProductEdit()
                : StepFourProductEdit(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          proAllController.removeStep(context);
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
                                  proAllController.currentStep.value == 1
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
                        currentStep: proAllController.currentStep.value,
                        roundedEdges: Radius.circular(10),
                        selectedColor: Color(0xFF002e80),
                        unselectedColor: Colors.grey,
                      ),
                      InkWell(
                        onTap: () {
                          proAllController.nextStep(context);
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
                              proAllController.currentStep.value != 4
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
