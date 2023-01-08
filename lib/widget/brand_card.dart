import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/category_controller.dart';
import 'package:icon/controller/customer_controller.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/screen/add_brand_page.dart';
import 'package:icon/screen/add_category_screen.dart';
import 'package:icon/screen/add_product_page.dart';
import 'package:icon/screen/add_sub_categoru_screen.dart';
import 'package:icon/screen/edit_product/edit_product_page.dart';

class BrandCatCard extends StatelessWidget {
  var layout;
  BuildContext context;

  BrandCatCard(this.layout, this.context);

  PosController posController = Get.put(PosController());
  CategoryController catController = Get.put(CategoryController());

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          layout.image != 'null'
              ? Container(
            height: Get.height / 12,
            alignment: Alignment.topCenter,
            width: Get.width / 4,
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
                image: DecorationImage(
                    image: MemoryImage(
                            layout.imgfile),
                    fit: BoxFit.fill)),
          )
              : Container(
            height: Get.height / 12,
            alignment: Alignment.topCenter,
            width: Get.width / 4,
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
              child: Icon(
                Icons.category_outlined,
                color: Color(0xFF002e80),
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 5),
            child: Column(
              children: [
                Container(
                  width: Get.width / 2.4,
                  child: Text(
                    layout.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          new Spacer(),
          posController.permission.value.length != 0?   posController.proEdit=='1'?posController.proLstDelete=='1'?      PopupMenuButton(
              elevation: 10,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2), width: 1)),
              enabled: true,
              onSelected: (value) async {
                if (value == 2) {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 110,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                posController.languagee=='en'? Text('Are you sure you want to delete?'):
                                Text('هل تريد الحذف بالتأكيد؟',style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Color(0xFF005189)),textAlign: TextAlign.center),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('yes selected');
                                          Navigator.of(context).pop();

                                          catController.deleteBrand(
                                              context, layout.id);                                        },
                                        child:  posController.languagee=='en'?Text('Yes'):Text('موافق'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF005189)),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('no selected');
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(S.of(context).Cancel, style: TextStyle(color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });

                } else {
                  Get.to(() =>
                      AddBeandPage('2', layout));                  //   Get.to(() => EditProductPage( layout.id));
                }
                //  _value = value;
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(S.of(context).edit),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text(S.of(context).delete),
                  value: 2,
                )
              ]):
          PopupMenuButton(
              elevation: 10,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2), width: 1)),
              enabled: true,
              onSelected: (value) async {

                  Get.to(() =>
                      AddBeandPage('2', layout));                  //   Get.to(() => EditProductPage( layout.id));

                //  _value = value;
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(S.of(context).edit),
                  value: 1,
                ),

              ]):posController.proLstDelete=='1'?
          PopupMenuButton(
              elevation: 10,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2), width: 1)),
              enabled: true,
              onSelected: (value) async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 110,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                posController.languagee=='en'? Text('Are you sure you want to delete?'):
                                Text('هل تريد الحذف بالتأكيد؟',style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Color(0xFF005189)),textAlign: TextAlign.center),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('yes selected');
                                          Navigator.of(context).pop();

                                          catController.deleteBrand(
                                              context, layout.id);                                        },
                                        child:  posController.languagee=='en'?Text('Yes'):Text('موافق'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF005189)),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('no selected');
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(S.of(context).Cancel, style: TextStyle(color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });


                //  _value = value;
              },
              itemBuilder: (context) => [

                PopupMenuItem(
                  child: Text(S.of(context).delete),
                  value: 2,
                )
              ]):Visibility(child: Text(''),visible: false,):   PopupMenuButton(
              elevation: 10,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2), width: 1)),
              enabled: true,
              onSelected: (value) async {
                if (value == 2) {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 110,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                posController.languagee=='en'? Text('Are you sure you want to delete?'):
                                Text('هل تريد الحذف بالتأكيد؟',style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Color(0xFF005189)),textAlign: TextAlign.center),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('yes selected');
                                          Navigator.of(context).pop();

                                          catController.deleteBrand(
                                              context, layout.id);                                        },
                                        child:  posController.languagee=='en'?Text('Yes'):Text('موافق'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF005189)),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('no selected');
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(S.of(context).Cancel, style: TextStyle(color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });

                } else {
                  Get.to(() =>
                      AddBeandPage('2', layout));                  //   Get.to(() => EditProductPage( layout.id));
                }
                //  _value = value;
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(S.of(context).edit),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text(S.of(context).delete),
                  value: 2,
                )
              ])
        ],
      ),
    );
  }
}
