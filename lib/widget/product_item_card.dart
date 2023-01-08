import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/produce_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModdelList layout;

  ProductCard(this.layout);

  PosController posController = Get.put(PosController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: layout.select == false ? Colors.grey : Color(0xFF002e80),
              spreadRadius: 0,
              blurRadius: layout.select == false ? 2 : 4),
        ], borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            layout.image_url !=
                'https://heba.icon-pos.com/assets/uploads/no_image.png'
                ?  Container(
              height: Get.height / 8,
              alignment: Alignment.topCenter,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(layout.image_url), fit: BoxFit.fill)),
            ):
            Container(
              height: Get.height / 8,
              alignment: Alignment.topCenter,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
              ),child: Center(child: Image.asset('assets/images/pro.png',width: 50,height: 50,)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                posController.languagee == 'en'
                    ? layout.name
                    : layout.second_name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                S.of(context).price + layout.price,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
