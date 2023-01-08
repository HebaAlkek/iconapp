import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';

import 'package:icon/screen/edit_product/edit_product_page.dart';

class RefCard extends StatelessWidget {
  var layout;
  BuildContext context;

  RefCard(this.layout, this.context);

  PosController posController = Get.put(PosController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Color(0xFF002e80), spreadRadius: 0, blurRadius: 4),
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
            height: 70,
            alignment: Alignment.topCenter,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: posController.languagee == 'en'
                  ? BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15))
                  : BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF002e80).withOpacity(0.1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ],
              color: Colors.white,
            ),
            child: Center(
                child: Icon(Icons.point_of_sale,color: Color(0xFF005189),)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 5),
            child: Column(
              children: [
                Container(
                  width: Get.width / 2.4,
                  child: Text(
                    layout.refNo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),

              ],
            ),
          ),
          new Spacer(),
         Padding(padding: EdgeInsets.all(10),
         child: Icon( posController.languagee == 'en'?Icons.keyboard_arrow_right:Icons.keyboard_arrow_left_sharp,color:Color(0xFF005189)),)
        ],
      ),
    );
  }
}
