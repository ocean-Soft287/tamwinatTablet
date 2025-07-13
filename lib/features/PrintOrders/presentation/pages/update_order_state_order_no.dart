import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_state.dart';

class UpdateOrderStateOrderNo extends StatelessWidget {
  final int orderid;
  const UpdateOrderStateOrderNo({super.key, required this.orderid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            OrderCubit()..updateOrderStateOrderNo(id: orderid.toString()),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(''),
          ),
          body: BlocConsumer<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OrderErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is UpdateOrderStateOrderNoSuccess) {
                  return const Center(
                    child: Text('تم تحديث حالة الطلب بنجاح'),
                  );
                } else {
                  return const Center(
                    child: SizedBox(),
                  );
                }
              },
              listener: (context, state) {}),
        ));
  }
}
