import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/report_api_provider.dart';
import 'package:icon/response/report_sale_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:icon/helper/save_file_mobile_desktop.dart'
if (dart.library.html) 'package:icon/helper/save_file_web.dart' as helper;
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:icon/apiProvider/pdf_print_report_api.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/report_controller.dart';
import 'package:icon/generated/l10n.dart';


import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row ;
class ReportSalePage extends StatefulWidget {
  @override
  _ReportSalePage createState() => _ReportSalePage();
}

class _ReportSalePage extends State<ReportSalePage>
    with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  ReportController repController = Get.put(ReportController());


  @override
  void initState() {
    repController.getReportSale(
      context,
    );

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
        actions: [
          repController.search == false
              ? Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(Icons.search),
                        onTap: () {
                          setState(() {
                            repController.search = true;
                          });
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5,0,5,0.0),
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
                ],
              )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                         // border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          S.of(context).send,
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    onTap: () {
                      repController.getReportSaleSearch(
                          context, repController.searchMAin.text);
                    },
                  ),
                )
        ],

        leading: repController.search == false
            ? InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  posController.languagee.value == 'en'
                      ? Icons.keyboard_arrow_left_sharp
                      : Icons.keyboard_arrow_right,
                  color: Colors.white,
                ))
            : InkWell(
                child: Icon(Icons.cancel_outlined),
                onTap: () {
                  setState(() {
                    repController.search = false;
                  });
                  repController.searchMAin.text = '';
                  repController.getReportSale(
                    context,
                  );
                },
              ),
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
        title: repController.search == true
            ? Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
                child: TextField(
                  controller: repController.searchMAin,
                  autofocus: true,
                  onChanged: (value) {
                    if (value == '') {
                      repController.getReportSale(
                        context,
                      );
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
              )
            : Text(S.of(context).saleR,
                style: TextStyle(fontSize: 22.0, color: Colors.white)),
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
              () => repController.isLoadingS.value == true
                  ? Center(
                      child: Lottie.asset('assets/images/loading.json',
                          width: 90, height: 90),
                    )
                  : repController.reportSaleList.value.isEmpty
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
                      : repController.employeeDataSource!._employeeData.isEmpty
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
                                source: repController.employeeDataSource!,
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
                                      columnName: 'Biller',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).biller,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                  GridColumn(
                                      columnName: 'Customer',
                                      label: Container(
                                          padding: EdgeInsets.all(8.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            S.of(context).customer,
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
                                          child: Text(S.of(context).statue,
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
              DataGridCell<String>(columnName: 'Biller', value: e.biller),
              DataGridCell<String>(columnName: 'Customer', value: e.customer),
              DataGridCell<String>(columnName: 'total', value: e.grand_total),
              DataGridCell<String>(columnName: 'Paid', value: e.paid),
              DataGridCell<String>(columnName: 'Balance', value: e.balance),
              DataGridCell<String>(
                  columnName: 'Status', value: e.payment_status),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'sales', value: e.sale_status),
              DataGridCell<String>(
                  columnName: 'refRet', value: e.return_sale_ref),
      DataGridCell<String>(
          columnName: 'action', value: ''),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  BuildContext? con;
  ReportController repController = Get.put(ReportController());

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  Future<void> handleLoadMoreRows() async {
    //   await Future.delayed(Duration(seconds: 5));
    int startIndex = repController.page;

    repController.page = repController.page + 10;
    ReportSaleResponse res;
    if (repController.searchMAin.text == '') {
      res = await ReportApiProvider()
          .getReportSale(repController.page.toString());
    } else {
      Map<String, dynamic> dataId = ({
        "reference_no": repController.searchMAin.text,
      });
      res = await ReportApiProvider()
          .getReportSaleSearch(repController.page.toString(), dataId);
    }

    repController.reportSaleListmore.clear();
    if (res.statuecode == 200) {
      repController.reportSaleList.addAll(res.listRep);
      repController.reportSaleListmore.addAll(res.listRep);

      int endIndex = repController.page;
      for (int i = 0; i < repController.reportSaleListmore.length; i++) {
        _employeeData.add(DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'date',
              value: repController.reportSaleListmore[i].date),
          DataGridCell<String>(
              columnName: 'refe',
              value: repController.reportSaleListmore[i].reference_no),
          DataGridCell<String>(
              columnName: 'Biller',
              value: repController.reportSaleListmore[i].biller),
          DataGridCell<String>(
              columnName: 'Customer',
              value: repController.reportSaleListmore[i].customer),

          DataGridCell<String>(
              columnName: 'total',
              value: repController.reportSaleListmore[i].grand_total),
          DataGridCell<String>(
              columnName: 'Paid',
              value: repController.reportSaleListmore[i].paid),
          DataGridCell<String>(
              columnName: 'Balance',
              value: repController.reportSaleListmore[i].balance),
          DataGridCell<String>(
              columnName: 'Status',
              value: repController.reportSaleListmore[i].payment_status),
          DataGridCell<String>(
              columnName: 'id', value: repController.reportSaleListmore[i].id),
          DataGridCell<String>(
              columnName: 'sales',
              value: repController.reportSaleListmore[i].sale_status),
          DataGridCell<String>(
              columnName: 'refRet',
              value: repController.reportSaleListmore[i].return_sale_ref),
          DataGridCell<String>(
              columnName: 'action',
              value: ''),
        ]));
      }
    }
  }

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
        child: Text(row.getCells()[9].value == 'returned'
            ? row.getCells()[10].value.toString()
            : row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[3].value.toString()),
      ),
  /*    Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[4].value.toString()),
      ),*/
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
            color: row.getCells()[9].value == 'returned'
                ? Colors.blueGrey.withOpacity(0.6)
                : row.getCells()[7].value == 'paid'
                    ? Colors.green.withOpacity(0.5)
                    : row.getCells()[7].value == 'due'
                        ? Colors.red.withOpacity(0.5)
                        : Colors.orange.withOpacity(0.5),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: Text(
                row.getCells()[9].value == 'returned'
                    ? S.of(con!).retur
                    : row.getCells()[7].value == 'paid'
                        ? S.of(con!).paidd
                        : S.of(con!).due,
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
            if (value == 2) {
              /* final image =
                  await imageFromAssetBundle('assets/images/logo.png');

              final pdfFile = await PdfInvoiceApiReport.generate(
                  row.getCells(), image, posController.languagee.value, '1');*/
              if (row.getCells()[9].value == 'returned') {
                posController.printReport(
                    row.getCells()[8].value.toString(), '1', '1');
              } else {
                posController.printReport(
                    row.getCells()[8].value.toString(), '1', '0');
              }
            } else {
              /* final image =
                  await imageFromAssetBundle('assets/images/logo.png');

              final pdfFile = await PdfInvoiceApiReport.generate(
                  row.getCells(), image, posController.languagee.value, '2');*/

              if (row.getCells()[9].value == 'returned') {
                posController.printReport(
                    row.getCells()[8].value.toString(), '2', '1');
              } else {
                posController.printReport(
                    row.getCells()[8].value.toString(), '2', '0');
              }
            }
            //  _value = value;
          },
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(S.of(context).share),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text(S.of(context).print),
                  value: 2,
                )
              ])
    ]);
  }

  @override
  Future<void> handleRefresh() async {
    repController.reportSaleList.clear();
    repController.reportSaleListmore.clear();

    repController.page = 1;
    if (repController.searchMAin.text == '') {
      repController.getReportSale(con!);
    } else {
      repController.getReportSaleSearch(con!, repController.searchMAin.text);
    }
    _employeeData = repController.reportSaleList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'refe', value: e.reference_no),
              DataGridCell<String>(columnName: 'Biller', value: e.biller),
              DataGridCell<String>(columnName: 'Customer', value: e.customer),
              DataGridCell<String>(columnName: 'total', value: e.grand_total),
              DataGridCell<String>(columnName: 'Paid', value: e.paid),
              DataGridCell<String>(columnName: 'Balance', value: e.balance),
              DataGridCell<String>(
                  columnName: 'Status', value: e.payment_status),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'sales', value: e.sale_status),
              DataGridCell<String>(
                  columnName: 'refRet', value: e.return_sale_ref),
            ]))
        .toList();
    notifyListeners();
  }
}
