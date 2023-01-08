import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/model/combo_model.dart';
import 'package:icon/model/custom_mode_arabic.dart';
import 'package:icon/model/customer_model.dart';
import 'package:icon/model/produce_model.dart';
import 'package:icon/model/supModelAdd.dart';
import 'package:icon/model/table_combo_model.dart';
import 'package:icon/model/table_combp_edit_model.dart';
import 'package:icon/model/warehouse_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepOneProducEdit extends StatefulWidget {

  @override
  _StepOneProducEdit createState() => _StepOneProducEdit();
}

class _StepOneProducEdit extends State<StepOneProducEdit>
    with TickerProviderStateMixin {
  // TextEditingController slug = TextEditingController();

  ProductAllController proAllController = Get.put(ProductAllController());
  final _horizontalScrollController = ScrollController();

  @override
  void initState() {
    //  proAllController.getDropListAddPro();

    // TODO: implement initState
  }
  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,maxWidth: 800,maxHeight: 150,imageQuality: 100
    );
    setState(() {
      proAllController.imageFileDig = pickedFile!;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          color: Colors.white,
          height: Get.height - 150,
          child:   Obx(() => proAllController.isLoading.value == true
              ? Center(
            child: Lottie.asset('assets/images/loading.json',
                width: 90, height: 90),
          )
              : ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  color: Colors.white,
                  // height: Get.height,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ' * '+  S.of(context).prot,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0.0),
                          child: Container(
                            width: Get.width,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF002e80),
                                            blurRadius: 1,
                                            spreadRadius: 0)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 15, 10, 15),
                                    child: DropdownButtonHideUnderline(
                                        child:
                                        DropdownButton<CustomerModelAraList>(
                                          value: proAllController.proItem,
                                          isDense: true,
                                          onChanged: (CustomerModelAraList? val) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());

                                            setState(() {
                                              proAllController.proItem = val;
                                            });
                                            if(proAllController.proItem!.id.toString()=='1'){


                                            }else if(proAllController.proItem!.id.toString()=='2'){

                                             /* proAllController.productItem!.quantitySel = 1;
                                              proAllController.productItem!.net_price_sel =
                                                  proAllController.productItem!.net_price;*/
                                              proAllController.getProduct();

                                              proAllController.productListSele.clear();
                                              for(int u=0;u<proAllController
                                                  .productList.length;u++){
                                                proAllController.productList[u].quantitySel = 1;
                                                proAllController.productList[u].net_price_sel =
                                                    proAllController.productList[u].net_price;
                                              }
                                            }

                                          },
                                          items: proAllController.proList
                                              .map((final value) {
                                            return DropdownMenuItem<
                                                CustomerModelAraList>(
                                              value: value,
                                              child: new Text(proAllController.languagee=='en'?value.name:value.nameAr,

                                                  style: TextStyle()),
                                            );
                                          }).toList(),
                                          isExpanded: true,
                                          iconEnabledColor: Color(0xFF002e80),
                                          hint: Text(
                                            S.of(context).prot,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        proAllController.proItem != null
                            ? proAllController.proItem!.id == '1'
                            ? Visibility(child:Text(''),visible: false,)/*Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).supplier,
                                  style: TextStyle(
                                      color: Color(0xFF002e80),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                InkWell(
                                    onTap: () {
                                      if (proAllController
                                          .supAdvdList.length <
                                          5) {
                                        final controllern =
                                        TextEditingController();
                                        final controllerp =
                                        TextEditingController();
                                        WarehouseModelList subI =
                                        proAllController.suplierList[0];

                                        proAllController.addItemSup(
                                            controllern,
                                            controllerp,
                                            subI);
                                      } else {
                                        Get.snackbar(
                                            S.of(context).Error,
                                            S.of(context).maxs,
                                            backgroundColor: Colors
                                                .grey
                                                .withOpacity(0.6));
                                      }
                                    },
                                    child: Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: Color(0xFF002e80),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )*/
                            : proAllController.proItem!.id == '2'
                            ? Obx(
                                () =>
                            proAllController.productList.value
                                .length ==
                                0
                                ? Center(
                              child: Lottie.asset('assets/images/loading.json',
                                  width: 90, height: 90),
                            )
                                : Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).addp,
                                      style: TextStyle(
                                          color: Color(
                                              0xFF002e80),
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets
                                      .fromLTRB(
                                      0, 15, 0, 0.0),
                                  child: Container(
                                    width: Get.width,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .fromLTRB(
                                          0,
                                          0,
                                          0,
                                          0.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(
                                                        0xFF002e80),
                                                    blurRadius:
                                                    1,
                                                    spreadRadius:
                                                    0)
                                              ]),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .fromLTRB(
                                                10.0,
                                                15,
                                                10,
                                                15),
                                            child:
                                            DropdownButtonHideUnderline(
                                                child:
                                                DropdownButton<ProductModdelList>(
                                                  /*  value: proAllController
                                                            .productItem,*/
                                                  isDense:
                                                  true,
                                                  onChanged:
                                                      (ProductModdelList?
                                                  val) {
                                                    FocusScope.of(
                                                        context)
                                                        .requestFocus(
                                                        new FocusNode());

                                                    setState(
                                                            () {
                                                          proAllController.check =
                                                          false;
                                                          proAllController.comboItem =(ComboModel(
                                                            id: val!.id,
                                                            name: val.name,
                                                            code: val.code,
                                                            qty: val.quantitySel.toString(),
                                                            price: val.net_price_sel
                                                          ));
                                                              val;
                                                          final controllerq =
                                                          TextEditingController();
                                                          final controllerpr =
                                                          TextEditingController();

                                                          if (proAllController.productListSele.value.length ==
                                                              0) {
                                                            controllerq.text= proAllController.comboItem!.qty.toString();
                                                            controllerpr.text= proAllController.comboItem!.price.toString();

                                                            proAllController.productListSele.add(TableComboModelEdit(
                                                                quan: controllerq,
                                                                pric: controllerpr,
                                                                itemPro: proAllController.comboItem!));
                                                            proAllController.check =
                                                            true;
                                                          } else {
                                                            for (int i = 0;
                                                            i < proAllController.productListSele.length;
                                                            i++) {


                                                              if (proAllController.productListSele[i].itemPro.id.toString() ==
                                                                  proAllController.comboItem!.id.toString()) {
                                                                proAllController.productListSele[i].itemPro.qty = (int.parse(proAllController.productListSele[i].itemPro.qty.toString().split('.')[0]) + 1).toString();
                                                                proAllController.productListSele[i].quan.text =proAllController.productListSele[i].itemPro.qty.toString();

                                                                proAllController.check = true;
                                                              }
                                                            }
                                                          }
                                                          if (proAllController.check ==
                                                              false) {
                                                            controllerq.text= proAllController.comboItem!.qty.toString();
                                                            controllerpr.text= proAllController.comboItem!.price.toString();

                                                            proAllController.productListSele.add(TableComboModelEdit(
                                                                quan: controllerq,
                                                                pric: controllerpr,
                                                                itemPro: proAllController.comboItem!));
                                                          }
                                                        });
                                                  },
                                                  items: proAllController
                                                      .productList
                                                      .map(
                                                          (final value) {
                                                        return DropdownMenuItem<
                                                            ProductModdelList>(
                                                          value:
                                                          value,
                                                          child: new Text(
                                                              value
                                                                  .name,
                                                              style:
                                                              TextStyle()),
                                                        );
                                                      }).toList(),
                                                  isExpanded:
                                                  true,
                                                  iconEnabledColor:
                                                  Color(
                                                      0xFF002e80),
                                                  hint: Text(
                                                    S
                                                        .of(context)
                                                        .product,
                                                    style:
                                                    TextStyle(
                                                      color: Colors
                                                          .black,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                proAllController
                                    .productListSele
                                    .value
                                    .length ==
                                    0
                                    ? Visibility(
                                  child: Text(''),
                                  visible: false,
                                )
                                    : Padding(
                                    padding:
                                    EdgeInsets
                                        .fromLTRB(
                                        0,
                                        10,
                                        0,
                                        10),
                                    child:
                                    _dataBody())
                              ],
                            ))
                            :
                        proAllController.proItem!.id == '3'
                            ?Column(children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).fileu,
                                style: TextStyle(
                                    color: Color(0xFF002e80),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: proAllController.digi,
                                      style: TextStyle(color: Color(0xFF002e80)),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(15),
                                          labelStyle:
                                          TextStyle(color: Color(0xFF002e80)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder: new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
// and:

                                          suffixStyle:
                                          TextStyle(color: Color(0xFF002e80)),
                                          hintText: S.of(context).fileu,
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          )),
                                    )),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF002e80),
                                          blurRadius: 2,
                                          spreadRadius: 0)
                                    ]),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                ' * '+ S.of(context).digita,
                                style: TextStyle(
                                    color: Color(0xFF002e80),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),SizedBox(
                            height: 0,
                          ),
                          Center(
                              child:proAllController.itemDetails.file.toString()==''?
                              proAllController.imageFileDig == null
                                  ? InkWell(
                                  onTap: () {
                                    _onImageButtonPressed(ImageSource.gallery,
                                        context: context);
                                  },
                                  child: Lottie.asset(
                                      'assets/images/attach.json',
                                      width: 200,
                                      height: 200))
                                  :InkWell(
                                  onTap: () {
                                    _onImageButtonPressed(ImageSource.gallery,
                                        context: context);
                                  },
                                  child: Image.file(File(proAllController.imageFileDig!.path),height: 300,width: Get.width,)):
                          InkWell(
                              onTap: () {
                                _onImageButtonPressed(ImageSource.gallery,
                                    context: context);
                              },
                              child: Image.network(
                                'https://heba.icon-pos.com/assets/uploads/' +proAllController.itemDetails.file,
                                height: 300,
                                width: Get.width,
                              ))),
                        ],):

                        Visibility(
                          child: Text(''),
                          visible: false,
                        )
                            : Visibility(
                          child: Text(''),
                          visible: false,
                        ),
                        proAllController.proItem != null
                            ? proAllController.proItem!.id == '1'
                            ?/* Obx(() => ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                      0, 15, 0, 0.0),
                                  child: Container(
                                    width: Get.width,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 0, 0.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(
                                                        0xFF002e80),
                                                    blurRadius: 1,
                                                    spreadRadius: 0)
                                              ]),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .fromLTRB(
                                                10.0,
                                                15,
                                                10,
                                                15),
                                            child:
                                            DropdownButtonHideUnderline(
                                                child: DropdownButton<
                                                    WarehouseModelList>(
                                                  value: proAllController
                                                      .supAdvdList[
                                                  index]
                                                      .supItemAdd,
                                                  isDense: true,
                                                  onChanged:
                                                      (WarehouseModelList?
                                                  val) {
                                                    FocusScope.of(
                                                        context)
                                                        .requestFocus(
                                                        new FocusNode());

                                                    setState(() {
                                                      proAllController
                                                          .supAdvdList[
                                                      index]
                                                          .supItemAdd = val!;
                                                    });
                                                  },
                                                  items: proAllController
                                                      .supAdvdList[
                                                  index]
                                                      .supAddList
                                                      .map<
                                                      DropdownMenuItem<
                                                          WarehouseModelList>>(
                                                          (WarehouseModelList
                                                      value) {
                                                        return DropdownMenuItem<
                                                            WarehouseModelList>(
                                                          value: value,
                                                          child: new Text(
                                                              value.name,
                                                              style:
                                                              TextStyle()),
                                                        );
                                                      }).toList(),
                                                  isExpanded: true,
                                                  iconEnabledColor:
                                                  Color(0xFF002e80),
                                                  hint: Text(
                                                    S.of(context).prot,
                                                    style: TextStyle(
                                                      color:
                                                      Colors.black,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          width: Get.width / 2.3,
                                          child: Padding(
                                              padding: EdgeInsets
                                                  .fromLTRB(
                                                  10, 0, 10, 5),
                                              child: TextField(

                                                controller:
                                                proAllController
                                                    .supAdvdList[
                                                index]
                                                    .supn,
                                                keyboardType: TextInputType.number,

                                                style: TextStyle(
                                                    color: Color(
                                                        0xFF002e80)),
                                                decoration:
                                                InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.all(
                                                        15),
                                                    labelStyle: TextStyle(
                                                        color: Color(
                                                            0xFF002e80)),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide:
                                                      const BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                    new UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          color: Colors.transparent),
                                                    ),
// and:

                                                    suffixStyle:
                                                    TextStyle(
                                                        color: Color(
                                                            0xFF002e80)),
                                                    hintText: S
                                                        .of(
                                                        context)
                                                        .supno,
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey,
                                                        fontSize:
                                                        13)),
                                              )),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(
                                                        0xFF002e80),
                                                    blurRadius: 2,
                                                    spreadRadius: 0)
                                              ]),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: Get.width / 2.3,
                                          child: Padding(
                                              padding: EdgeInsets
                                                  .fromLTRB(
                                                  10, 0, 10, 5),
                                              child: TextField(
                                                keyboardType: TextInputType.number,

                                                controller:
                                                proAllController
                                                    .supAdvdList[
                                                index]
                                                    .supp,
                                                style: TextStyle(
                                                    color: Color(
                                                        0xFF002e80)),
                                                decoration:
                                                InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.all(
                                                        15),
                                                    labelStyle: TextStyle(
                                                        color: Color(
                                                            0xFF002e80)),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide:
                                                      const BorderSide(
                                                        color: Colors
                                                            .transparent,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                    new UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          color: Colors.transparent),
                                                    ),
// and:

                                                    suffixStyle:
                                                    TextStyle(
                                                        color: Color(
                                                            0xFF002e80)),
                                                    hintText: S
                                                        .of(
                                                        context)
                                                        .supp,
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey,
                                                        fontSize:
                                                        13)),
                                              )),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(
                                                        0xFF002e80),
                                                    blurRadius: 2,
                                                    spreadRadius: 0)
                                              ]),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          },
                          itemCount:
                          proAllController.supAdvdList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ))*/
                        Visibility(
                          child: Text(''),
                          visible: false,
                        )
                            : Visibility(
                          child: Text(''),
                          visible: false,
                        )
                            : Visibility(
                          child: Text(''),
                          visible: false,
                        ),
                        proAllController.proItem != null
                            ? SizedBox(
                          height: 20,
                        )
                            : Visibility(
                          child: Text(''),
                          visible: false,
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  Scrollbar _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return Scrollbar(
      controller: _horizontalScrollController,
      isAlwaysShown: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _horizontalScrollController,
        child: DataTable(
          border:
          TableBorder.all(color: Colors.black.withOpacity(0.2), width: 1),
          columns: [
            DataColumn(
              label: Text(S.of(context).productn,textAlign: TextAlign.center,),
            ),
            DataColumn(
              label: Text(S.of(context).Quantity,textAlign: TextAlign.center,),
            ),
            DataColumn(
              label: Text(S.of(context).Price,textAlign: TextAlign.center,),
            ),
            DataColumn(
              label: Text(S.of(context).delete),
            ),
            // Lets add one more column to show a delete button
          ],
          rows: proAllController.productListSele
              .map(
                (employee) => DataRow(cells: [
              DataCell(
                Text(
                  employee.itemPro.name.toString(),
                  textAlign: TextAlign.center,
                ),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {},
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: employee.quan,
                    keyboardType: TextInputType.number,

                    onChanged: (val) {
                      if(val!=''||val!=null||val!='null'){
                      employee.itemPro.qty =
                          employee.quan.text;}else{
                        employee.itemPro.qty ='0';
                      }
                    },
                    textAlign: TextAlign.center,
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
                          borderSide: BorderSide(color: Colors.grey),
                        ),
// and:

                        suffixStyle: TextStyle(color: Color(0xFF002e80)),
                        hintText: employee.itemPro.qty.toString().split('.')[0],
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 13)),
                  ),
                ),
                onTap: () {},
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: employee.pric,
                    keyboardType: TextInputType.number,

                    textAlign: TextAlign.center,
                    onChanged: (val) {
                      employee.itemPro.price = employee.pric.text;
                    },
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
                          borderSide: BorderSide(color: Colors.grey),
                        ),
// and:

                        suffixStyle: TextStyle(color: Color(0xFF002e80)),
                        hintText: employee.itemPro.price.toString().replaceAll('.0000', ''),
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 13)),
                  ),
                ),
                onTap: () {},
              ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                  /*    proAllController.productItem!.quantitySel = 1;
                      proAllController.productItem!.net_price_sel =
                          proAllController.productItem!.net_price;*/
                      for (int u = 0;
                      u < proAllController.productListSele.length;
                      u++) {
                        if (employee.itemPro.id ==
                            proAllController.productListSele[u].itemPro.id) {
                          setState(() {
                            proAllController.productListSele.removeAt(u);
                          });
                        }
                      }
                    },
                  )),
            ]),
          )
              .toList(),
        ),
      ),
    );
  }
}
