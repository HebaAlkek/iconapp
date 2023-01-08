import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icon/apiProvider/pdf_api.dart';
import 'package:icon/controller/pos_controller.dart';

import 'package:icon/model/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice, final img, String type,
      String ret, String currency) async {
    final pdf = Document();

    var arabicFont =
        Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));

    BytesBuilder byterBuilder = BytesBuilder();
    //seller name
    byterBuilder.addByte(1);
    List<int> sellerNameBytes = utf8.encode(invoice.supplier.companeName);
    byterBuilder.addByte(sellerNameBytes.length);
    byterBuilder.add(sellerNameBytes);

    // vat
    byterBuilder.addByte(2);
    List<int> vatRegisterBytes = utf8.encode(invoice.posItem.cf_value1);
    byterBuilder.addByte(vatRegisterBytes.length);
    byterBuilder.add(vatRegisterBytes);
    //time
    byterBuilder.addByte(3);
    List<int> timeBytes = utf8.encode(invoice.invItem.date);
    byterBuilder.addByte(timeBytes.length);
    byterBuilder.add(timeBytes);
    //total
    byterBuilder.addByte(4);
    List<int> totalBytes = utf8.encode(invoice.invItem.grand_total);
    byterBuilder.addByte(totalBytes.length);
    byterBuilder.add(totalBytes);
    //vat amount
    byterBuilder.addByte(5);
    List<int> vatBytes = utf8.encode(invoice.invItem.product_tax);
    byterBuilder.addByte(vatBytes.length);
    byterBuilder.add(vatBytes);
    Uint8List qrcodde = byterBuilder.toBytes();
    final Base64Encoder b64Encode = Base64Encoder();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, img, arabicFont),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),

        buildInfo(invoice, arabicFont, ret),
        SizedBox(height: 20),
        Divider(),
        SizedBox(height: 10),

        buildTitle(invoice, arabicFont),
        //,   buildInvoice(invoice, arabicFont),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 18),

        InvInfo(invoice, arabicFont, currency),
        SizedBox(height: 20),
        Divider(),
        SizedBox(height: 10),
        pw.Center(
          child: Text(invoice.invItem.note.toString(),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                  font: arabicFont,
                  fontSize: 33)),
        ),
        pw.Center(
          child: Text(invoice.supplier.invoicefooter.toString(),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                  font: arabicFont,
                  fontSize: 33)),
        ),
        SizedBox(height: 10),

        SizedBox(height: 10),
        pw.Center(
          child: Container(
              height: 200,
              width: 200,
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: b64Encode.convert(qrcodde),
              )),
        ),
        SizedBox(height: 10),
        pw.Center(
          child: Container(
              height: 100,
              width: 200,
              child: BarcodeWidget(
                padding: pw.EdgeInsets.all(5),
                textPadding: 6,
                drawText: false,
                barcode: Barcode.code128(),
                data: invoice.invItem.reference_no,
              )),
        ),
        SizedBox(height: 10),

        /*  pw.Center(
            child: pw.Text('Thank you for shopping with us. Please come again.',
                textAlign: TextAlign.center,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 33)))*/

        // buildTotal(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));
    if (type == '1') {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } else {
      await Printing.sharePdf(bytes: await pdf.save(), filename: 'Report.pdf');
    }
    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, final img, var ara) => pw.Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Image(img, width: 300, height: 300),
          SizedBox(height: 3),
          buildSupplierAddress(invoice, ara),
          SizedBox(height: 10),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      ));

  static Widget buildInfo(Invoice inv, var ara, String ret) =>
      pw.Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                    ret != '1' ? 'VAT Sales Invoice' : 'VAT Sales Return',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                        fontSize: 50)),
              ),
              SizedBox(height: 3),
              pw.Center(
                  child: pw.Text(
                      ret != '1'
                          ? 'فاتورة ضريبية مبسطة'
                          : 'فاتورة مرتجع مبيعات',
                      textDirection: TextDirection.rtl,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                          fontSize: 50,
                          font: ara))),
              SizedBox(height: 10),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(inv.invItem.date,
                        style: TextStyle(
                          fontSize: 40,
                          font: ara,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl),
                    Text('تاريخ الفاتورة : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            font: ara),
                        textDirection: TextDirection.rtl),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(inv.invItem.reference_no,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            font: ara),
                        textDirection: TextDirection.rtl),
                    Text('رقم الفاتورة : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            font: ara),
                        textDirection: TextDirection.rtl),
                  ]),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(inv.invItem.delivery_date,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            font: ara),
                        textDirection: TextDirection.rtl),
                    Text('تاريخ التوصيل : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            font: ara),
                        textDirection: TextDirection.rtl),
                  ]),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(inv.saleUser.first_name + ' ' + inv.saleUser.last_name,
                        style: TextStyle(fontSize: 40, font: ara),
                        textDirection: TextDirection.rtl),
                    Text('اسم البائع : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            font: ara),
                        textDirection: TextDirection.rtl),
                  ]),
              SizedBox(height: 1 * PdfPageFormat.mm),
              inv.posItem.customer_details == '1' ? Divider() : Text(''),
              inv.posItem.customer_details == '1'
                  ? Column(children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(inv.customerSale.name,
                                style: TextStyle(fontSize: 40, font: ara),
                                textDirection: TextDirection.rtl),
                            Text('العميل : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                    font: ara),
                                textDirection: TextDirection.rtl),
                          ]),
                      SizedBox(height: 1 * PdfPageFormat.mm),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(inv.customerSale.phone,
                                style: TextStyle(fontSize: 40, font: ara),
                                textDirection: TextDirection.rtl),
                            Text('الهاتف : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                    font: ara),
                                textDirection: TextDirection.rtl),
                          ]),
                      SizedBox(height: 1 * PdfPageFormat.mm),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(inv.customerSale.address,
                                style: TextStyle(fontSize: 40, font: ara),
                                textDirection: TextDirection.rtl),
                            Text('العنوان : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                    font: ara),
                                textDirection: TextDirection.rtl),
                          ]),
                      SizedBox(height: 1 * PdfPageFormat.mm),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                inv.customerSale.country +
                                    ' ' +
                                    inv.customerSale.state +
                                    ' ' +
                                    inv.customerSale.city,
                                style: TextStyle(fontSize: 40, font: ara),
                                textDirection: TextDirection.rtl),
                          ]),
                      SizedBox(height: 1 * PdfPageFormat.mm),
                    ])
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Text(inv.customerSale.name,
                              style: TextStyle(fontSize: 40, font: ara),
                              textDirection: TextDirection.rtl),
                          Text('العميل : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  font: ara),
                              textDirection: TextDirection.rtl),
                        ]),
            ],
          ));

  static Widget InvInfo(Invoice inv, var arabicFont, String currency) =>
      pw.Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        inv.invItem.total.split('.')[0] +
                            '.' +
                            inv.invItem.total.split('.')[1].substring(0, 2) +
                            ' ' +
                            currency,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            font: arabicFont),
                        textDirection: TextDirection.rtl),
                    Text('السعر بدون ضريبة : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 33,
                            font: arabicFont),
                        textDirection: TextDirection.rtl),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        inv.invItem.product_tax.split('.')[0] +
                            '.' +
                            inv.invItem.product_tax
                                .split('.')[1]
                                .substring(0, 2) +
                            ' ' +
                            currency,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            font: arabicFont),
                        textDirection: TextDirection.rtl),
                    Text('قيمة الضريبة : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 33,
                            font: arabicFont),
                        textDirection: TextDirection.rtl),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        inv.invItem.grand_total.split('.')[0] +
                            '.' +
                            inv.invItem.grand_total
                                .split('.')[1]
                                .substring(0, 2) +
                            ' ' +
                            currency,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            font: arabicFont),
                        textDirection: TextDirection.rtl),
                    Text('المجموع العام : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 33,
                            font: arabicFont),
                        textDirection: TextDirection.rtl),
                  ]),
              SizedBox(height: 1 * PdfPageFormat.mm),
            ],
          ));

  static Widget buildSupplierAddress(Invoice inv, var ara) => pw.Directionality(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            inv.supplier.companeName,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 40, font: ara),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(
              inv.supplier.address +
                  ' ' +
                  inv.supplier.country +
                  ' ' +
                  inv.supplier.city,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 33, font: ara)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  inv.supplier.tel,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33, font: ara),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  'الهاتف : ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33, font: ara),
                  textDirection: TextDirection.rtl,
                ),
              ]),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  inv.posItem.cf_value1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33, font: ara),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  inv.posItem.cf_title1 + ' : ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33, font: ara),
                  textDirection: TextDirection.rtl,
                ),
              ]),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  inv.posItem.cf_value2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33, font: ara),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  inv.posItem.cf_title2 + ' : ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 33, font: ara),
                  textDirection: TextDirection.rtl,
                ),
              ]),
        ],
      ),
      textDirection: TextDirection.rtl);

  static Widget buildTitle(Invoice invoice, var ara) => ListView.builder(
      itemCount: invoice.products.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.all(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(invoice.products[index].second_name,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 33,
                    font: ara,
                  )),
              /*     : lang.toString() == 'both'
                              ? Column(
                          crossAxisAlignment:lang=='en'? CrossAxisAlignment.start:CrossAxisAlignment.end,
                                  children: [
                                      Text(invoice.products[index].product_name,                              textDirection: TextDirection.rtl,

                                          style: TextStyle(
                                            fontSize: 33,                                font: ara,

                                          )),
                                      SizedBox(height: 10),
                                      Text(invoice.products[index].second_name,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 33,
                                            font: ara,
                                          ))
                                    ])
                              : Text(invoice.products[index].product_name,                              textDirection: TextDirection.rtl,

                          style: TextStyle(
                                    fontSize: 33,                                font: ara,

                                  )),*/
              SizedBox(height: 2),
              SizedBox(height: 10),
              Text(
                  invoice.products[index].quantity.split('.')[0] +
                      ' pc * ' +
                      (invoice.products[index].net_unit_price.split('.')[0] +
                          '.' +
                          invoice.products[index].net_unit_price
                              .split('.')[1]
                              .substring(0, 2)),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 33,
                    font: ara,
                    fontWeight: FontWeight.bold,
                  )),
              Row(children: [
                Text(
                  invoice.products[index].subtotal.split('.')[1].length > 2
                      ? invoice.products[index].subtotal.split('.')[0] +
                          '.' +
                          invoice.products[index].subtotal
                              .split('.')[1]
                              .substring(0, 2)
                      : invoice.products[index].subtotal.split('.')[0] +
                          '.' +
                          invoice.products[index].subtotal
                              .split('.')[1]
                              .substring(0, 1),
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                new Spacer(),
                Text('[ضريبة',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 33, font: ara, fontWeight: FontWeight.bold)),
                Text('(Vat',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 33, font: ara, fontWeight: FontWeight.bold)),
                Text(invoice.products[index].tax,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 33, font: ara, fontWeight: FontWeight.bold)),
                Text(')',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 33, font: ara, fontWeight: FontWeight.bold)),
                Text(
                    (invoice.products[index].item_tax.split('.')[0] +
                        '.' +
                        invoice.products[index].item_tax
                            .split('.')[1]
                            .substring(0, 2)),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 33, font: ara, fontWeight: FontWeight.bold)),
                Text(']',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 33, font: ara, fontWeight: FontWeight.bold)),
              ]),
              SizedBox(height: 10),
              Divider(color: PdfColors.grey300)
            ]));
      });
}
