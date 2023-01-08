import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';

class InvoiceDeailsPage extends StatefulWidget {
  List<String> resultCode;

  InvoiceDeailsPage(this.resultCode);

  @override
  _InvoiceDeailsPage createState() => _InvoiceDeailsPage();
}

class _InvoiceDeailsPage extends State<InvoiceDeailsPage>
    with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
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
          title: Text(S.of(context).invoiced,
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), boxShadow: [
      BoxShadow(
          color: Color(0xFF002e80),
          blurRadius: 3,
          spreadRadius: 0)
    ],
                        color: Colors.white,
                       ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                      child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Center(
                            child: Text(

                                  widget.resultCode[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20,color: Color(0xFF002e80)),

                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(height: 1,width: Get.width,
                          color: Color(0xFF002e80).withOpacity(0.3),),
                          SizedBox(
                            height: 20,
                          ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                           Text(
                             S.of(context).vatnum ,
                             style: TextStyle(fontWeight: FontWeight.bold,
                                 fontSize: 17,color: Color(0xFF002e80)),
                           ),
                           SizedBox(height: 5,),
                           Text(

                             widget.resultCode[1],
                             style: TextStyle(color: Colors.grey),
                           ),
                         ],),
                         Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                           Text(
                             S.of(context).invoicedate ,
                             style: TextStyle(fontWeight: FontWeight.bold,
                                 fontSize: 17,color: Color(0xFF002e80)),
                           ),
                           SizedBox(height: 5,),
                           Text(

                             widget.resultCode[2],
                             style: TextStyle(color: Colors.grey),
                           ),
                         ],)
                       ],),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).tota ,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 17,color: Color(0xFF002e80)),
                          ),
                          SizedBox(height: 5,),
                          Text(

                            widget.resultCode[3]+ ' '+S.of(context).sr,
                            style: TextStyle(color: Colors.grey),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).vatamount ,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 17,color: Color(0xFF002e80)),
                          ),
                          SizedBox(height: 5,),
                          Text(

                            widget.resultCode[4]+ ' '+S.of(context).sr,
                            style: TextStyle(color: Colors.grey),
                          ),

                          SizedBox(
                            height: 20,
                          ),
//Test Biller,	123456789,2022,03,17 17,44,40,100,0000,13,0400
                        ],
                      ),
                    ),
                  )
                ],
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
