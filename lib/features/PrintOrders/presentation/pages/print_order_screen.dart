import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/core/printer/print_helper.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/order_item_for_print.dart';

class PrintOrderScreen extends StatelessWidget {
  final PrintOrderModel order;
   PrintOrderScreen({super.key,required this.order});
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.print,
              size: 40,
              color: Colors.white,
            ),
             onPressed: () =>PdfHelper.convertWidgetToPdf(globalKey) // PdfHelper.generatePdfItem(order), //,
        )
               ,   SizedBox(width: 10.w,),

        ],
        elevation: 0,
        title: const Text('طباعة الطلب'),
      ),
      body:       SingleChildScrollView(child: RepaintBoundary(key: globalKey,child: OrderItemForPrint(order: order))),
    
    
    );
      
    
    
  
  }

}

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// // Your model and widgets imports
// import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/order_item.dart';
// import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
// import 'package:search_appp/features/PrintOrders/presentation/widgets/order_item_for_print.dart';

// class PrintOrderScreen extends StatelessWidget {
//   final PrintOrderModel order;

//   const PrintOrderScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تفاصيل الطلب'),
//         actions: [
//           TextButton(
//             child:const Text('حفظ',style: TextStyle(color: Colors.white),),
//             onPressed: () async => await _savePdf(context),
//           ),
//         TextButton(
//           onPressed: ()async{
//               final pdfBytes = await generatePdf(order);
//   final printers =await Printing.listPrinters();
//     final printed = await Printing.directPrintPdf(
//       printer:printers.first,
//       name: '${order.orderNo}.pdf',
//       onLayout: (_) => pdfBytes,
//     );

//     if (printed == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تمت الطباعة بنجاح')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('فشل في الطباعة')),
//       );
//     }
//         }, child: const Text('طباعة',style: TextStyle(color: Colors.white),))
       
//         ],
//       ),
//       body: OrderItemForPrint(order: order),
//     );
//   }

//   Future<void> _savePdf(BuildContext context) async {
//               final pdfBytes = await generatePdf(order);
    
//       final dir = await getApplicationDocumentsDirectory();
//       final file = File('${dir.path}/order_${order.orderNo}.pdf');
//       await file.writeAsBytes(pdfBytes); // Save as file
    
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('PDF saved at ${file.path}')),
//       );
      
//   }
   

//   Future<Uint8List> generatePdf(PrintOrderModel order) async {
//     final formatCurrency = NumberFormat.currency(locale: 'en', symbol: 'د.ك ');

//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         margin: const pw.EdgeInsets.all(30),
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Order Number & Branch
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('رقم الطلب: ${order.orderNo ?? '-'}'),
//                   pw.Text('الفرع: ${order.branchId ?? '-'}'),
//                 ],
//               ),
//               pw.SizedBox(height: 15),

//               // Customer Info
//               pw.Divider(),
//               pw.Text('العميل: ${order.customerName ?? '-'}'),
//               pw.Text('الاسم الإنجليزي: ${order.customerEnName ?? '-'}'),
//               pw.Text('الهاتف: ${order.customerPhone ?? '-'}'),
//               pw.SizedBox(height: 15),

//               // Dates
//               pw.Divider(),
//               pw.Text('تاريخ الطلب: ${formatDate(order.orderDate)}'),
//               pw.Text('تاريخ التوصيل: ${formatDate(order.deliveryDate)}'),
//               pw.SizedBox(height: 15),

//               // Order Summary
//               pw.Divider(),
//               pw.Text('القيمة: ${formatValue(order.totalValue, formatCurrency)}'),
//               pw.Text('الإضافات: ${formatValue(order.additions, formatCurrency)}'),
//               pw.Text('الخصم: ${formatValue(order.discount, formatCurrency)}'),
//               pw.Text('الإجمالي النهائي: ${formatValue(order.finalValue, formatCurrency)}'),
//               pw.SizedBox(height: 15),

//               // Delivery Address
//               if (order.orderAddress != null && order.orderAddress!.isNotEmpty)
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text('عنوان التوصيل'),
//                     pw.Text(order.orderAddress!),
//                   ],
//                 ),

//               // Payment Info
//               pw.Divider(),
//               pw.Text('طريقة الدفع: ${order.payId == 0 ? 'نقداً' : 'تحويل'}'),
//               pw.Text('المبلغ المدفوع: ${formatValue(order.payValue, formatCurrency)}'),

//               // Items List
//               if (order.orderItems != null && order.orderItems!.isNotEmpty)
//                 pw.Divider(),
//               pw.Text('قائمة المنتجات'),
//               ...order.orderItems!
//                   .map((item) => _buildPdfOrderItem(item, formatCurrency))
//                   .toList(),
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }

//   String formatDate(String? dateStr) {
//     if (dateStr == null || dateStr.isEmpty) return '-';
//     try {
//       final DateTime date = DateTime.parse(dateStr);
//       return DateFormat.yMMMd().format(date);
//     } catch (e) {
//       return dateStr;
//     }
//   }

//   String formatValue(double? value, NumberFormat currencyFormat) {
//     if (value == null) return '0.000 د.ك';
//     return currencyFormat.format(value);
//   }

//   pw.Widget _buildPdfOrderItem(OrderItem item, NumberFormat currencyFormat) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.symmetric(vertical: 4),
//       child: pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Expanded(
//             flex: 3,
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(item.itemArMame ?? '-', maxLines: 2),
//                 pw.Text(item.itemEnNAme ?? '', style: pw.TextStyle(color: PdfColors.grey600)),
//               ],
//             ),
//           ),
//           pw.Expanded(
//             flex: 1,
//             child: pw.Text(
//               'الكمية: ${item.quantity ?? 0} ${item.unitArName ?? ''}',
//               textAlign: pw.TextAlign.center,
//             ),
//           ),
//           pw.Expanded(
//             flex: 1,
//             child: pw.Text(
//               formatValue(item.price, currencyFormat),
//               textAlign: pw.TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }





// }
