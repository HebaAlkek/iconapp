import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/report_api_provider.dart';
import 'package:icon/controller/product_controller.dart';
import 'package:icon/controller/retrive_controller.dart';
import 'package:icon/screen/purchases/add_purchases_page.dart';
import 'package:icon/screen/ref_list_page.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/purchases_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/save_file_mobile_desktop.dart'
    if (dart.library.html) 'package:icon/helper/save_file_web.dart' as helper;
import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

class PurchasesPage extends StatefulWidget {
  List<dynamic> wareList;

  PurchasesPage(this.wareList);

  @override
  _PurchasesPage createState() => _PurchasesPage();
}

class _PurchasesPage extends State<PurchasesPage>
    with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  PurchasesController purController = Get.put(PurchasesController());
  bool searchTax = false;

  @override
  void initState() {
    purController.getPurchasesList(context);

    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Future<void> exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        leading: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  posController.languagee.value == 'en'
                      ? Icons.keyboard_arrow_left_sharp
                      : Icons.keyboard_arrow_right,
                  color: Colors.white,
                )),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                purController.getPurchasesListFilter(context);
              },
              child: Icon(Icons.sort),
            )
          ],
        ),
        actions: [
          searchTax == false
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                        child: Icon(Icons.search),
                        onTap: () {
                          setState(() {
                            searchTax = true;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.file_download),
                        ),
                        onTap: () {
                          exportDataGridToExcel();
                        },
                      ),
                    ),
                    posController.permission.value.length != 0
                        ? posController.purAdd == '1'
                            ? InkWell(
                                onTap: () {
                                  ProductController proController =
                                      Get.put(ProductController());

                                  proController.productListSele.clear();
                                  purController.currentStep.value = 0;
                                  Get.to(
                                      () => AddPurchasesPage(widget.wareList));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 21,
                                    ),
                                  ),
                                ))
                            : Visibility(child: Text(''), visible: false)
                        : InkWell(
                            onTap: () {
                              ProductController proController =
                                  Get.put(ProductController());

                              proController.productListSele.clear();
                              purController.currentStep.value = 0;
                              Get.to(() => AddPurchasesPage(widget.wareList));
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0.0),
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                            )),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(Icons.cancel_outlined),
                    onTap: () {
                      setState(() {
                        purController.searchMAinTax.text = '';
                        searchTax = false;
                        purController.purList.clear();
                        purController.purList.addAll(purController.purListAll);
                        purController.employeeDataSource = EmployeeDataSource(
                            employeeData: purController.purList,
                            contdext: context);
                      });
                    },
                  ),
                ),
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
        title: searchTax == false
            ? Text(S.of(context).puschae,
                style: TextStyle(fontSize: 22.0, color: Colors.white))
            : Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
                child: TextField(
                  controller: purController.searchMAinTax,
                  autofocus: true,
                  onChanged: (value) {
                    final dummySearchList = [];
                    dummySearchList.addAll(purController.purListAll);
                    if (value.isNotEmpty) {
                      final dummyListData = [];
                      dummySearchList.forEach((item) {
                        if (item.supplier
                                .toString()
                                .toLowerCase()
                                .contains(value.toString().toLowerCase()) ||
                            item.reference_no
                                .toString()
                                .toLowerCase()
                                .contains(value.toString().toLowerCase())) {
                          dummyListData.add(item);
                        }
                      });
                      setState(() {
                        purController.purList.clear();
                        purController.purList.addAll(dummyListData);
                        purController.employeeDataSource = EmployeeDataSource(
                            employeeData: purController.purList,
                            contdext: context);
                      });
                      return;
                    } else {
                      setState(() {
                        purController.purList.clear();
                        purController.purList.addAll(purController.purListAll);
                        purController.employeeDataSource = EmployeeDataSource(
                            employeeData: purController.purList,
                            contdext: context);
                      });
                    }
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
                      hintText: S.of(context).searchh,
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          color: Colors.white,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Obx(
              () => purController.isLoading.value == true
                  ? Center(
                      child: Lottie.asset('assets/images/loading.json',
                          width: 90, height: 90),
                    )
                  : purController.purList.value.isEmpty
                      ? Container(
                          width: Get.width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 50, 10, 8.0),
                            child: Center(
                              child: Lottie.asset('assets/images/nodata.json',
                                  height: 250, width: 250),
                            ),
                          ),
                        )
                      : purController.employeeDataSource!._employeeData.isEmpty
                          ? Container(
                              width: Get.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 8.0),
                                child: Center(
                                  child: Lottie.asset(
                                      'assets/images/nodata.json',
                                      height: 250,
                                      width: 250),
                                ),
                              ),
                            )
                          : SfDataGridTheme(
                              data: SfDataGridThemeData(
                                  headerColor: const Color(0xFF002e80)),
                              child: SfDataGrid(
                                key: _key,
                                highlightRowOnHover: true,
                                allowPullToRefresh: true,
                                loadMoreViewBuilder: (BuildContext context,
                                    LoadMoreRows loadMoreRows) {
                                  Future<String> loadRows() async {
                                    await loadMoreRows();
                                    return Future<String>.value('Completed');
                                  }

                                  return FutureBuilder<String>(
                                    initialData: 'loading',
                                    future: loadRows(),
                                    builder: (context, snapShot) {
                                      if (snapShot.data == 'loading') {
                                        return Container(
                                            height: 60.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: BorderDirectional(
                                                    top: BorderSide(
                                                        width: 1.0,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.26)))),
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Text('');
                                      }
                                    },
                                  );
                                },
                                headerRowHeight: 65,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
                                source: purController.employeeDataSource!,
                                columnWidthMode: ColumnWidthMode.lastColumnFill,
                                columns: <GridColumn>[
                                  GridColumn(
                                      columnName: 'date',
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).date,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'refe',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).refno,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'supplier',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).suppl,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'purstate',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).purstate,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'total',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).grand,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'Paid',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).paid,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'Balance',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).balance,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'Status',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(S.of(context).paystate,
                                              style: TextStyle(
                                                  color: Colors.white)))),
                                  GridColumn(
                                      columnName: 'action',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(S.of(context).action,
                                              style: TextStyle(
                                                  color: Colors.white)))),
                                ],
                              )),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  PosController posController = Get.put(PosController());

  /// Creates the employee data source class with required details.
  EmployeeDataSource(
      {required var employeeData, required BuildContext contdext}) {
    con = contdext;
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'refe', value: e.reference_no),
              DataGridCell<String>(columnName: 'supplier', value: e.supplier),
              DataGridCell<String>(columnName: 'purstate', value: e.status),
              DataGridCell<String>(columnName: 'total', value: e.grand_total),
              DataGridCell<String>(columnName: 'Paid', value: e.paid),
              DataGridCell<String>(columnName: 'Balance', value: e.grand_total),
              DataGridCell<String>(
                  columnName: 'Status', value: e.payment_status),
              DataGridCell<String>(columnName: 'action', value: ''),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  BuildContext? con;

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      /* row.getCells().map<Widget>((e) {
          return
         Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList(),*/
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: row.getCells()[3].value == 'pending'
                ? Colors.orange.withOpacity(0.6)
                : row.getCells()[3].value == 'ordered'
                    ? Colors.blue.withOpacity(0.5)
                    : row.getCells()[3].value == 'received'
                        ? Colors.green.withOpacity(0.5)
                        : Colors.blue.withOpacity(0.5),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: posController.languagee == 'en'
                  ? Text(
                      row.getCells()[3].value.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )
                  : row.getCells()[3].value.toString() == 'pending'
                      ? Text(
                          'عملية معلقة',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )
                      : row.getCells()[3].value.toString() == 'received'
                          ? Text(
                              'تم الاستلام',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )
                          : Text(
                              'تم الطلب',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
            ),
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[4].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[5].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[6].value.toString()),
      ),
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: row.getCells()[7].value == 'pending'
                ? Colors.orange.withOpacity(0.6)
                : row.getCells()[7].value == 'partial'
                    ? Colors.blue.withOpacity(0.5)
                    : row.getCells()[7].value == 'paid'
                        ? Colors.green.withOpacity(0.5)
                        : Colors.blue.withOpacity(0.5),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: posController.languagee == 'en'
                  ? Text(
                      row.getCells()[7].value.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )
                  : row.getCells()[7].value.toString() == 'pending'
                      ? Text(
                          'عملية معلقة',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )
                      : row.getCells()[7].value.toString() == 'paid'
                          ? Text(
                              'مدفوع',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )
                          : Text(
                              'دفع جزئي',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
            ),
          ),
        ),
      ),
      PopupMenuButton(
          elevation: 10,
          shape: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
          enabled: true,
          onSelected: (value) async {
            if(row.getCells()[3].value.toString()=='received') {
              RetriveController refController = Get.put(RetriveController());
              Get.dialog(
                Center(
                  child:
                  Lottie.asset('assets/images/loading.json', width: 90, height: 90),
                ),
              );

              /*     Get.to(() =>
                  RefPage(row.getCells()[1].value.toString(), '2'));*/
              refController.getRetriveListPurchases(row.getCells()[1].value.toString());

            }else{
              Get.snackbar(S.of(Get.context!).Error,
                  S.of(Get.context!).msgpur,
                  backgroundColor:
                  Colors.grey.withOpacity(0.6));
            }
          },
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(S.of(context).addr),
                  value: 1,
                ),

              ])
    ]);
  }
}
