import 'dart:convert';
import 'dart:ui';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:dio/dio.dart' as dio;

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/brand_model.dart';
import 'package:icon/model/cart_model.dart';
import 'package:icon/model/category_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/store_rpo.dart';
import 'package:icon/screen/qr_page.dart';
import 'package:icon/screen/sale_screen.dart';
import 'package:icon/utils/app_constant.dart';
import 'package:icon/widget/cardcont.dart';
import 'package:icon/widget/product_item_card.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class PosPage extends StatefulWidget {
  final AnimationController controller;
  final ZoomDrawerController zoomDrawerController;

  const PosPage(
      {Key? key, required this.controller, required this.zoomDrawerController})
      : super(key: key);

  @override
  _PosPage createState() => _PosPage();
}

class _PosPage extends State<PosPage>
    with AutomaticKeepAliveClientMixin<PosPage> {
  static const header_height = 32.0;

  RefreshController refreshControllerPos = RefreshController(
    initialRefresh: false,
  );

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    posController.pagePos = 1;

    posController.getPosDefault();
    refreshControllerPos.refreshCompleted();

    print('fgbfg');
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    posController.pagePos = posController.pagePos + 10;
    print('lolo');
    posController.getPosDefaultLoading();

    refreshControllerPos.loadComplete();
  }

  @override
  bool get wantKeepAlive => true;
  TextEditingController search = TextEditingController();
  String resu = '0';

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    const frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: RelativeRect.fromLTRB(0.0, 100, 0.0, 0.0))
        .animate(
            CurvedAnimation(parent: widget.controller, curve: Curves.linear));
  }

  List<ProductModdelList> proSelect = [];
  String? orderL;
  TextEditingController cash = TextEditingController();
  bool found = false;
  List<CategoryModelList> subCato = [];
  List<ProductModdelList> alarmLpro = <ProductModdelList>[];
  ProStore allPro = ProStore(listStorePro: <ProductModdelList>[]);


  int quantity = 0;
  double total = 0.0;
  PosController posController = Get.put(PosController());
  List<CartMode> alarmLi = <CartMode>[];
  List<CartMode> alarmLiAdd = <CartMode>[];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      getData();
      print('wertyui');
    } else if (state == AppLifecycleState.resumed) {
      getData();
      print('ee');
    } else if (state == AppLifecycleState.detached) {
      getData();
      print('cccc');
    } else if (state == AppLifecycleState.paused) {
      getData();
      print('gg');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  SharedPreferences? sharedPrefs;

  Future<void> getData() async {
    //   alarmLi.clear();
    sharedPrefs = await SharedPreferences.getInstance();
    alarmLi.clear();
    orderL = sharedPrefs!.getString('cartOrder');
    if (orderL != null) {
      setState(() {
        alarmLi = (json.decode(orderL!) as List<dynamic>)
            .map<CartMode>((item) => CartMode.fromJson(item))
            .toList();
      });
    }
    if (alarmLi.length == 0) {
      setState(() {
        quantity = 0;
        total = 0.0;
      });
    } else {
      if (resu == '0') {
        setState(() {
          quantity = alarmLi[alarmLi.length - 1].quan;
          total = alarmLi[alarmLi.length - 1].total;
        });
      } else {
        setState(() {
          quantity = alarmLi[alarmLi.length - 1].quan;
          total = alarmLi[alarmLi.length - 1].total;
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    posController.getPosDefault();
    super.initState();
  }

  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  var _cartQuantityItems = 0;

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.3;
    final double itemWidth = size.width / 1.8;

    return AddToCartAnimation(
        // To send the library the location of the Cart icon
        gkCart: gkCart,
        rotation: true,
        dragToCardCurve: Curves.easeIn,
        dragToCardDuration: const Duration(milliseconds: 1000),
        previewCurve: Curves.linearToEaseOut,
        previewDuration: const Duration(milliseconds: 500),
        previewHeight: 30,
        previewWidth: 30,
        opacity: 0.85,
        initiaJump: false,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
          this.runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Obx(() => posController.isLoading.value == true
                  ? Container(
                      width: Get.width,
                      height: 90,
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
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 40.0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: InkWell(
                                  onTap: () {
                                    if(posController.isLoading.value != true){
                                    widget.zoomDrawerController.toggle!();}
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Icon(
                                        Icons.menu_outlined,
                                        color: Color(0xFF002e80),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  height: 40,
                                  width: Get.width / 1.6,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 0.0),
                                    child: TextField(
                                      controller: search,
                                      onChanged: (value) {
                                        filterSearchResults(value);
                                      },
                                      style:
                                          TextStyle(color: Color(0xFF002e80)),
                                      decoration: InputDecoration(
                                          isDense: false,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF002e80)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          prefixIconConstraints: BoxConstraints(
                                            minWidth: 15,
                                            minHeight: 25,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          suffixIcon: search.text == ''
                                              ? Visibility(
                                                  child: Text(''),
                                                  visible: false,
                                                )
                                              : InkWell(
                                                  child: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Color(0xFF002e80),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      search.clear();
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());

                                                      posController.itemsPro
                                                          .clear();
                                                      posController
                                                          .itemsProSearcgh
                                                          .clear();
                                                      posController.itemsPro
                                                          .addAll(posController
                                                              .products);

                                                      //  posController.itemsPro.addAll(posController.products);
                                                    });
                                                  }),
                                          hintText: S.of(context).search,
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          )),
                                    ),
                                  ),
                                )),
                            Obx(
                              () => posController.scanIs == false
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => QRViewExample(
                                                resultcode: (result) {
                                                  /*    String decoded =utf8.decode(base64.decode(result));

//print_r($decoded)
//raw data
//\u0001\u0006Rafeeq\u0002\t123456789\u0003\u00142021-07-12T14:25:09Z\u0004\u0003786\u0005\u000225

                                        String currentavatar = decoded.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
                                          return '"${match.group(0)}"';
                                        });


                                        print(currentavatar);*/

                                                  posController
                                                      .getProductByCode(result);
                                                },
                                              ));
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Icon(
                                              Icons.qr_code_scanner_sharp,
                                              color: Color(0xFF002e80),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ))
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: InkWell(
                                        onTap: () {
                                          posController.scanIs.value = false;

                                          posController.itemsProScan.clear();
                                          search.clear();
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());

                                          posController.itemsPro.clear();
                                          posController.itemsProSearcgh.clear();
                                          posController.itemsPro
                                              .addAll(posController.products);
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              color: Color(0xFF002e80),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      )),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: Get.width,
                      height: 140,
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
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 40.0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: InkWell(
                                  onTap: () {
                                    widget.zoomDrawerController.toggle!();
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Icon(
                                        Icons.menu_outlined,
                                        color: Color(0xFF002e80),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  height: 40,
                                  width: Get.width / 1.6,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 0.0),
                                    child: IntrinsicWidth(
                                        child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: search,
                                      onChanged: (value) {
                                        filterSearchResults(value);
                                      },
                                      style:
                                          TextStyle(color: Color(0xFF002e80)),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          labelStyle: TextStyle(
                                              color: Color(0xFF002e80)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          prefixIconConstraints: BoxConstraints(
                                            minWidth: 15,
                                            minHeight: 15,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          suffixIcon: search.text == ''
                                              ? Visibility(
                                                  child: Text(''),
                                                  visible: false,
                                                )
                                              : InkWell(
                                                  child: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Color(0xFF002e80),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      search.clear();
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());

                                                      posController.itemsPro
                                                          .clear();
                                                      posController
                                                          .itemsProSearcgh
                                                          .clear();
                                                      posController.itemsPro
                                                          .addAll(posController
                                                              .products);

                                                      //  posController.itemsPro.addAll(posController.products);
                                                    });
                                                  }),
                                          hintText: S.of(context).search,
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          )),
                                    )),
                                  ),
                                )),
                            Obx(
                              () => posController.scanIs == false
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => QRViewExample(
                                                resultcode: (result) {
                                                  /*    String decoded =utf8.decode(base64.decode(result));

//print_r($decoded)
//raw data
//\u0001\u0006Rafeeq\u0002\t123456789\u0003\u00142021-07-12T14:25:09Z\u0004\u0003786\u0005\u000225

                                        String currentavatar = decoded.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
                                          return '"${match.group(0)}"';
                                        });


                                        print(currentavatar);*/

                                                  posController
                                                      .getProductByCode(result);
                                                },
                                              ));
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Icon(
                                              Icons.qr_code_scanner_sharp,
                                              color: Color(0xFF002e80),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ))
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: InkWell(
                                        onTap: () {
                                          posController.scanIs.value = false;

                                          posController.itemsProScan.clear();
                                          search.clear();
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());

                                          posController.itemsPro.clear();
                                          posController.itemsProSearcgh.clear();
                                          posController.itemsPro
                                              .addAll(posController.products);
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              color: Color(0xFF002e80),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      )),
                            )
                          ],
                        ),
                      ),
                    )),
              Obx(() => posController.isLoading.value == true
                  ? Center(
                      child: Lottie.asset('assets/images/loading.json',
                          width: 90, height: 90),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 90.0, bottom: 80),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: WaterDropHeader(),
                            footer: CustomFooter(
                              builder: (context, mode) {
                                Widget body;
                                if (mode == LoadStatus.idle) {
                                  body = Text("");
                                } else if (mode == LoadStatus.loading) {
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
                            controller: refreshControllerPos,
                            onRefresh: onRefresh,
                            onLoading: onLoading,
                            child: ListView(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(25),
                                                topLeft: Radius.circular(25)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2,
                                                  spreadRadius: 0)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 15, 0.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.of(context).Categories,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 0.0),
                                                    child: Container(
                                                      width: Get.width / 4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0.0),
                                                        child: Center(
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                                  child: DropdownButton<
                                                                      CategoryModelList>(
                                                            value: posController
                                                                .mainItem,
                                                            isDense: true,
                                                            onChanged:
                                                                (CategoryModelList?
                                                                    val) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());

                                                              setState(() {
                                                                posController
                                                                        .mainItem =
                                                                    val;
                                                                posController
                                                                        .subItemo =
                                                                    null;
                                                                if (posController
                                                                        .mainItem
                                                                        .id ==
                                                                    '0') {
                                                                  posController
                                                                      .pagePos = 1;
                                                                  posController
                                                                      .getProductAllCAtegory();
                                                                } else {
                                                                  posController
                                                                      .pagePos = 1;

                                                                  posController.getProduct(
                                                                      posController
                                                                          .mainItem!
                                                                          .code);
                                                                }
                                                              });
                                                            },
                                                            items: posController
                                                                .CategoryL.value
                                                                .map(
                                                                    (final value) {
                                                              return DropdownMenuItem<
                                                                  CategoryModelList>(
                                                                value: value,
                                                                child: new Text(
                                                                    value.name,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          11,
                                                                    )),
                                                              );
                                                            }).toList(),
                                                            isExpanded: true,
                                                            iconEnabledColor:
                                                                Color(
                                                                    0xFF002e80),
                                                            hint: Text(
                                                              S
                                                                  .of(context)
                                                                  .allcat,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        3, 0, 3, 0.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 1,
                                                  color: Color(0xFF002e80),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.of(context).sub,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 0.0),
                                                    child: Container(
                                                      width: Get.width / 4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0.0),
                                                        child: Center(
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                                  child: DropdownButton<
                                                                      CategoryModelList>(
                                                            isDense: true,
                                                            value: posController
                                                                .subItemo,
                                                            onChanged:
                                                                (CategoryModelList?
                                                                    val) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());

                                                              setState(() {
                                                                posController
                                                                        .subItemo =
                                                                    val;
                                                              });

                                                              if (posController
                                                                      .subItemo!
                                                                      .id ==
                                                                  '0') {
                                                                if (posController
                                                                        .mainItem
                                                                        .id ==
                                                                    '0') {
                                                                  posController
                                                                      .pagePos = 1;

                                                                  posController
                                                                      .getProductAllCAtegoryMain();
                                                                } else {
                                                                  posController
                                                                      .pagePos = 1;

                                                                  posController.getProductMain(
                                                                      posController
                                                                          .mainItem!
                                                                          .code);
                                                                }
                                                              } else {
                                                                posController
                                                                    .pagePos = 1;

                                                                posController.getProductBySubCategory(
                                                                    posController
                                                                        .subItemo!
                                                                        .code);
                                                              }
                                                            },
                                                            items: posController
                                                                .SubCategoryL
                                                                .value
                                                                .map(
                                                                    (final value) {
                                                              return DropdownMenuItem<
                                                                  CategoryModelList>(
                                                                value: value,
                                                                child: new Text(
                                                                    value.name,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          9,
                                                                    )),
                                                              );
                                                            }).toList(),
                                                            isExpanded: true,
                                                            iconEnabledColor:
                                                                Color(
                                                                    0xFF002e80),
                                                            hint: Text(
                                                              S.of(context).sub,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 40,
                                                width: 1,
                                                color: Color(0xFF002e80),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.of(context).Brands,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF002e80),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 0.0),
                                                    child: Container(
                                                      width: Get.width / 4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0.0),
                                                        child: Center(
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                                  child: DropdownButton<
                                                                      BrandModelList>(
                                                            isDense: true,
                                                            value: posController
                                                                .brandItem,
                                                            onChanged:
                                                                (BrandModelList?
                                                                    val) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());
                                                              posController
                                                                      .subItemo =
                                                                  null;

                                                              setState(() {
                                                                posController
                                                                        .brandItem =
                                                                    val;
                                                              });
                                                              if (posController
                                                                      .brandItem
                                                                      .id ==
                                                                  '0') {
                                                                posController
                                                                    .pagePos = 1;

                                                                posController
                                                                    .getProductAllBrand();
                                                              } else {
                                                                posController
                                                                    .pagePos = 1;

                                                                posController.getProductByBrand(
                                                                    posController
                                                                        .brandItem!
                                                                        .code);
                                                              }
                                                            },
                                                            items: posController
                                                                .brandL.value
                                                                .map(
                                                                    (final value) {
                                                              return DropdownMenuItem<
                                                                  BrandModelList>(
                                                                value: value,
                                                                child: new Text(
                                                                    value.name,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          11,
                                                                    )),
                                                              );
                                                            }).toList(),
                                                            isExpanded: true,
                                                            iconEnabledColor:
                                                                Color(
                                                                    0xFF002e80),
                                                            hint: Text(
                                                              S
                                                                  .of(context)
                                                                  .Brands,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      posController.isLoadingPro.value == true
                                          ? Center(
                                              child: Lottie.asset(
                                                  'assets/images/loading.json',
                                                  width: 90,
                                                  height: 90),
                                            )
                                          : search.text == ''
                                              ? posController.itemsProScan
                                                          .length ==
                                                      0
                                                  ? posController.itemsPro.value
                                                              .length ==
                                                          0
                                                      ? posController
                                                                  .stat.value ==
                                                              'false'
                                                          ? Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              30,
                                                                              50,
                                                                              30,
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        child: Padding(
                                                                            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                                            child: TextField(
                                                                              controller: cash,
                                                                              keyboardType: TextInputType.number,
                                                                              style: TextStyle(color: Color(0xFF002e80)),
                                                                              decoration: InputDecoration(
                                                                                  contentPadding: EdgeInsets.all(15),
                                                                                  labelStyle: TextStyle(color: Color(0xFF002e80)),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(
                                                                                      color: Colors.transparent,
                                                                                    ),
                                                                                  ),
                                                                                  enabledBorder: new UnderlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.transparent),
                                                                                  ),
// and:
                                                                                  errorStyle: TextStyle(color: Colors.red),
                                                                                  prefixIcon: Icon(
                                                                                    Icons.lock_outline,
                                                                                    color: Color(0xFF002e80),
                                                                                    size: 18,
                                                                                  ),
                                                                                  hintText: S.of(context).cashh,
                                                                                  hintStyle: TextStyle(
                                                                                    color: Color(0xFF002e80),
                                                                                  )),
                                                                            )),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Color(0xFF002e80), blurRadius: 2, spreadRadius: 0)
                                                                            ]),
                                                                      )),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  /* load == false
                                      ? */

                                                                  Obx(() => posController
                                                                              .isLoadingReg
                                                                              .value ==
                                                                          true
                                                                      ? Lottie.asset(
                                                                          'assets/images/loading.json',
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              90)
                                                                      : InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            if (cash.text == null ||
                                                                                cash.text == '' ||
                                                                                cash.text == 'null') {
                                                                              Get.snackbar(S.of(context).Error, S.of(context).pleasecash, backgroundColor: Colors.grey.withOpacity(0.6));
                                                                            } else {
                                                                              final prefs = await SharedPreferences.getInstance();

                                                                              String? token = prefs.getString('token');
                                                                              dio.FormData data = new dio.FormData.fromMap({
                                                                                "token": token,
                                                                                "cash_in_hand": cash.text,
                                                                              });
                                                                              posController.openRegister(data, context);
                                                                            }
                                                                          },
                                                                          child: Padding(
                                                                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                                                              child: Container(
                                                                                width: Get.width,
                                                                                child: Padding(
                                                                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                                                                    child: Text(
                                                                                      S.of(context).openre,
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                                                                                    )),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  gradient: LinearGradient(colors: [
                                                                                    Color(0xFF002e80).withOpacity(0.4),
                                                                                    Color(0xFF002e80).withOpacity(0.7),
                                                                                    Color(0xFF002e80)
                                                                                  ]),
                                                                                ),
                                                                              )),
                                                                        ))
                                                                  /*    : Lottie.asset('assets/images/loading.json',
                                      width: 90, height: 90),*/
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              width: Get.width,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        50,
                                                                        10,
                                                                        8.0),
                                                                child: Center(
                                                                  child: Lottie.asset(
                                                                      'assets/images/nodata.json',
                                                                      height:
                                                                          250,
                                                                      width:
                                                                          250),
                                                                ),
                                                              ),
                                                            )
                                                      : Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10, 0,
                                                                  10, 10),
                                                          child:
                                                              GridView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                posController
                                                                    .itemsPro
                                                                    .value
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                key: posController
                                                                    .itemsPro
                                                                    .value[
                                                                        index]
                                                                    .imageGlobalKey,
                                                                child: InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      listClick(posController
                                                                          .itemsPro
                                                                          .value[
                                                                              index]
                                                                          .imageGlobalKey);
                                                                      Get.dialog(
                                                                        Center(
                                                                          child: Lottie.asset(
                                                                              'assets/images/loading.json',
                                                                              width: 90,
                                                                              height: 90),
                                                                        ),
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        found =
                                                                            false;
                                                                      });
                                                                      final SharedPreferences
                                                                          sharedPrefs =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      setState(
                                                                          () {
                                                                        quantity =
                                                                            quantity +
                                                                                1;
                                                                      });
                                                                      posController
                                                                          .itemsPro
                                                                          .value[
                                                                              index]
                                                                          .quantity = posController
                                                                              .itemsPro
                                                                              .value[index]
                                                                              .quantity +
                                                                          1;
                                                                      if (posController
                                                                              .itemsPro
                                                                              .value[index]
                                                                              .tax_method
                                                                              .toString() !=
                                                                          'exclusive') {
                                                                        total =
                                                                            [
                                                                          double.parse(
                                                                              total.toString()),
                                                                          double.parse(posController
                                                                              .itemsPro
                                                                              .value[index]
                                                                              .unit_price)
                                                                        ].reduce((a, b) =>
                                                                                a +
                                                                                b);
                                                                        print(total
                                                                            .toStringAsFixed(2));
                                                                      } else {
                                                                        if (posController.itemsPro.value[index].texes.type.toString() ==
                                                                            'percentage') {
                                                                          total =
                                                                              [
                                                                            double.parse(total.toString()),
                                                                            double.parse(posController.itemsPro.value[index].unit_price)
                                                                          ].reduce((a, b) => a + b);
                                                                          print(
                                                                              total.toStringAsFixed(2));

                                                                          /*  total = (double.parse(total.toString()) +
                                                                double.parse(
                                                                    posController
                                                                        .itemsPro
                                                                        .value[index].unit_price))
                                                            ;*/

                                                                          /* total = (double.parse(
                                                        total.toString()) +
                                                                ((double.parse(posController
                                                                    .itemsPro
                                                                    .value[index]
                                                                    .price) + ( (double.parse(posController
                                                                    .itemsPro
                                                                    .value[index]
                                                                    .price) *
                                                                    double.parse(posController
                                                                        .itemsPro
                                                                        .value[index]
                                                                        .texes
                                                                        .rate)) /
                                                                    100))))
                                                      ;*/

                                                                        } else {
                                                                          total =
                                                                              [
                                                                            double.parse(total.toString()),
                                                                            double.parse(posController.itemsPro.value[index].unit_price)
                                                                          ].reduce((a, b) => a + b);
                                                                          print(
                                                                              total.toStringAsFixed(2));

                                                                          /*    total =
                                                                (double.parse(total.toString()) +
                                                                    (double.parse(
                                                                        posController
                                                                            .itemsPro
                                                                            .value[index]
                                                                            .price) +
                                                                        double.parse(posController
                                                                            .itemsPro
                                                                            .value[index]
                                                                            .texes
                                                                            .rate)))
                                                                    ;*/

                                                                        }
                                                                      }
                                                                      String?
                                                                          orderL =
                                                                          sharedPrefs
                                                                              .getString('lastpro');
                                                                      if (orderL !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          alarmLpro = (json.decode(orderL) as List<dynamic>)
                                                                              .map<ProductModdelList>((item) => ProductModdelList.fromJson(item))
                                                                              .toList();
                                                                        });
                                                                        for (int i =
                                                                                0;
                                                                            i < alarmLpro.length;
                                                                            i++) {
                                                                          if (alarmLpro[i].id.toString() ==
                                                                              posController.itemsPro.value[index].id.toString()) {
                                                                            alarmLpro[i].quantity =
                                                                                alarmLpro[i].quantity + 1;
                                                                            found =
                                                                                true;
                                                                            break;
                                                                          }
                                                                        }
                                                                        if (found ==
                                                                            false) {
                                                                          alarmLpro.add(posController
                                                                              .itemsPro
                                                                              .value[index]);
                                                                          found =
                                                                              false;
                                                                        }
                                                                      } else {
                                                                        alarmLpro
                                                                            .clear();
                                                                        for (int i =
                                                                                0;
                                                                            i < posController.itemsPro.value.length;
                                                                            i++) {
                                                                          if (posController.itemsPro.value[i].quantity >
                                                                              0) {
                                                                            alarmLpro.add(posController.itemsPro.value[i]);
                                                                          }
                                                                        }
                                                                      }
                                                                      sharedPrefs
                                                                          .remove(
                                                                              'lastpro');
                                                                      String
                                                                          lastpro =
                                                                          json.encode(
                                                                        alarmLpro
                                                                            .map<Map<String, dynamic>>((music) =>
                                                                                ProductModdelList.toMavp(music))
                                                                            .toList(),
                                                                      );

                                                                      sharedPrefs.setString(
                                                                          'lastpro',
                                                                          lastpro);
                                                                      allPro
                                                                          .listStorePro
                                                                          .clear();
                                                                      allPro = ProStore(
                                                                          listStorePro: <
                                                                              ProductModdelList>[]);

                                                                      for (int y =
                                                                              0;
                                                                          y < alarmLpro.length;
                                                                          y++) {
                                                                        allPro
                                                                            .listStorePro
                                                                            .add(alarmLpro[y]);
                                                                      }
                                                                      alarmLiAdd
                                                                          .clear();
                                                                      alarmLiAdd.add(CartMode(
                                                                          prList:
                                                                              allPro,
                                                                          quan:
                                                                              quantity,
                                                                          total:
                                                                              total));

                                                                      String
                                                                          fgfh =
                                                                          json.encode(
                                                                        alarmLiAdd
                                                                            .map<Map<String, dynamic>>((music) =>
                                                                                CartMode.toMap(music))
                                                                            .toList(),
                                                                      );

                                                                      sharedPrefs.setString(
                                                                          'cartOrder',
                                                                          fgfh);

                                                                      /*      showMaterialModalBottomSheet(
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
                                                                    posController
                                                                        .itemsPro
                                                                        .value[index],
                                                                pri: total
                                                                    .toString(),
                                                                totalq: quantity
                                                                    .toString(),
                                                                proSelect:
                                                                    (result) {
                                                                  setState(() {
                                                                    proSelect.add(
                                                                        result);
                                                                  });
                                                                },
                                                                quantiti: (res) {
                                                                  setState(() {
                                                                    quantity =
                                                                        res;
                                                                  });
                                                                },
                                                                total: (res) {
                                                                  setState(() {
                                                                    total = res;
                                                                  });
                                                                },


                                                              ));*/
                                                                      print(
                                                                          'hgfd');
                                                                      Get.back();
                                                                    },
                                                                    child: ProductCard(posController
                                                                        .itemsPro
                                                                        .value[index])),
                                                              );
                                                            },
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisSpacing:
                                                                  5.0,
                                                              childAspectRatio:
                                                                  (itemWidth /
                                                                      itemHeight),
                                                              crossAxisSpacing:
                                                                  5.0,
                                                            ),
                                                          ),
                                                        )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 10),
                                                      child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: posController
                                                            .itemsProScan
                                                            .value
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Container(
                                                              key: posController
                                                                  .itemsProScan
                                                                  .value[index]
                                                                  .imageGlobalKey,
                                                              child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    listClick(posController
                                                                        .itemsProScan
                                                                        .value[
                                                                            index]
                                                                        .imageGlobalKey);
                                                                    Get.dialog(
                                                                      Center(
                                                                        child: Lottie.asset(
                                                                            'assets/images/loading.json',
                                                                            width:
                                                                                90,
                                                                            height:
                                                                                90),
                                                                      ),
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      found =
                                                                          false;
                                                                    });
                                                                    final SharedPreferences
                                                                        sharedPrefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    setState(
                                                                        () {
                                                                      quantity =
                                                                          quantity +
                                                                              1;
                                                                    });
                                                                    for (int u =
                                                                            0;
                                                                        u < posController.itemsPro.length;
                                                                        u++) {
                                                                      if (posController
                                                                              .itemsPro[
                                                                                  u]
                                                                              .id
                                                                              .toString() ==
                                                                          posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .id
                                                                              .toString()) {
                                                                        posController
                                                                            .itemsPro
                                                                            .value[
                                                                                u]
                                                                            .quantity = posController
                                                                                .itemsPro.value[u].quantity +
                                                                            1;
                                                                      }
                                                                    }
                                                                    posController
                                                                        .itemsProScan
                                                                        .value[
                                                                            index]
                                                                        .quantity = posController
                                                                            .itemsProScan
                                                                            .value[index]
                                                                            .quantity +
                                                                        1;
                                                                    if (posController
                                                                            .itemsProScan
                                                                            .value[index]
                                                                            .tax_method
                                                                            .toString() !=
                                                                        'exclusive') {
                                                                      total = [
                                                                        double.parse(
                                                                            total.toString()),
                                                                        double.parse(posController
                                                                            .itemsProScan
                                                                            .value[index]
                                                                            .unit_price)
                                                                      ].reduce(
                                                                          (a, b) =>
                                                                              a +
                                                                              b);
                                                                      print(total
                                                                          .toStringAsFixed(
                                                                              2));
                                                                    } else {
                                                                      if (posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .texes
                                                                              .type
                                                                              .toString() ==
                                                                          'percentage') {
                                                                        total =
                                                                            [
                                                                          double.parse(
                                                                              total.toString()),
                                                                          double.parse(posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .unit_price)
                                                                        ].reduce((a, b) =>
                                                                                a +
                                                                                b);
                                                                        print(total
                                                                            .toStringAsFixed(2));

                                                                        /*  total = (double.parse(total.toString()) +
                                                              double.parse(
                                                                  posController
                                                                      .itemsProScan
                                                                      .value[index].unit_price))
                                                          ;*/

                                                                        /* total = (double.parse(
                                                        total.toString()) +
                                                              ((double.parse(posController
                                                                  .itemsProScan
                                                                  .value[index]
                                                                  .price) + ( (double.parse(posController
                                                                  .itemsProScan
                                                                  .value[index]
                                                                  .price) *
                                                                  double.parse(posController
                                                                      .itemsProScan
                                                                      .value[index]
                                                                      .texes
                                                                      .rate)) /
                                                                  100))))
                                                      ;*/

                                                                      } else {
                                                                        total =
                                                                            [
                                                                          double.parse(
                                                                              total.toString()),
                                                                          double.parse(posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .unit_price)
                                                                        ].reduce((a, b) =>
                                                                                a +
                                                                                b);
                                                                        print(total
                                                                            .toStringAsFixed(2));

                                                                        /*    total =
                                                              (double.parse(total.toString()) +
                                                                  (double.parse(
                                                                      posController
                                                                          .itemsProScan
                                                                          .value[index]
                                                                          .price) +
                                                                      double.parse(posController
                                                                          .itemsProScan
                                                                          .value[index]
                                                                          .texes
                                                                          .rate)))
                                                                  ;*/

                                                                      }
                                                                    }
                                                                    String?
                                                                        orderL =
                                                                        sharedPrefs
                                                                            .getString('lastpro');
                                                                    if (orderL !=
                                                                        null) {
                                                                      setState(
                                                                          () {
                                                                        alarmLpro = (json.decode(orderL)
                                                                                as List<dynamic>)
                                                                            .map<ProductModdelList>((item) => ProductModdelList.fromJson(item))
                                                                            .toList();
                                                                      });
                                                                      for (int i =
                                                                              0;
                                                                          i < alarmLpro.length;
                                                                          i++) {
                                                                        if (alarmLpro[i].id.toString() ==
                                                                            posController.itemsProScan.value[index].id.toString()) {
                                                                          alarmLpro[i].quantity =
                                                                              alarmLpro[i].quantity + 1;
                                                                          found =
                                                                              true;
                                                                          break;
                                                                        }
                                                                      }
                                                                      if (found ==
                                                                          false) {
                                                                        alarmLpro.add(posController
                                                                            .itemsProScan
                                                                            .value[index]);
                                                                        found =
                                                                            false;
                                                                      }
                                                                    } else {
                                                                      alarmLpro
                                                                          .clear();
                                                                      for (int i =
                                                                              0;
                                                                          i < posController.itemsProScan.value.length;
                                                                          i++) {
                                                                        if (posController.itemsProScan.value[i].quantity >
                                                                            0) {
                                                                          alarmLpro.add(posController
                                                                              .itemsProScan
                                                                              .value[i]);
                                                                        }
                                                                      }
                                                                    }
                                                                    sharedPrefs
                                                                        .remove(
                                                                            'lastpro');
                                                                    String
                                                                        lastpro =
                                                                        json.encode(
                                                                      alarmLpro
                                                                          .map<Map<String, dynamic>>((music) =>
                                                                              ProductModdelList.toMavp(music))
                                                                          .toList(),
                                                                    );

                                                                    sharedPrefs.setString(
                                                                        'lastpro',
                                                                        lastpro);
                                                                    allPro
                                                                        .listStorePro
                                                                        .clear();
                                                                    allPro = ProStore(
                                                                        listStorePro: <
                                                                            ProductModdelList>[]);

                                                                    for (int y =
                                                                            0;
                                                                        y < alarmLpro.length;
                                                                        y++) {
                                                                      allPro
                                                                          .listStorePro
                                                                          .add(alarmLpro[
                                                                              y]);
                                                                    }
                                                                    alarmLiAdd
                                                                        .clear();
                                                                    alarmLiAdd.add(CartMode(
                                                                        prList:
                                                                            allPro,
                                                                        quan:
                                                                            quantity,
                                                                        total:
                                                                            total));

                                                                    String
                                                                        fgfh =
                                                                        json.encode(
                                                                      alarmLiAdd
                                                                          .map<Map<String, dynamic>>((music) =>
                                                                              CartMode.toMap(music))
                                                                          .toList(),
                                                                    );

                                                                    sharedPrefs
                                                                        .setString(
                                                                            'cartOrder',
                                                                            fgfh);

                                                                    print(
                                                                        'hgfd');
                                                                    Get.back();
                                                                  },
                                                                  child: ProductCard(
                                                                      posController
                                                                          .itemsProScan
                                                                          .value[index])));
                                                        },
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisSpacing: 5.0,
                                                          childAspectRatio:
                                                              (itemWidth /
                                                                  itemHeight),
                                                          crossAxisSpacing: 5.0,
                                                        ),
                                                      ),
                                                    )
                                              : posController.itemsProScan
                                                          .length ==
                                                      0
                                                  ? posController
                                                              .itemsProSearcgh
                                                              .value
                                                              .length ==
                                                          0
                                                      ? posController
                                                                  .stat.value ==
                                                              'false'
                                                          ? Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              30,
                                                                              50,
                                                                              30,
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        child: Padding(
                                                                            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                                            child: TextField(
                                                                              controller: cash,
                                                                              keyboardType: TextInputType.number,
                                                                              style: TextStyle(color: Color(0xFF002e80)),
                                                                              decoration: InputDecoration(
                                                                                  contentPadding: EdgeInsets.all(15),
                                                                                  labelStyle: TextStyle(color: Color(0xFF002e80)),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(
                                                                                      color: Colors.transparent,
                                                                                    ),
                                                                                  ),
                                                                                  enabledBorder: new UnderlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.transparent),
                                                                                  ),
