import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class StepFourProductEdit extends StatefulWidget {


  @override
  _StepFourProductEdit createState() => _StepFourProductEdit();
}

class _StepFourProductEdit extends State<StepFourProductEdit>
    with TickerProviderStateMixin {
  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  bool isCheckedCustome = false;
  List<TextEditingController> _fields = [];
  ProductAllController proAllController = Get.put(ProductAllController());

  @override
  void initState() {
    // TODO: implement initState
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
          child: ListView(
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
                          S.of(context).Productdetails,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
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
                                    controller: proAllController.proDetails,
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
                                        hintText: S.of(context).Productdetails,
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
                        Text(
                          S.of(context).detailsin,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
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
                                    controller: proAllController.proDetailsP,
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
                                        hintText: S.of(context).detailsin,
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
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              S.of(context).produxti,
                              style: TextStyle(
                                  color: Color(0xFF002e80),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            new Spacer(),
                            proAllController.imageFile==null?Visibility(child: Text(''),visible: false,):InkWell(child: Icon(Icons.delete_forever_sharp,color: Color(0xFF002e80)),
                              onTap: (){
                                setState(() {
                                  proAllController.imageFile=null;
                                });
                              },)
                          ],
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Center(
                            child:proAllController.itemDetails.image.toString()==''?
                            proAllController.imageFile == null
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
                                child: Image.file(
                              File(proAllController.imageFile!.path),
                              height: 300,
                              width: Get.width,
                            )):
                            proAllController.imageFile == null
                                ?   InkWell(
                                onTap: () {
                                  _onImageButtonPressed(ImageSource.gallery,
                                      context: context);
                                },
                                child: Image.network(
                                  'https://heba.icon-pos.com/assets/uploads/' +proAllController.itemDetails.image,
                                  height: 300,
                                  width: Get.width,
                                )):InkWell(
                                onTap: () {
                                  _onImageButtonPressed(ImageSource.gallery,
                                      context: context);
                                },
                                child: Image.file(
                                  File(proAllController.imageFile!.path),
                                  height: 300,
                                  width: Get.width,
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: proAllController.isCheckedHide,
                              activeColor: Color(0xFF002e80),
                              onChanged: (bool? value) {
                                setState(() {
                                  proAllController.isCheckedHide = value!;
                                });
                              },
                            ),
                            Text(
                              S.of(context).pro,
                              style: TextStyle(color: Color(0xFF002e80)),
                            )
                          ],
                        ),
                        proAllController.isCheckedHide == false
                            ? Visibility(
                          child: Text(''),
                          visible: false,
                        )
                            : Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).proprice,
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
                                      padding: EdgeInsets.fromLTRB(
                                          10, 0, 10, 5),
                                      child: TextField(
                                        keyboardType:
                                        TextInputType.number,
                                        controller: proAllController.prop,
                                        style: TextStyle(
                                            color: Color(0xFF002e80)),
                                        decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.all(15),
                                            labelStyle: TextStyle(
                                                color: Color(0xFF002e80)),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            enabledBorder:
                                            new UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Colors.transparent),
                                            ),
// and:

                                            suffixStyle: TextStyle(
                                                color: Color(0xFF002e80)),
                                            hintText:
                                            S.of(context).proprice,
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            )),
                                      )),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10),
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
                                  S.of(context).dates,
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
                            Obx(
                                  () => InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1910, 1, 1),
                                      maxTime: DateTime(3000, 1, 1),
                                      theme: DatePickerTheme(
                                          headerColor: Color(0xFF002e80)
                                              .withOpacity(0.3),
                                          backgroundColor: Colors.white,
                                          itemStyle: TextStyle(
                                              color: Color(0xFF002e80),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          doneStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      onChanged: (date) {
                                        print('change $date in time zone ' +
                                            date.timeZoneOffset.inHours
                                                .toString());
                                        proAllController.dates.value =
                                            date.toString().substring(0, 10);
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        proAllController.dates.value =
                                            date.toString().substring(0, 10);
                                      }, currentTime: DateTime.now());
                                },
                                child: Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              25, 15, 25, 15),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                proAllController.dates
                                                    .value ==
                                                    ''
                                                    ? S.of(context).dates
                                                    : proAllController
                                                    .dates.value,
                                                style: TextStyle(
                                                    color: proAllController
                                                        .dates
                                                        .value ==
                                                        ''
                                                        ? Colors.grey
                                                        : Color(
                                                        0xFF002e80),
                                                    fontSize: 16),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(0xFF002e80),
                                              )
                                            ],
                                          )),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF002e80),
                                                blurRadius: 2,
                                                spreadRadius: 0)
                                          ]),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).datee,
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
                            Obx(() => InkWell(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(1910, 1, 1),
                                    maxTime: DateTime(3000, 1, 1),
                                    theme: DatePickerTheme(
                                        headerColor: Color(0xFF002e80)
                                            .withOpacity(0.3),
                                        backgroundColor: Colors.white,
                                        itemStyle: TextStyle(
                                            color: Color(0xFF002e80),
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16)),
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours
                                              .toString());
                                      proAllController.datee.value = date
                                          .toString()
                                          .substring(0, 10);
                                    }, onConfirm: (date) {
                                      print('confirm $date');
                                      proAllController.datee.value = date
                                          .toString()
                                          .substring(0, 10);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            25, 15, 25, 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              proAllController.datee
                                                  .value ==
                                                  ''
                                                  ? S
                                                  .of(context)
                                                  .datee
                                                  : proAllController
                                                  .datee.value,
                                              style: TextStyle(
                                                  color: proAllController
                                                      .datee
                                                      .value ==
                                                      ''
                                                      ? Colors.grey
                                                      : Color(
                                                      0xFF002e80),
                                                  fontSize: 16),
                                            ),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_down,
                                              color:
                                              Color(0xFF002e80),
                                            )
                                          ],
                                        )),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                              Color(0xFF002e80),
                                              blurRadius: 2,
                                              spreadRadius: 0)
                                        ]),
                                  )),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        /*   Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isCheckedCustome,
                              activeColor: Color(0xFF002e80),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedCustome = value!;
                                  if (isCheckedCustome == true) {
                                    List<TextEditingController> listEdit = [];
                                    for (int i = 0; i < 6; i++) {
                                      final controller =
                                          TextEditingController();
                                      listEdit.add(controller);
                                    }
                                    _fields.addAll(listEdit);
                                  } else {
                                    setState(() {
                                      _fields.clear();
                                    });
                                  }
                                });
                              },
                            ),
                            Text(
                              S.of(context).custom,
                              style: TextStyle(color: Color(0xFF002e80)),
                            )
                          ],
                        ),*/
                        isCheckedCustome == false
                            ? Visibility(
                          child: Text(''),
                          visible: false,
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _fields.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Container(
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10, 12, 10, 12),
                                        child: TextField(
                                          controller: _fields[index],
                                          onChanged: (val) {},
                                          style: TextStyle(
                                              color: Color(0xFF002e80)),
                                          decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.zero,
                                              isDense: true,
                                              labelStyle: TextStyle(
                                                  color:
                                                  Color(0xFF002e80)),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide:
                                                const BorderSide(
                                                  color:
                                                  Colors.transparent,
                                                ),
                                              ),
                                              enabledBorder:
                                              new UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent),
                                              ),
// and:

                                              suffixStyle: TextStyle(
                                                  color:
                                                  Color(0xFF002e80)),
                                              hintText:
                                              S.of(context).field +
                                                  ' $index',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              )),
                                        )),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF002e80),
                                              blurRadius: 2,
                                              spreadRadius: 0)
                                        ]),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 150,
        imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        proAllController.imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
