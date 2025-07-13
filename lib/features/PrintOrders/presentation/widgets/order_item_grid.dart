import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:search_appp/core/routes/routes.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/order_item.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/show_update_status_dialog.dart';

class OrderDetailsCard extends StatefulWidget {
  final PrintOrderModel order;
  final bool isNoPrintOrderPage;

  const OrderDetailsCard({super.key, required this.order, required this.isNoPrintOrderPage});

  @override
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
     final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'en', symbol: 'د.ك ');

    return Card(
         elevation: 4,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: ListView(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             children: [
               // Order Number
             
               
                 Column(
                              children: [
                    Text('رقم الطلب: ${widget.order.orderNo ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('الفرع: ${widget.order.branchId ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold)),
          
         
                    Row(
                     children: [
                 
                   InkWell(
                     onTap: () => context.read<OrderCubit>(). updateOrderStateOrderNo(id:widget.order.orderNo.toString())
            //             Navigator.pushNamed(context, Routes.updateOrderStateOrderNo,
            // arguments:widget. order.orderNo
            // )
     ,
                     child:
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 30,
  children: [
    SizedBox(width: 10.w,),
//,
  Container(
    decoration: const BoxDecoration(
      color: Colors.yellowAccent,borderRadius: BorderRadius.all(Radius.circular(12))),
                child: TextButton(onPressed: (){

                 
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                    showUpdateStatusDialog(context,widget.order.orderNo.toString(),widget.isNoPrintOrderPage);
                      
                    });

                  
                
                }, child: const Text('تحديث',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),
              )
            

   ,!widget.isNoPrintOrderPage ? const SizedBox()  :Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: widget.order.notAllowNegativeOutput! ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.order.notAllowNegativeOutput! ? 'مغلق' : ' تمميز الطلب كمطبوع',
        style: const TextStyle(color: Colors.white),
      ),
    ),
    Tooltip(
      message: widget.order.notAllowNegativeOutput!
          ? 'هذا الطلب مغلق ولا يمكن تعديله أو طباعته'
          : 'يمكن تعديل هذا الطلب أو طباعته',
    ),
  ],
)),
                     SizedBox(width: 10.w,),
                 
                   IconButton(
          icon: const Icon(
            Icons.print,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pushNamed(context, Routes.printOrderScreen,arguments: widget.order),
      )   
                  
               ],
                ),
                              
                              ],
                 ),
             
       
               const Divider(),
               //control Update  Order Status
              
            
               // Order Status
                  Text(
                ' ${PrintOrderModel.getStatusMessage(widget.order)}'),
                    const Divider(),

              
               // Customer Info
               ListTile(
                 leading: const Icon(Icons.person),
                 title: Text('العميل: ${widget.order.customerName ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold)),
                 subtitle: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                  //   Text('الاسم الإنجليزي: ${widget.order.customerEnName ?? '-'}'),
                     Text('الهاتف: ${widget.order.customerPhone ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold)),
                   ],
                 ),
               ),
       
               const Divider(),
       
               // Dates
               ListTile(
                 leading: const Icon(Icons.calendar_today),
                 title: Text('تاريخ الطلب: ${formatDate(widget.order.orderDate)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                 subtitle:
                     Text('تاريخ التوصيل: ${formatDate(widget.order.deliveryDate)}',style: const TextStyle(fontWeight: FontWeight.bold)),
               ),
       
               const Divider(),
       
               // Order Summary
               ListTile(
                 title: Text(
                     'القيمة: ${formatValue(widget.order.totalValue)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                 subtitle: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                         'الإضافات: ${formatValue(widget.order.additions)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                     Text(
                         'الخصم: ${formatValue(widget.order.discount)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                     Text(
                         'الإجمالي النهائي: ${formatValue(widget.order.finalValue)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                   ],
                 ),
               ),
       
               const Divider(),
       
               // Delivery Address
               if (widget.order.orderAddress != null && widget.order.orderAddress!.isNotEmpty)
                 ListTile(
                   leading: const Icon(Icons.location_on),
                   title: const Text('عنوان التوصيل',style:  TextStyle(fontWeight: FontWeight.bold)),
                   subtitle: Text(widget.order.orderAddress!),
   ),
       
               const Divider(),
       
               // Payment Info
               ListTile(
                 title: Text(
                     'طريقة الدفع: ${widget.order.payId == 0 ? 'نقداً' : 'تحويل'}',style: const TextStyle(fontWeight: FontWeight.bold)),
                 subtitle: Text(
                     'المبلغ المدفوع: ${formatValue(widget.order.payValue)}',style: const TextStyle(fontWeight: FontWeight.bold)),
               ),
       
               const Divider(),
       
               // Items List
               if (widget.order.orderItems != null && widget.order.orderItems!.isNotEmpty)
                 ExpansionTile(
                   title: const Text('قائمة المنتجات',style:  TextStyle(fontWeight: FontWeight.bold)),
                   children: widget.order.orderItems!
                       .map((item) => _buildOrderItem(context, item))
                       .toList(),
                 )
             ],
           ),
         ),
       );
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat.yMMMd().format(date);
    } catch (e) {
      return dateStr;
    }
  }

   String formatValue(double? value) {
  if (value == null || value.isNaN) {
    return '0.000 د.ك';
  }

  // Always show 3 decimal places
  final formatter = NumberFormat("#,##0.000", "en");
  return '${formatter.format(value)} د.ك';
}


  Widget _buildOrderItem(BuildContext context, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.itemId.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.itemArMame ?? '-',
                        maxLines: 2, overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(item.itemEnNAme ?? '-',
                        style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
           
                Column(
                  children: [
                    Text(
                        'الكمية: ${item.quantity ?? 0} ${item.unitArName ?? ''} ',
                        textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),),
                                 
                     Text(
                        formatValue(item.price
                            ?.toDouble()
                            
                            
                            
                           
                             ),
                        textAlign: TextAlign.right,style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
           
           
            ],
          ),
             const SizedBox(height: 10,),
                 Container( height: 2,color: Colors.grey,),

        ],
      ),
   
    );
  }
}