// and:
                                                                                  errorStyle: TextStyle(color: Colors.red),
                                                                                  prefixIcon: Icon(
                                                                                    Icons.lock_outline,
                                                                                    color: Color(0xFF002e80),
                                                                                    size: 18,
                                                                                  ),
                                                                                  hintText: S.of(context).cashh,
                                                                                  hintStyle: TextStyle(
                                                                                    color: Color(0xFF002e80),
                                                                                  )),
                                                                            )),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Color(0xFF002e80), blurRadius: 2, spreadRadius: 0)
                                                                            ]),
                                                                      )),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  /* load == false
                                      ? */

                                                                  Obx(() => posController
                                                                              .isLoadingReg
                                                                              .value ==
                                                                          true
                                                                      ? Lottie.asset(
                                                                          'assets/images/loading.json',
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              90)
                                                                      : InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            if (cash.text == null ||
                                                                                cash.text == '' ||
                                                                                cash.text == 'null') {
                                                                              Get.snackbar(S.of(context).Error, S.of(context).pleasecash, backgroundColor: Colors.grey.withOpacity(0.6));
                                                                            } else {
                                                                              final prefs = await SharedPreferences.getInstance();

                                                                              String? token = prefs.getString('token');
                                                                              dio.FormData data = new dio.FormData.fromMap({
                                                                                "token": token,
                                                                                "cash_in_hand": cash.text,
                                                                              });
                                                                              posController.openRegister(data, context);
                                                                            }
                                                                          },
                                                                          child: Padding(
                                                                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                                                              child: Container(
                                                                                width: Get.width,
                                                                                child: Padding(
                                                                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                                                                    child: Text(
                                                                                      S.of(context).openre,
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                                                                                    )),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  gradient: LinearGradient(colors: [
                                                                                    Color(0xFF002e80).withOpacity(0.4),
                                                                                    Color(0xFF002e80).withOpacity(0.7),
                                                                                    Color(0xFF002e80)
                                                                                  ]),
                                                                                ),
                                                                              )),
                                                                        ))
                                                                  /*    : Lottie.asset('assets/images/loading.json',
                                      width: 90, height: 90),*/
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              width: Get.width,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        50,
                                                                        10,
                                                                        8.0),
                                                                child: Center(
                                                                  child: Lottie.asset(
                                                                      'assets/images/nodata.json',
                                                                      height:
                                                                          250,
                                                                      width:
                                                                          250),
                                                                ),
                                                              ),
                                                            )
                                                      : Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10, 0,
                                                                  10, 10),
                                                          child:
                                                              GridView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount: posController
                                                                .itemsProSearcgh
                                                                .value
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                  key: posController
                                                                      .itemsProSearcgh
                                                                      .value[
                                                                          index]
                                                                      .imageGlobalKey,
                                                                  child:
                                                                      InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            listClick(posController.itemsProSearcgh.value[index].imageGlobalKey);
                                                                            Get.dialog(
                                                                              Center(
                                                                                child: Lottie.asset('assets/images/loading.json', width: 90, height: 90),
                                                                              ),
                                                                            );
                                                                            setState(() {
                                                                              found = false;
                                                                            });
                                                                            final SharedPreferences
                                                                                sharedPrefs =
                                                                                await SharedPreferences.getInstance();
                                                                            setState(() {
                                                                              quantity = quantity + 1;
                                                                            });
                                                                            posController.itemsProSearcgh.value[index].quantity =
                                                                                posController.itemsProSearcgh.value[index].quantity + 1;
                                                                            if (posController.itemsProSearcgh.value[index].tax_method.toString() !=
                                                                                'exclusive') {
                                                                              total = [
                                                                                double.parse(total.toString()),
                                                                                double.parse(posController.itemsProSearcgh.value[index].unit_price)
                                                                              ].reduce((a, b) => a + b);
                                                                              print(total.toStringAsFixed(2));
                                                                            } else {
                                                                              if (posController.itemsProSearcgh.value[index].texes.type.toString() == 'percentage') {
                                                                                total = [
                                                                                  double.parse(total.toString()),
                                                                                  double.parse(posController.itemsProSearcgh.value[index].unit_price)
                                                                                ].reduce((a, b) => a + b);
                                                                                print(total.toStringAsFixed(2));

                                                                                /*  total = (double.parse(total.toString()) +
                                                              double.parse(
                                                                  posController
                                                                      .itemsProSearcgh
                                                                      .value[index].unit_price))
                                                          ;*/

                                                                                /* total = (double.parse(
                                                        total.toString()) +
                                                              ((double.parse(posController
                                                                  .itemsProSearcgh
                                                                  .value[index]
                                                                  .price) + ( (double.parse(posController
                                                                  .itemsProSearcgh
                                                                  .value[index]
                                                                  .price) *
                                                                  double.parse(posController
                                                                      .itemsProSearcgh
                                                                      .value[index]
                                                                      .texes
                                                                      .rate)) /
                                                                  100))))
                                                      ;*/

                                                                              } else {
                                                                                total = [
                                                                                  double.parse(total.toString()),
                                                                                  double.parse(posController.itemsProSearcgh.value[index].unit_price)
                                                                                ].reduce((a, b) => a + b);
                                                                                print(total.toStringAsFixed(2));

                                                                                /*    total =
                                                              (double.parse(total.toString()) +
                                                                  (double.parse(
                                                                      posController
                                                                          .itemsProSearcgh
                                                                          .value[index]
                                                                          .price) +
                                                                      double.parse(posController
                                                                          .itemsProSearcgh
                                                                          .value[index]
                                                                          .texes
                                                                          .rate)))
                                                                  ;*/

                                                                              }
                                                                            }
                                                                            String?
                                                                                orderL =
                                                                                sharedPrefs.getString('lastpro');
                                                                            if (orderL !=
                                                                                null) {
                                                                              setState(() {
                                                                                alarmLpro = (json.decode(orderL) as List<dynamic>).map<ProductModdelList>((item) => ProductModdelList.fromJson(item)).toList();
                                                                              });
                                                                              for (int i = 0; i < alarmLpro.length; i++) {
                                                                                if (alarmLpro[i].id.toString() == posController.itemsProSearcgh.value[index].id.toString()) {
                                                                                  alarmLpro[i].quantity = alarmLpro[i].quantity + 1;
                                                                                  found = true;
                                                                                  break;
                                                                                }
                                                                              }
                                                                              if (found == false) {
                                                                                alarmLpro.add(posController.itemsProSearcgh.value[index]);
                                                                                found = false;
                                                                              }
                                                                            } else {
                                                                              alarmLpro.clear();
                                                                              for (int i = 0; i < posController.itemsProSearcgh.value.length; i++) {
                                                                                if (posController.itemsProSearcgh.value[i].quantity > 0) {
                                                                                  alarmLpro.add(posController.itemsProSearcgh.value[i]);
                                                                                }
                                                                              }
                                                                            }
                                                                            sharedPrefs.remove('lastpro');
                                                                            String
                                                                                lastpro =
                                                                                json.encode(
                                                                              alarmLpro.map<Map<String, dynamic>>((music) => ProductModdelList.toMavp(music)).toList(),
                                                                            );

                                                                            sharedPrefs.setString('lastpro',
                                                                                lastpro);
                                                                            allPro.listStorePro.clear();
                                                                            allPro =
                                                                                ProStore(listStorePro: <ProductModdelList>[]);

                                                                            for (int y = 0;
                                                                                y < alarmLpro.length;
                                                                                y++) {
                                                                              allPro.listStorePro.add(alarmLpro[y]);
                                                                            }
                                                                            alarmLiAdd.clear();
                                                                            alarmLiAdd.add(CartMode(
                                                                                prList: allPro,
                                                                                quan: quantity,
                                                                                total: total));

                                                                            String
                                                                                fgfh =
                                                                                json.encode(
                                                                              alarmLiAdd.map<Map<String, dynamic>>((music) => CartMode.toMap(music)).toList(),
                                                                            );

                                                                            sharedPrefs.setString('cartOrder',
                                                                                fgfh);

                                                                            /*      showMaterialModalBottomSheet(
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
                                                                  posController
                                                                      .itemsProSearcgh
                                                                      .value[index],
                                                              pri: total
                                                                  .toString(),
                                                              totalq: quantity
                                                                  .toString(),
                                                              proSelect:
                                                                  (result) {
                                                                setState(() {
                                                                  proSelect.add(
                                                                      result);
                                                                });
                                                              },
                                                              quantiti: (res) {
                                                                setState(() {
                                                                  quantity =
                                                                      res;
                                                                });
                                                              },
                                                              total: (res) {
                                                                setState(() {
                                                                  total = res;
                                                                });
                                                              },


                                                            ));*/
                                                                            print('hgfd');
                                                                            Get.back();
                                                                          },
                                                                          child: ProductCard(posController
                                                                              .itemsProSearcgh
                                                                              .value[index])));
                                                            },
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisSpacing:
                                                                  5.0,
                                                              childAspectRatio:
                                                                  (itemWidth /
                                                                      itemHeight),
                                                              crossAxisSpacing:
                                                                  5.0,
                                                            ),
                                                          ),
                                                        )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 10),
                                                      child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: posController
                                                            .itemsProScan
                                                            .value
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Container(
                                                              key: posController
                                                                  .itemsProScan
                                                                  .value[index]
                                                                  .imageGlobalKey,
                                                              child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    listClick(posController
                                                                        .itemsProScan
                                                                        .value[
                                                                            index]
                                                                        .imageGlobalKey);
                                                                    Get.dialog(
                                                                      Center(
                                                                        child: Lottie.asset(
                                                                            'assets/images/loading.json',
                                                                            width:
                                                                                90,
                                                                            height:
                                                                                90),
                                                                      ),
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      found =
                                                                          false;
                                                                    });
                                                                    final SharedPreferences
                                                                        sharedPrefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    setState(
                                                                        () {
                                                                      quantity =
                                                                          quantity +
                                                                              1;
                                                                    });
                                                                    for (int u =
                                                                            0;
                                                                        u < posController.itemsPro.length;
                                                                        u++) {
                                                                      if (posController
                                                                              .itemsPro[
                                                                                  u]
                                                                              .id
                                                                              .toString() ==
                                                                          posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .id
                                                                              .toString()) {
                                                                        posController
                                                                            .itemsPro
                                                                            .value[
                                                                                u]
                                                                            .quantity = posController
                                                                                .itemsPro.value[u].quantity +
                                                                            1;
                                                                      }
                                                                    }
                                                                    posController
                                                                        .itemsProScan
                                                                        .value[
                                                                            index]
                                                                        .quantity = posController
                                                                            .itemsProScan
                                                                            .value[index]
                                                                            .quantity +
                                                                        1;
                                                                    if (posController
                                                                            .itemsProScan
                                                                            .value[index]
                                                                            .tax_method
                                                                            .toString() !=
                                                                        'exclusive') {
                                                                      total = [
                                                                        double.parse(
                                                                            total.toString()),
                                                                        double.parse(posController
                                                                            .itemsProScan
                                                                            .value[index]
                                                                            .unit_price)
                                                                      ].reduce(
                                                                          (a, b) =>
                                                                              a +
                                                                              b);
                                                                      print(total
                                                                          .toStringAsFixed(
                                                                              2));
                                                                    } else {
                                                                      if (posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .texes
                                                                              .type
                                                                              .toString() ==
                                                                          'percentage') {
                                                                        total =
                                                                            [
                                                                          double.parse(
                                                                              total.toString()),
                                                                          double.parse(posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .unit_price)
                                                                        ].reduce((a, b) =>
                                                                                a +
                                                                                b);
                                                                        print(total
                                                                            .toStringAsFixed(2));

                                                                        /*  total = (double.parse(total.toString()) +
                                                              double.parse(
                                                                  posController
                                                                      .itemsProScan
                                                                      .value[index].unit_price))
                                                          ;*/

                                                                        /* total = (double.parse(
                                                        total.toString()) +
                                                              ((double.parse(posController
                                                                  .itemsProScan
                                                                  .value[index]
                                                                  .price) + ( (double.parse(posController
                                                                  .itemsProScan
                                                                  .value[index]
                                                                  .price) *
                                                                  double.parse(posController
                                                                      .itemsProScan
                                                                      .value[index]
                                                                      .texes
                                                                      .rate)) /
                                                                  100))))
                                                      ;*/

                                                                      } else {
                                                                        total =
                                                                            [
                                                                          double.parse(
                                                                              total.toString()),
                                                                          double.parse(posController
                                                                              .itemsProScan
                                                                              .value[index]
                                                                              .unit_price)
                                                                        ].reduce((a, b) =>
                                                                                a +
                                                                                b);
                                                                        print(total
                                                                            .toStringAsFixed(2));

                                                                        /*    total =
                                                              (double.parse(total.toString()) +
                                                                  (double.parse(
                                                                      posController
                                                                          .itemsProScan
                                                                          .value[index]
                                                                          .price) +
                                                                      double.parse(posController
                                                                          .itemsProScan
                                                                          .value[index]
                                                                          .texes
                                                                          .rate)))
                                                                  ;*/

                                                                      }
                                                                    }
                                                                    String?
                                                                        orderL =
                                                                        sharedPrefs
                                                                            .getString('lastpro');
                                                                    if (orderL !=
                                                                        null) {
                                                                      setState(
                                                                          () {
                                                                        alarmLpro = (json.decode(orderL)
                                                                                as List<dynamic>)
                                                                            .map<ProductModdelList>((item) => ProductModdelList.fromJson(item))
                                                                            .toList();
                                                                      });
                                                                      for (int i =
                                                                              0;
                                                                          i < alarmLpro.length;
                                                                          i++) {
                                                                        if (alarmLpro[i].id.toString() ==
                                                                            posController.itemsProScan.value[index].id.toString()) {
                                                                          alarmLpro[i].quantity =
                                                                              alarmLpro[i].quantity + 1;
                                                                          found =
                                                                              true;
                                                                          break;
                                                                        }
                                                                      }
                                                                      if (found ==
                                                                          false) {
                                                                        alarmLpro.add(posController
                                                                            .itemsProScan
                                                                            .value[index]);
                                                                        found =
                                                                            false;
                                                                      }
                                                                    } else {
                                                                      alarmLpro
                                                                          .clear();
                                                                      for (int i =
                                                                              0;
                                                                          i < posController.itemsProScan.value.length;
                                                                          i++) {
                                                                        if (posController.itemsProScan.value[i].quantity >
                                                                            0) {
                                                                          alarmLpro.add(posController
                                                                              .itemsProScan
                                                                              .value[i]);
                                                                        }
                                                                      }
                                                                    }
                                                                    sharedPrefs
                                                                        .remove(
                                                                            'lastpro');
                                                                    String
                                                                        lastpro =
                                                                        json.encode(
                                                                      alarmLpro
                                                                          .map<Map<String, dynamic>>((music) =>
                                                                              ProductModdelList.toMavp(music))
                                                                          .toList(),
                                                                    );

                                                                    sharedPrefs.setString(
                                                                        'lastpro',
                                                                        lastpro);
                                                                    allPro
                                                                        .listStorePro
                                                                        .clear();
                                                                    allPro = ProStore(
                                                                        listStorePro: <
                                                                            ProductModdelList>[]);

                                                                    for (int y =
                                                                            0;
                                                                        y < alarmLpro.length;
                                                                        y++) {
                                                                      allPro
                                                                          .listStorePro
                                                                          .add(alarmLpro[
                                                                              y]);
                                                                    }
                                                                    alarmLiAdd
                                                                        .clear();
                                                                    alarmLiAdd.add(CartMode(
                                                                        prList:
                                                                            allPro,
                                                                        quan:
                                                                            quantity,
                                                                        total:
                                                                            total));

                                                                    String
                                                                        fgfh =
                                                                        json.encode(
                                                                      alarmLiAdd
                                                                          .map<Map<String, dynamic>>((music) =>
                                                                              CartMode.toMap(music))
                                                                          .toList(),
                                                                    );

                                                                    sharedPrefs
                                                                        .setString(
                                                                            'cartOrder',
                                                                            fgfh);

                                                                    /*      showMaterialModalBottomSheet(
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
                                                                  posController
                                                                      .itemsProScan
                                                                      .value[index],
                                                              pri: total
                                                                  .toString(),
                                                              totalq: quantity
                                                                  .toString(),
                                                              proSelect:
                                                                  (result) {
                                                                setState(() {
                                                                  proSelect.add(
                                                                      result);
                                                                });
                                                              },
                                                              quantiti: (res) {
                                                                setState(() {
                                                                  quantity =
                                                                      res;
                                                                });
                                                              },
                                                              total: (res) {
                                                                setState(() {
                                                                  total = res;
                                                                });
                                                              },


                                                            ));*/
                                                                    print(
                                                                        'hgfd');
                                                                    Get.back();
                                                                  },
                                                                  child: ProductCard(
                                                                      posController
                                                                          .itemsProScan
                                                                          .value[index])));
                                                        },
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisSpacing: 5.0,
                                                          childAspectRatio:
                                                              (itemWidth /
                                                                  itemHeight),
                                                          crossAxisSpacing: 5.0,
                                                        ),
                                                      ),
                                                    )
                                    ],
                                  ),
                                )
                              ],
                              shrinkWrap: true,
                            )),
                      ),
                    )),
              GestureDetector(
                onTap: () {
                  if (quantity == 0) {
                  } else {
                    print('hgvf');
                    resu = '0';
                    getData().then((value) {
                      FocusScope.of(context).requestFocus(new FocusNode());

                      search.text = '';
                      posController.itemsProScan.clear();
                      posController.itemsProSearcgh.clear();

                      Get.to(() => SaleScreen(
                          proLast: alarmLpro,
                          wareList: posController.WareL.value,
                          customerList: posController.customerL.value,
                          billerList: posController.billerL.value,
                          proSelect: alarmLi,
                          change: (res) {
                            if (res == '1') {
                              resu = '1';

                              getData();
                            } else if (res == '2') {
                              for (int i = 0;
                                  i < posController.itemsPro.length;
                                  i++) {
                                posController.itemsPro[i].select = false;
                                posController.itemsPro[i].quantity = 0;
                              }
                              sharedPrefs!.remove('cartOrder');
                              sharedPrefs!.remove('lastpro');
                              alarmLpro.clear();
                              allPro.listStorePro.clear();
                              alarmLiAdd.clear();
                              proSelect.clear();
                              quantity = 0;
                              total = 0.0;
                              getData();
                            }
                          },
                          langSett: posController.langSet.value,
                          defaultb: posController.defaultB.value,
                          defaultc: posController.defaultC.value,
                          defaulw: posController.defaultW.value));
                    });
                  }
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xFF002e80).withOpacity(0.9),
                              Color(0xFF002e80)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      key: gkCart,
                                      color: Colors.white,
                                    )),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    S.of(context).Items,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                total.toString().split('.')[1].length > 3
                                    ? Text(
                                        total.toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        total.toStringAsFixed(2).toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                Obx(() => Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        posController.currency.value,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,

                                              children: [
                                                  posController.languagee ==
                                                          'en'
                                                      ? Text(
                                                          'Are you sure you want to delete?')
                                                      : Text(
                                                          'هل تريد الحذف بالتأكيد؟',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF005189)),
                                                          textAlign:
                                                              TextAlign.center),
                                                  SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              _cartQuantityItems =
                                                                  0;
                                                              for (int i = 0;
                                                                  i <
                                                                      posController
                                                                          .itemsPro
                                                                          .length;
                                                                  i++) {
                                                                posController
                                                                    .itemsPro[i]
                                                                    .select = false;
                                                                posController
                                                                    .itemsPro[i]
                                                                    .quantity = 0;
                                                              }
                                                              sharedPrefs!.remove(
                                                                  'cartOrder');
                                                              sharedPrefs!
                                                                  .remove(
                                                                      'lastpro');
                                                              alarmLpro.clear();
                                                              allPro
                                                                  .listStorePro
                                                                  .clear();
                                                              alarmLiAdd
                                                                  .clear();
                                                              proSelect.clear();
                                                              quantity = 0;
                                                              total = 0.0;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: posController
                                                                      .languagee ==
                                                                  'en'
                                                              ? Text('Yes')
                                                              : Text('موافق'),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Color(
                                                                      0xFF005189)),
                                                        ),
                                                      ),
                                                      SizedBox(width: 15),
                                                      Expanded(
                                                          child: ElevatedButton(
                                                        onPressed: () {
                                                          print('no selected');
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                            S
                                                                .of(context)
                                                                .Cancel,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.white,
                                                        ),
                                                      ))
                                                    ],
                                                  )
                                                ],
                                              ),

                                          );
                                        });
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  void filterSearchResults(String query) {
    final dummySearchList = [];
    dummySearchList.addAll(posController.products.value);
    if (query.isNotEmpty && query != '') {
      final dummyListData = [];
      if (posController.languagee.value == 'en') {
        dummySearchList.forEach((item) {
          if (item.name
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase())) {
            dummyListData.add(item);
          }
        });
      } else {
        dummySearchList.forEach((item) {
          if (item.second_name
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase())) {
            dummyListData.add(item);
          }
        });
      }

      setState(() {
        posController.itemsProSearcgh.clear();
        posController.itemsProSearcgh.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        posController.itemsPro.clear();
        posController.itemsProSearcgh.clear();
        posController.itemsPro.addAll(posController.products);

        //  posController.itemsPro.addAll(posController.products);
      });
    }
  }

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }
}
