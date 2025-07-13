import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/format.dart';
import 'package:share_plus/share_plus.dart';
class PdfHelper {
  static Future<void> convertWidgetToPdf(GlobalKey globalKey) async {
    final pdf = pw.Document();

    RenderRepaintBoundary? boundary =
    globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      return;
    }

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(pngBytes)),
          );
        },
      ),
    );

  
    await Printing.layoutPdf(
 format: const PdfPageFormat(58 * PdfPageFormat.mm, double.infinity),
       onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  static Future<void> convertWidgetToPdfAndSendToWhatsapp(GlobalKey globalKey) async {
    final pdf = pw.Document();

    RenderRepaintBoundary? boundary = globalKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      return;
    }


    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();


    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(pngBytes)),
          );
        },
      ),
    );


    final pdfBytes = await pdf.save();


    final tempDir = await getTemporaryDirectory();
    final tempFile = await File('${tempDir.path}/document.pdf').create();


    await tempFile.writeAsBytes(pdfBytes);


    await Share.shareXFiles(
      [XFile(tempFile.path)],
      text: 'Here is the PDF',
    );
  }


static Future<Uint8List> generateOrderPdf(PrintOrderModel order) async {

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(16),
          child: pw.ListView(
            children: [
              // Order Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('رقم الطلب: ${order.orderNo ?? '-'}'),
                  pw.Text('الفرع: ${order.branchId ?? '-'}'),
                ],
              ),
              pw.Divider(),

              // Customer Info
              pw.Text('العميل: ${order.customerName ?? '-'}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('الهاتف: ${order.customerPhone ?? '-'}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              // Dates
              pw.Text('تاريخ الطلب: ${formatDate(order.orderDate)}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('تاريخ التوصيل: ${formatDate(order.deliveryDate)}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              // Order Summary
              pw.Text('القيمة: ${formatValue(order.totalValue)}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('الإضافات: ${formatValue(order.additions)}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('الخصم: ${formatValue(order.discount)}'),
              pw.Text('الإجمالي النهائي: ${formatValue(order.finalValue)}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              // Delivery Address
              if (order.orderAddress != null && order.orderAddress!.isNotEmpty)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('عنوان التوصيل',
                        style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(order.orderAddress!),
                  ],
                ),
              pw.Divider(),

              // Payment Info
              pw.Text('طريقة الدفع: ${order.payId == 0 ? 'نقداً' : 'تحويل'}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('المبلغ المدفوع: ${formatValue(order.payValue)}',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              // Items Table
              pw.Text('قائمة المنتجات',
                  style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw. TableHelper.fromTextArray(
                context: context,
                cellStyle:  const pw.TextStyle(fontSize: 10),
                headers:  ['ID', 'المنتج', 'الكمية', 'السعر'],
                data: order.orderItems!
                    .map((item) => [
                          item.itemId.toString(),
                          '${item.itemArMame}\n${item.itemEnNAme}',
                          '${item.quantity} ${item.unitArName}',
                          formatValue(item.price),
                        ])
                    .toList(),
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}

static Future<void> generatePdfItem(PrintOrderModel order) async {
 await Printing.layoutPdf(
  format:const PdfPageFormat(58 * PdfPageFormat.mm, 200 * PdfPageFormat.cm) ,
  onLayout:(PdfPageFormat format) =>   generateOrderPdf(order, 
  ),
);
 
 
 
  }

}
