import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/category_controller.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/screen/add_brand_page.dart';
import 'package:icon/screen/add_category_screen.dart';
import 'package:icon/screen/add_sub_categoru_screen.dart';

class CategoryCard extends StatelessWidget {
  var layout;
  var itemb;
  var itemc;
  BuildContext conte;
  String type;

  CategoryCard(this.layout, this.itemb, this.itemc, this.conte, this.type);

  CategoryController catController = Get.put(CategoryController());
  PosController posController = Get.put(PosController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: layout != null
          ? Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color(0xFF002e80), spreadRadius: 0, blurRadius: 4),
              ], borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  layout.image != 'null'
                      ? Stack(
                          children: [
                            Container(
                              height: Get.height / 8,
                              alignment: Alignment.topCenter,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://heba.icon-pos.com/assets/uploads/' +
                                              layout.image),
                                      fit: BoxFit.fill)),
                            ),
                            /* InkWell(
                      child: Align(alignment: Alignment.topRight,child: Padding(padding: EdgeInsets.fromLTRB(5, 10, 5, 1),
                        child: Icon(Icons.more_vert),),),
                    ),*/
                            Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                    elevation: 10,
                                    shape: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                            width: 1)),
                                    enabled: true,
                                    onSelected: (value) {
                                      if (value == 2) {
                                        catController.deleteCat(
                                            context, layout.id, '1');
                                      } else {
                                        Get.to(
                                            () => AddCategoryPage('2', layout));
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
                                        ]))
                          ],
                        )
                      : Stack(
                          children: [
                            Container(
                              height: Get.height / 8,
                              alignment: Alignment.center,
                              width: Get.width,
                              child: Icon(
                                Icons.category_outlined,
                                color: Color(0xFF002e80),
                                size: 40,
                              ),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                    elevation: 10,
                                    shape: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                            width: 1)),
                                    enabled: true,
                                    onSelected: (value) {
                                      if (value == 2) {
                                        catController.deleteCat(
                                            context, layout.id, '1');
                                      } else {
                                        Get.to(
                                            () => AddCategoryPage('2', layout));
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
                                        ]))
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      layout.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : itemb != null
              ? Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF002e80),
                            spreadRadius: 0,
                            blurRadius: 4),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      itemb.image != 'null'
                          ? Stack(
                              children: [
                                Container(
                                  height: Get.height / 8,
                                  alignment: Alignment.topCenter,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://heba.icon-pos.com/assets/uploads/' +
                                                  itemb.image),
                                          fit: BoxFit.fill)),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton(
                                        elevation: 10,
                                        shape: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1)),
                                        enabled: true,
                                        onSelected: (value) async {
                                          if (value == 2) {
                                            if (type == '1') {
                                              catController.deleteCat(
                                                  context, itemb.id, '2');
                                            } else if (type == '2') {
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
                                                                      catController.deleteBrand(
                                                                          context, itemb.id);                                                                    },
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

                                            }
                                          } else {
                                            if (type == '1') {
                                              Get.to(() => AddSubCategoryPage(
                                                  '2', itemb));
                                            } else if (type == '2') {
                                              Get.to(() =>
                                                  AddBeandPage('2', itemb));
                                            }
                                          }
                                          //  _value = value;
                                        },
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text(S.of(context).edit),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child:
                                                    Text(S.of(context).delete),
                                                value: 2,
                                              )
                                            ]))
                              ],
                            )
                          : Stack(
                              children: [
                                Container(
                                  height: Get.height / 8,
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  child: Icon(
                                    Icons.category_outlined,
                                    color: Color(0xFF002e80),
                                    size: 40,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton(
                                        elevation: 10,
                                        shape: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                width: 1)),
                                        enabled: true,
                                        onSelected: (value) async {
                                          if (value == 2) {
                                            if (type == '1') {
                                              catController.deleteCat(
                                                  context, itemb.id, '2');
                                            } else if (type == '2') {


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
                                                                      catController.deleteBrand(
                                                                          context, itemb.id);                                                                    },
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


                                            }
                                          } else {
                                            if (type == '1') {
                                              Get.to(() => AddSubCategoryPage(
                                                  '2', itemb));
                                            } else if (type == '2') {
                                              Get.to(() =>
                                                  AddBeandPage('2', itemb));
                                            }
                                          }
                                          //  _value = value;
                                        },
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text(S.of(context).edit),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child:
                                                    Text(S.of(context).delete),
                                                value: 2,
                                              )
                                            ]))
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          itemb.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF002e80),
                            spreadRadius: 0,
                            blurRadius: 4),
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          itemc.name,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          itemc.company,
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
