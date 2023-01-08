import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/report_api_provider.dart';
import 'package:icon/controller/customer_controller.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/report_controller.dart';
import 'package:icon/generated/l10n.dart';
import 'package:icon/helper/stepper_package.dart';
import 'package:icon/response/report_taxs_response.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:icon/helper/save_file_mobile_desktop.dart'
if (dart.library.html) 'package:icon/helper/save_file_web.dart' as helper;
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row ;

class ReportPage extends StatefulWidget {
  @override
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> with TickerProviderStateMixin {
  PosController posController = Get.put(PosController());
  ReportController repController = Get.put(ReportController());

  @override
  void initState() {
    repController.getReportTaxs(context);

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
        actions: [ repController.searchTax == false
            ? Row(
              children: [
                Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
                child: Icon(Icons.search),
                onTap: () {
                  setState(() {
                    repController.searchTax = true;
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
              repController.getReportTaxsSearch(
                  context);
            },
          ),
        )],
        leading: repController.searchTax == false
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
              repController.searchTax = false;
            });
            repController.searchMAinTax.text = '';
            repController.getReportTaxs(context);

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
        title:repController.searchTax == true
            ? Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0.0),
          child: TextField(
            controller: repController.searchMAinTax,
            autofocus: true,
            onChanged: (value) {
              if (value == '') {
                repController.getReportTaxs(context);

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
            : Text(S.of(context).taxR,
            style: TextStyle(fontSize: 22.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                physics: NeverScrollableScrollPhysics(),
                tabs: [
                  Tab(
                    child: Text(
                      S.of(context).sales,
                      style: TextStyle(
                          color: Color(0xFF002e80),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  /*  Tab(
                        child: Text(
                          S.of(context).puschae,
                          style: TextStyle(
                              color: Color(0xFF002e80),
                              fontWeight: FontWeight.bold),
                        ),
                      ),*/
                ],
                indicatorColor: Color(0xFF002e80),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          color: Colors.white,
                          height: Get.height,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Obx(
                                () => repController.isLoading.value == true
                                    ? Center(
                                        child: Lottie.asset(
                                            'assets/images/loading.json',
                                            width: 90,
                                            height: 90),
                                      )
                                    : repController.reportTaxsList.value.isEmpty
                                        ? Container(
                                            width: Get.width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 50, 10, 8.0),
                                              child: Center(
                                                child: Lottie.asset(
                                                    'assets/images/nodata.json',
                                                    height: 250,
                                                    width: 250),
                                              ),
                                            ),
                                          )
                                        :repController.employeeDataSourceTax!._employeeData.isEmpty
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
                                                headerColor:
                                                    const Color(0xFF002e80)),
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
                                              source: repController
                                                  .employeeDataSourceTax!,
                                              columnWidthMode:
                                                  ColumnWidthMode.auto,
                                              headerRowHeight: 65,
                                              gridLinesVisibility:
                                                  GridLinesVisibility.both,
                                              headerGridLinesVisibility:
                                                  GridLinesVisibility.both,
                                              columns: <GridColumn>[
                                                GridColumn(
                                                    columnName: 'date',
                                                    label: Container(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          S.of(context).date,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                                GridColumn(
                                                    columnName: 'refe',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          S.of(context).refno,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                                GridColumn(
                                                    columnName: 'ware',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          S.of(context).ware,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                                GridColumn(
                                                    columnName: 'Biller',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          S.of(context).bil,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                                GridColumn(
                                                    columnName: 'grand',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          S.of(context).pri,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                                GridColumn(
                                                    columnName: 'Productt',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          S.of(context).protax,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                                GridColumn(
                                                    columnName: 'Status',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            S
                                                                .of(context)
                                                                .statue,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))),
                                                GridColumn(
                                                    columnName: 'action',
                                                    label: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            S
                                                                .of(context)
                                                                .action,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))),
                                              ],
                                            ))
                                /*LazyDataTable(
                                                rows: repController
                                                    .reportTaxsList
                                                    .value
                                                    .length,
                                                columns: repController
                                                    .titleList.length,
                                                tableTheme: LazyDataTableTheme(
                                                    cornerColor:
                                                        Color(0xFF002e80)
                                                            .withOpacity(0.9),
                                                    alternateCellColor:
                                                        Colors.white,
                                                    cellColor: Colors.white,
                                                    columnHeaderColor:
                                                        Color(0xFF002e80)
                                                            .withOpacity(0.2),
                                                    alternateRowHeaderColor:
                                                        Color(0xFF002e80)
                                                            .withOpacity(0.2),
                                                    rowHeaderColor:
                                                        Color(0xFF002e80)
                                                            .withOpacity(0.2)),
                                                tableDimensions:
                                                    LazyDataTableDimensions(
                                                  cellHeight: 80,
                                                  cellWidth: 130,
                                                  topHeaderHeight: 50,
                                                  leftHeaderWidth: 75,
                                                ),
                                                topHeaderBuilder: (i) => Center(
                                                    child: posController
                                                                .languagee
                                                                .value !=
                                                            'ar'
                                                        ? Text(repController
                                                            .titleList[i]
                                                            .nameEn)
                                                        : Text(repController
                                                            .titleList[i]
                                                            .nameAr)),
                                                */
                              /* leftHeaderBuilder: (i) => Center(
                                  child: Text(
                                    repController
                                        .reportTaxsList.value[i].id,
                                    textAlign: TextAlign.center,
                                  ),
                                ),*/ /*
                                                dataCellBuilder: (i, j) => Center(
                                                    child: j == 0
                                                        ? Text(
                                                            repController
                                                                .reportTaxsList
                                                                .value[i]
                                                                .date,
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        : j == 1
                                                            ? Text(
                                                                repController
                                                                    .reportTaxsList
                                                                    .value[i]
                                                                    .reference_no,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )
                                                            : j == 2
                                                                ? Container(
                                                                    decoration: BoxDecoration(
                                                                        color: repController.reportTaxsList.value[i].sale_status == 'completed'
                                                                            ? Colors.green.withOpacity(0.5)
                                                                            : repController.reportTaxsList.value[i].sale_status == 'due'
                                                                                ? Colors.red.withOpacity(0.5)
                                                                                : Colors.orange.withOpacity(0.5),
                                                                        borderRadius: BorderRadius.circular(5)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              5,
                                                                              10,
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        repController
                                                                            .reportTaxsList
                                                                            .value[i]
                                                                            .sale_status,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : j == 3
                                                                    ? Text(
                                                                        repController
                                                                            .reportTaxsList
                                                                            .value[i]
                                                                            .warehouse,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    : j == 4
                                                                        ? Text(
                                                                            repController.reportTaxsList.value[i].biller,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )
                                                                        : j == 5
                                                                            ? Text(
                                                                                repController.reportTaxsList.value[i].product_tax,
                                                                                textAlign: TextAlign.center,
                                                                              )
                                                                            : j == 6
                                                                                ? Text(
                                                                                    repController.reportTaxsList.value[i].order_tax,
                                                                                    textAlign: TextAlign.center,
                                                                                  )
                                                                                : j == 7
                                                                                    ? Text(
                                                                                        repController.reportTaxsList.value[i].grand_total,
                                                                                        textAlign: TextAlign.center,
                                                                                      )
                                                                                    : PopupMenuButton(
                                                                                        elevation: 10,
                                                                                        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
                                                                                        enabled: true,
                                                                                        onSelected: (value) async {
                                                                                          if (value == 2) {
                                                                                            final image = await imageFromAssetBundle('assets/images/logo.png');
                                                                                            String data = S.of(context).date + ' : ' + repController.reportTaxsList.value[i].date + '\n' + S.of(context).refno + ' : ' + repController.reportTaxsList.value[i].reference_no + '\n' + S.of(context).bil + ' : ' + repController.reportTaxsList.value[i].biller + '\n' + S.of(context).ware + ' : ' + repController.reportTaxsList.value[i].warehouse + '\n' + S.of(context).protax + ' : ' + repController.reportTaxsList.value[i].product_tax + '\n' + S.of(context).ordertax + ' : ' + repController.reportTaxsList.value[i].order_tax + '\n' + S.of(context).grand + ' : ' + repController.reportTaxsList.value[i].grand_total + '\n' + S.of(context).statue + ' : ' + repController.reportTaxsList.value[i].sale_status + '.';
                                                                                            final pdfFile = await PdfInvoiceApiReportTax.generate(repController.reportTaxsList.value[i], image, posController.languagee.value, '1');
                                                                                          } else {
                                                                                            final image = await imageFromAssetBundle('assets/images/logo.png');
                                                                                            String data = S.of(context).date + ' : ' + repController.reportTaxsList.value[i].date + '\n' + S.of(context).refno + ' : ' + repController.reportTaxsList.value[i].reference_no + '\n' + S.of(context).bil + ' : ' + repController.reportTaxsList.value[i].biller + '\n' + S.of(context).ware + ' : ' + repController.reportTaxsList.value[i].warehouse + '\n' + S.of(context).protax + ' : ' + repController.reportTaxsList.value[i].product_tax + '\n' + S.of(context).ordertax + ' : ' + repController.reportTaxsList.value[i].order_tax + '\n' + S.of(context).grand + ' : ' + repController.reportTaxsList.value[i].grand_total + '\n' + S.of(context).statue + ' : ' + repController.reportTaxsList.value[i].sale_status + '.';
                                                                                            final pdfFile = await PdfInvoiceApiReportTax.generate(repController.reportTaxsList.value[i], image, posController.languagee.value, '2');
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
                                                                                            ])),
                                                */ /*   topLeftCornerWidget: Center(
                                    child: Text(
                                      S.of(context).id,
                                      textAlign: TextAlign.center,
                                      style:
                                      TextStyle(color: Colors.white),
                                    )),*/ /*
                                              )*/
                                ),
                          ),
                        ),
                      ),
                      /* Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              color: Colors.white,
                              height: Get.height,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Obx(() =>
                                    repController.isLoadingP.value == true
                                        ? Center(
                                            child: Lottie.asset(
                                                'assets/images/loading.json',
                                                width: 90,
                                                height: 90),
                                          )
                                        : repController
                                                .reportTaxpList.value.isEmpty
                                            ? Container(
                                                width: Get.width,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 50, 10, 8.0),
                                                  child: Center(
                                                    child: Lottie.asset(
                                                        'assets/images/nodata.json',
                                                        height: 250,
                                                        width: 250),
                                                  ),
                                                ),
                                              )
                                            :   SfDataGridTheme(
                                        data: SfDataGridThemeData(
                                            headerColor: const Color(0xFF002e80)),
                                        child: SfDataGrid(
                                          source: repController.employeeDataSourceTaxP,
                                          columnWidthMode: ColumnWidthMode.auto,
                                          highlightRowOnHover: true,
                                          headerRowHeight: 65,
                                          gridLinesVisibility: GridLinesVisibility.both,
                                          headerGridLinesVisibility:
                                          GridLinesVisibility.both,
                                          columns: <GridColumn>[
                                            GridColumn(
                                                columnName: 'date',
                                                label: Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).date,
                                                      style: TextStyle(color: Colors.white),
                                                    ))),
                                            GridColumn(
                                                columnName: 'refe',
                                                label: Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).refno,
                                                      style: TextStyle(color: Colors.white),
                                                    ))),

                                            GridColumn(
                                                columnName: 'ware',
                                                label: Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).ware,
                                                      style: TextStyle(color: Colors.white),
                                                    ))),
                                            GridColumn(
                                                columnName: 'Biller',
                                                label: Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).bil,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(color: Colors.white),
                                                    ))),
                                            GridColumn(
                                                columnName: 'Productt',
                                                label: Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).protax,

                                                      style: TextStyle(color: Colors.white),
                                                    ))),
                                            GridColumn(
                                                columnName: 'ordert',
                                                label: Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).ordertax,
                                                      style: TextStyle(color: Colors.white),
                                                    ))),
                                            GridColumn(
                                                columnName: 'grand',
                                                label: Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      S.of(context).grand,
                                                      style: TextStyle(color: Colors.white),
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
                                        ))),
                              ),
                            ),
                          ),*/
                    ]),
              ),
            )
          ],
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

