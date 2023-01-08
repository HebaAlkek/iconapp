import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';


import 'package:icon/screen/add_product_page.dart';

import 'package:icon/screen/product_details_screen.dart';

import 'package:icon/widget/product_card_widget.dart';

import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductPage extends StatefulWidget {


  @override
  _ProductPage createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> with TickerProviderStateMixin {

  ProductAllController proAllController = Get.put(ProductAllController());
  bool searchh = false;
  PosController posController = Get.put(PosController());


  @override
  void initState() {

    proAllController.onInit();
    proAllController.getAllPro();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {

    var size = MediaQuery
        .of(context)
        .size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.7;
    final double itemWidth = size.width / 1.8;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              posController.languagee.value == 'ar'
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left_sharp,
              color: Colors.white,
            )),
        actions: [
          Row(
            children: [
         posController.permission.value.length != 0?     posController.proAdd=='1'?  InkWell(
                  onTap: () {
                    Get.delete<ProductController>();

                    Get.to(() => AddProductPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0.0),
                    child:Container(decoration: BoxDecoration(color: Colors.transparent,
                    border: Border.all(color: Colors.white,width: 1),
                    shape: BoxShape.circle),
                    child: Padding(padding: EdgeInsets.all(3),
                    child:  Icon(
                      Icons.add,
                      color: Colors.white,
                    size: 21,),),)
                  )):Visibility(child: Text(''),visible: false):
         InkWell(
             onTap: () {
               Get.delete<ProductController>();

               Get.to(() => AddProductPage());
             },
             child: Padding(
                 padding: const EdgeInsets.fromLTRB(10, 0, 0, 0.0),
                 child:Container(decoration: BoxDecoration(color: Colors.transparent,
                     border: Border.all(color: Colors.white,width: 1),
                     shape: BoxShape.circle),
                   child: Padding(padding: EdgeInsets.all(3),
                     child:  Icon(
                       Icons.add,
                       color: Colors.white,
                       size: 21,),),)
             )),
              InkWell(
                  onTap: () {

                 setState(() {
                   searchh = !searchh;
                 });
                    if (searchh == false) {
                      proAllController.itemsProList.clear();
                      proAllController.searchPro.text = '';
                      proAllController.itemsProList
                          .addAll(proAllController.itemsProListSearc);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0.0),
                    child: searchh == false
                        ? Icon(
                      Icons.search,
                      color: Colors.white,
                    )
                        : Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  )),
            ],
          )
        ],
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
        title: searchh == false
            ? Text(S
            .of(context)
            .Products,
            style: TextStyle(fontSize: 22.0, color: Colors.white))
            : Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
          child: TextField(
            controller: proAllController.searchPro,
              autofocus:true,
            onChanged: (value) {
              filterSearchResults(value);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                isDense: false,
                contentPadding: EdgeInsets.zero,
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: new UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 15,
                  minHeight: 25,
                ),
                hintText: S
                    .of(context)
                    .searchh,
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() =>
          proAllController.isLoadingPro.value == true
              ? Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          )
              : proAllController.itemsProList.length == 0
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
              : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder:(context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("");
                  }
                  else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: proAllController.refreshControllerPos,
              onRefresh: proAllController.onRefresh,
              onLoading: proAllController.onLoading,

              child:Padding(
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
                          showMaterialModalBottomSheet(
                              expand: false,
                              backgroundColor:
                              Colors.transparent,
                              context: context,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.only(
                                    topLeft: Radius
                                        .circular(
                                        25),
                                    topRight: Radius
                                        .circular(
                                        25)),
                              ),
                              builder: (context) =>
                                  ProductDetails(
                                    productItem:
                                    proAllController
                                        .itemsProList
                                        .value[index],


                                  ));
                        }, child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(15, 5, 15, 10),
                        child: ProductCardWidget(
                            proAllController.itemsProList.value[index],
                            context),
                      ),
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                    proAllController.itemsProList.value.length,
                  ),
                )),
          ))),
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

  void filterSearchResults(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(proAllController.itemsProListSearc.value);
    if (query.isNotEmpty) {
      final dummyListData = [];

      if(proAllController.languagee.value=='en'){
        dummySearchList.forEach((item) {
          if (item.name.toString().toLowerCase().contains(query.toString().toLowerCase())) {
            dummyListData.add(item);
          }
        });
      }else{

        dummySearchList.forEach((item) {
          if (item.second_name.toString().toLowerCase().contains(query.toString().toLowerCase())) {
            dummyListData.add(item);
          }
        });
      }



      proAllController.itemsProList.clear();
      proAllController.itemsProList.addAll(dummyListData);

      return;
    } else {
      proAllController.itemsProList.clear();
      proAllController.itemsProList.addAll(proAllController.itemsProListSearc);
    }
  }
}

