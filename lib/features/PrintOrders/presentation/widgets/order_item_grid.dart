import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_appp/core/routes/routes.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/order_item.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/show_update_status_dialog.dart';

import '../../../../core/methods/convert_address.dart';

class OrderDetailsCard extends StatefulWidget {
  final PrintOrderModel order;
  final bool isNoPrintOrderPage;

  const OrderDetailsCard({
    super.key,
    required this.order,
    required this.isNoPrintOrderPage,
  });

  @override
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Text('${'order_number'.tr()}: ${widget.order.orderNo ?? '-'}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${'branch'.tr()}: ${widget.order.branchId ?? '-'}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    InkWell(
                      onTap: () => context
                          .read<OrderCubit>()
                          .updateOrderStateOrderNo(id: widget.order.orderNo.toString()),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.yellowAccent,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  showUpdateStatusDialog(
                                    context,
                                    widget.order.orderNo.toString(),
                                    widget.isNoPrintOrderPage,
                                  );
                                });
                              },
                              child: Text('update'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                          ),
                        const  SizedBox(width:  20),
                          if (widget.isNoPrintOrderPage)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: widget.order.notAllowNegativeOutput!
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.order.notAllowNegativeOutput!
                                    ? 'closed'.tr()
                                    : 'marked_as_printed'.tr(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          Tooltip(
                            message: widget.order.notAllowNegativeOutput!
                                ? 'order_locked_message'.tr()
                                : 'order_editable_message'.tr(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    IconButton(
                      icon: const Icon(Icons.print, color: Colors.black),
                      onPressed: () =>


                          Navigator.pushNamed(
                        context,
                        Routes.printOrderScreen,
                        arguments: widget.order,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Divider(),

            Text('${PrintOrderModel.getStatusMessage(widget.order)}'),
            const Divider(),

            // Customer Info
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('${'customer'.tr()}: ${widget.order.customerName ?? '-'}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'phone'.tr()}: ${widget.order.customerPhone ?? '-'}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const Divider(),

            // Dates
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('${'order_date'.tr()}: ${formatDate(widget.order.orderDate)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                '${'delivery_date'.tr()}: ${formatDate(widget.order.deliveryDate)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const Divider(),

            // Order Summary
            ListTile(
              title: Text('${'value'.tr()}: ${formatValue(widget.order.totalValue)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'additions'.tr()}: ${formatValue(widget.order.additions)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${'discount'.tr()}: ${formatValue(widget.order.discount)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${'final_total'.tr()}: ${formatValue(widget.order.finalValue)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const Divider(),

            // Address
            if (widget.order.orderAddress != null &&
                widget.order.orderAddress!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text('delivery_address'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(context.locale == const Locale('en')?localizeAddressToString(context,widget.order.orderAddress!) :   widget.order.orderAddress!),
              ),

            const Divider(),

            // Payment
            ListTile(
              title: Text(
                '${'payment_method'.tr()}: ${widget.order.payId == 0 ? 'cash'.tr() : 'transfer'.tr()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${'paid_amount'.tr()}: ${formatValue(widget.order.payValue)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),

            const Divider(),

            // Products
            if (widget.order.orderItems != null && widget.order.orderItems!.isNotEmpty)
              ExpansionTile(
                title: Text('product_list'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                children: widget.order.orderItems!
                    .map((item) => _buildOrderItem(context, item))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat.yMMMd(context.locale.toString()).format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String formatValue(double? value) {
    if (value == null || value.isNaN) return '0.000 ${'currency_kwd'.tr()}';
    final formatter = NumberFormat("#,##0.000", context.locale.toString());
    return '${formatter.format(value)} ${'currency_kwd'.tr()}';
  }

  Widget _buildOrderItem(BuildContext context, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.itemId.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( item.itemArMame??'-' ,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(item.itemEnNAme ?? '-',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold)),

                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${'quantity'.tr()}: ${item.quantity ?? 0} ${ context.locale == const Locale('en')?item.unitEnName :  item.unitArName ?? ''}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatValue(item.price),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 2, color: Colors.grey),
        ],
      ),
    );
  }
}
