import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';


void showUpdateStatusDialog(BuildContext context, String orderNo,bool isNoPrintOrderPage ) {
  final List<String> statusOptions = [
    'startDeliver',
    'prepare',
    'under_delivery',
    'delivered',
  ];

  showDialog(
    context: context,
    builder: (contextbuilder) => SimpleDialog(
      title: const Text('اختر حالة الطلب'),
      children: statusOptions.map((option) {
        return ListTile(
          title: Text(option.tr()),
          onTap: () {
            context.read<OrderCubit>().updateOrderState(
                  isNoPrintOrderPage: isNoPrintOrderPage,
                  orderNo: orderNo,
                  orderType: context.read<OrderCubit>().delivery[option.tr()],
                );
    
            Navigator.pop(context);
          },
        );
      }).toList(),
    ),
  );
}