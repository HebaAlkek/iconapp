import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/retrive_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/retive_page.dart';
import 'package:icon/widget/ref_card.dart';

import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefPage extends StatefulWidget {
  String result;
  String type;

  RefPage(this.result, this.type);

  @override
  _RefPage createState() => _RefPage();
}

class _RefPage extends State<RefPage> with TickerProviderStateMixin {
  RetriveController refController = Get.put(RetriveController());
  PosController posController = Get.put(PosController());

  @override
  void initState() {
    if (widget.type == '1') {
      refController.getRetriveList(widget.result, context);
    }else{
      refController.getRetriveListPurchases(widget.result);


    }
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () async {
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
        title: Text(S.of(context).addr,
            style: TextStyle(fontSize: 22.0, color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() => refController.isLoadingList.value == true
              ? Center(
                  child: Lottie.asset('assets/images/loading.json',
                      width: 90, height: 90),
                )
              : refController.refList.length == 0
                  ? Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 8.0),
                        child: Center(
                          child: Lottie.asset('assets/images/nodata.json',
                              height: 250, width: 250),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (posController.permission.value.length !=
                                        0) {
                                      if (posController.retuAdd == '1') {
                                        Get.to(() => RetrivePage(refController
                                            .refList.value[index].refNo,'1'));
                                      } else {
                                        Get.snackbar(S.of(Get.context!).Error,
                                            S.of(Get.context!).noper,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.6));
                                      }
                                    } else {
                                      Get.to(() => RetrivePage(refController
                                          .refList.value[index].refNo,'1'));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 5, 15, 10),
                                    child: RefCard(
                                        refController.refList.value[index],
                                        context),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: refController.refList.value.length,
                            ),
                          )),
                    )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
