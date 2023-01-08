import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/supplier_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/screen/supplier/add_supplier_page.dart';

class SupplierCard extends StatelessWidget {
  var layout;
  BuildContext contextt;

  SupplierCard(this.layout, this.contextt);

  PosController posController = Get.put(PosController());
  SupplierController subController = Get.put(SupplierController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: _getBodyWidget(context),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return Container(            height: Get.height / 6,

      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Color(0xFF002e80), spreadRadius: 0, blurRadius: 4),
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height / 6,
            width: Get.width / 6,
            decoration: BoxDecoration(
              borderRadius: posController.languagee == 'en'
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))
                  : BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15)),
              color: Colors.white,
            ),
            child: Stack(children: [
              Container(            height: Get.height / 6,

                decoration: BoxDecoration(
                    borderRadius: posController.languagee == 'en'
                        ? BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))
                        : BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15)),
                    color: Color(0xFF002e80)),
                width: Get.width / 12,
              ),
              Center(
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/supp.jpg',
                            ),
                            fit: BoxFit.fill))),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.person,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                layout.company=='null'?Visibility(child: Text(''),visible: false,):        Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.account_balance_sharp, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.company,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ),
                layout.email=='null'?Visibility(child: Text(''),visible: false,):
                layout.email==null?Visibility(child: Text(''),visible: false,):
                layout.email==''?Visibility(child: Text(''),visible: false,): Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.email_outlined, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.email,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ),

                layout.phone=='null'?Visibility(child: Text(''),visible: false,):
                layout.phone==null?Visibility(child: Text(''),visible: false,):
                layout.phone==''?Visibility(child: Text(''),visible: false,):Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.phone, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.phone,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ),
                layout.country=='null'?Visibility(child: Text(''),visible: false,):

                layout.country=='null'?Visibility(child: Text(''),visible: false,):
                layout.country==null?Visibility(child: Text(''),visible: false,):
                layout.country==''?Visibility(child: Text(''),visible: false,):

                layout.city=='null'?     Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.location_on_outlined, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.country,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ):
                layout.city==null?  Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.location_on_outlined, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.country,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ):
                layout.city==''?  Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.location_on_outlined, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.country,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ):
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                  child: Row(children: [
                    Icon(Icons.location_on_outlined, size: 14),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: Get.width / 2.1,
                      child: Text(
                        layout.country + ' - '+        layout.city,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
      new Spacer(),
  posController.permission.value.length != 0?     posController.suppEdit=='1'?posController.suppDelete=='1'?            PopupMenuButton(
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
                                posController.languagee == 'en'
                                    ? Text('Are you sure you want to delete?')
                                    : Text('هل تريد الحذف بالتأكيد؟',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF005189)),
                                        textAlign: TextAlign.center),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('yes selected');
                                          Navigator.of(context).pop();
                                       subController.deleteSupplier(context, layout.id);

                                        },
                                        child: posController.languagee == 'en'
                                            ? Text('Yes')
                                            : Text('موافق'),
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
                                      child: Text(S.of(context).Cancel,
                                          style:
                                              TextStyle(color: Colors.black)),
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
                  Get.to(()=>AddSupplierPage('2', layout));
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

               Get.to(()=>AddSupplierPage('2', layout));

             //  _value = value;
           },
           itemBuilder: (context) => [
             PopupMenuItem(
               child: Text(S.of(context).edit),
               value: 1,
             ),

           ]):posController.suppDelete=='1'?
       PopupMenuButton(
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
                             posController.languagee == 'en'
                                 ? Text('Are you sure you want to delete?')
                                 : Text('هل تريد الحذف بالتأكيد؟',
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     color: Color(0xFF005189)),
                                 textAlign: TextAlign.center),
                             SizedBox(height: 20),
                             Row(
                               children: [
                                 Expanded(
                                   child: ElevatedButton(
                                     onPressed: () {
                                       print('yes selected');
                                       Navigator.of(context).pop();
                                       subController.deleteSupplier(context, layout.id);

                                     },
                                     child: posController.languagee == 'en'
                                         ? Text('Yes')
                                         : Text('موافق'),
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
                                       child: Text(S.of(context).Cancel,
                                           style:
                                           TextStyle(color: Colors.black)),
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
           },
           itemBuilder: (context) => [

             PopupMenuItem(
               child: Text(S.of(context).delete),
               value: 2,
             )
           ]):
           Visibility(child: Text(''),visible: false,)
        :     PopupMenuButton(
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
                        posController.languagee == 'en'
                            ? Text('Are you sure you want to delete?')
                            : Text('هل تريد الحذف بالتأكيد؟',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005189)),
                            textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  print('yes selected');
                                  Navigator.of(context).pop();
                                  subController.deleteSupplier(context, layout.id);

                                },
                                child: posController.languagee == 'en'
                                    ? Text('Yes')
                                    : Text('موافق'),
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
                                  child: Text(S.of(context).Cancel,
                                      style:
                                      TextStyle(color: Colors.black)),
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
          Get.to(()=>AddSupplierPage('2', layout));
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
      ])],
      ),
    );
  }
}