class EmployeeDataSourceTax extends DataGridSource {
  PosController posController = Get.put(PosController());

  /// Creates the employee data source class with required details.
  EmployeeDataSourceTax(
      {required var employeeData, required BuildContext contdext}) {
    con = contdext;

    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'refe', value: e.reference_no),
              DataGridCell<String>(columnName: 'ware', value: e.warehouse),
              DataGridCell<String>(columnName: 'Biller', value: e.biller),
              DataGridCell<String>(columnName: 'grand', value: e.grand_total),
              DataGridCell<String>(
                  columnName: 'Productt', value: e.product_tax),
              DataGridCell<String>(columnName: 'Status', value: e.sale_status),
              DataGridCell<String>(columnName: 'action', value: ''),
              DataGridCell<String>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'return_sale_ref', value: e.return_sale_ref),


            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  BuildContext? con;
  ReportController repController = Get.put(ReportController());

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
        child: Text( row.getCells()[6].value != 'returned'?row.getCells()[1].value.toString():
        row.getCells()[9].value.toString()),
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
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[4].value.toString().replaceAll('.0000', '')),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[5].value.toString()),
      ),
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: row.getCells()[6].value == 'completed'
                ? Colors.green.withOpacity(0.5)
                : row.getCells()[6].value == 'due'
                    ? Colors.red.withOpacity(0.5)
                    : Colors.orange.withOpacity(0.5),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Center(
              child: Text(
                row.getCells()[6].value == 'completed'
                    ? S.of(con!).paid
                    : row.getCells()[6].value == 'due'
                        ? S.of(con!).due
                        : S.of(con!).retur,
                textAlign: TextAlign.center,
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
              /*   final image =
              await imageFromAssetBundle('assets/images/logo.png');

              final pdfFile = await PdfInvoiceApiReportTax.generate(
                  row.getCells(), image, posController.languagee.value, '1');*/
              posController.printReport(
                  row.getCells()[8].value.toString(), '1', '0');
            } else {
              /* final image =
              await imageFromAssetBundle('assets/images/logo.png');

              final pdfFile = await PdfInvoiceApiReportTax.generate(
                  row.getCells(), image, posController.languagee.value, '2');*/
              posController.printReport(
                  row.getCells()[8].value.toString(), '2', '0');
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
  Future<void> handleLoadMoreRows() async {
    //   await Future.delayed(Duration(seconds: 5));

    repController.pageTax = repController.pageTax + 10;
    ReportTaxsResponse res;
    if (repController.searchMAinTax.text == '') {
      res = await ReportApiProvider()
          .getReportTaxs(repController.pageTax.toString());
    } else {
      Map<String, dynamic> dataId = ({
        "reference_no": repController.searchMAinTax.text,
      });
      res = await ReportApiProvider()
          .getReportTaxsSearch(repController.pageTax.toString(), dataId);
    }

    repController.reportTaxsListMore.clear();
    if (res.statuecode == 200) {
      repController.reportTaxsList.addAll(res.listRep);
      repController.reportTaxsListMore.addAll(res.listRep);

      for (int i = 0; i < repController.reportTaxsListMore.length; i++) {

        _employeeData.add(DataGridRow(cells: [
          DataGridCell<String>(columnName: 'date', value: repController.reportTaxsListMore[i].date),
          DataGridCell<String>(columnName: 'refe', value: repController.reportTaxsListMore[i].reference_no),
          DataGridCell<String>(columnName: 'ware', value: repController.reportTaxsListMore[i].warehouse),
          DataGridCell<String>(columnName: 'Biller', value: repController.reportTaxsListMore[i].biller),
          DataGridCell<String>(columnName: 'grand', value: repController.reportTaxsListMore[i].grand_total),
          DataGridCell<String>(
              columnName: 'Productt', value: repController.reportTaxsListMore[i].product_tax),
          DataGridCell<String>(columnName: 'Status', value: repController.reportTaxsListMore[i].sale_status),
          DataGridCell<String>(columnName: 'action', value: ''),
          DataGridCell<String>(columnName: 'id', value: repController.reportTaxsListMore[i].id),
          DataGridCell<String>(columnName: 'return_sale_ref', value: repController.reportTaxsListMore[i].return_sale_ref),


        ]));




      }
    }
  }

  @override
  Future<void> handleRefresh() async {
    repController.reportTaxsList.clear();
    repController.reportTaxsListMore.clear();

    repController.pageTax = 1;
    if (repController.searchMAinTax.text == '') {
      repController.getReportTaxs(con!);
    } else {
      repController.getReportTaxsSearch(
          con!);    }
    _employeeData = repController.reportTaxsList
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'date', value: e.date),
      DataGridCell<String>(columnName: 'refe', value: e.reference_no),
      DataGridCell<String>(columnName: 'ware', value: e.warehouse),
      DataGridCell<String>(columnName: 'Biller', value: e.biller),
      DataGridCell<String>(columnName: 'grand', value: e.grand_total),
      DataGridCell<String>(
          columnName: 'Productt', value: e.product_tax),
      DataGridCell<String>(columnName: 'Status', value: e.sale_status),
      DataGridCell<String>(columnName: 'action', value: ''),
      DataGridCell<String>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'return_sale_ref', value: e.return_sale_ref),

    ]))
        .toList();
    notifyListeners();
  }
}
