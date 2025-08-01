// ignore_for_file: unnecessary_string_interpolations

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/order_item.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/format.dart';

class OrderItemForPrint extends StatefulWidget {
  final PrintOrderModel order;

  const OrderItemForPrint({super.key, required this.order});

  @override
  State<OrderItemForPrint> createState() => _OrderItemForPrintState();
}

class _OrderItemForPrintState extends State<OrderItemForPrint> {
    late final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'en', symbol: '${'currency_kwd'.tr()}');

    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
           elevation: 4,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
           child: Padding(
             padding: const EdgeInsets.all(0.0),
             child: ListView(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               children: [
                 // Order Number
               
                 
                   Column(
                                children: [

                      Text('${'order_number'.tr()}: ${widget.order.orderNo ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold),),
                      Text('${'branch'.tr()}: ${widget.order.branchId ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold)),
            
              
               ],
                   ),
               
         
                 const Divider(),
         
                 // Customer Info
                 ListTile(
                   leading: const Icon(Icons.person),
                   title: Text('${'customer'.tr()}: ${widget.order.customerName ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold),),
                   subtitle: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                    //   Text('الاسم الإنجليزي: ${widget.order.customerEnName ?? '-'}'),
                       Text('${'phone'.tr()}: ${widget.order.customerPhone ?? '-'}',style: const TextStyle(fontWeight: FontWeight.bold)),
                     ],
                   ),
                 ),
         
                 const Divider(),
         
                 // Dates
                 ListTile(
                   leading: const Icon(Icons.calendar_today),
                   title: Text('${'order_date'.tr()}: ${formatDate(widget.order.orderDate)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                   subtitle:
                       Text('${'delivery_date'.tr()}: ${formatDate(widget.order.deliveryDate)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                 ),
         
                 const Divider(),
         
                 // Order Summary
                 ListTile(
                   title: Text(
                       '${'value'.tr()}: ${formatValue(widget.order.totalValue)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                   subtitle: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                           '${'additions'.tr()}: ${formatValue(widget.order.additions)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                       Text(
                           '${'discount'.tr()}: ${formatValue(widget.order.discount)}'),
                       Text(
                           '${'final_total'.tr()}: ${formatValue(widget.order.finalValue)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                     ],
                   ),
                 ),
         
                 const Divider(),
         
                 // Delivery Address
                 if (widget.order.orderAddress != null && widget.order.orderAddress!.isNotEmpty)
                   ListTile(
                     leading: const Icon(Icons.location_on),
                     title:  Text('delivery_address'.tr(),style:  const TextStyle(fontWeight: FontWeight.bold)),
                     subtitle: Text(widget.order.orderAddress!,style: const TextStyle(fontWeight: FontWeight.bold)),
                   ),
         
                 const Divider(),
                 
         
                 // Payment Info
                 ListTile(
                   title: Text(
                       '${'payment_method'.tr()}: ${widget.order.payId == 0 ? 'cash'.tr() : 'transfer'.tr()}',style: const TextStyle(fontWeight: FontWeight.bold)),
                   subtitle: Text(
                       '${'paid_amount'.tr()}: ${formatValue(widget.order.payValue,)}',style: const TextStyle(fontWeight: FontWeight.bold)),
                 ),
         
                 const Divider(),
         
                 // Items List
                 if (widget.order.orderItems != null && widget.order.orderItems!.isNotEmpty)
                   ExpansionTile(
                    
                    initiallyExpanded: true,
                     title:  Text('${'product_list'.tr()}',style:  const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                     children: widget.order.orderItems!
                         .map((item) => _buildOrderItem(context, item))
                         .toList(),
                   )
               ],
             ),
           ),
         ),
    );
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
                        '${'quantity'.tr()}: ${item.quantity ?? 0} ${item.unitArName ?? ''} ',
                        textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),),
                                 
                     Text(
                        formatValue(item.price,
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
