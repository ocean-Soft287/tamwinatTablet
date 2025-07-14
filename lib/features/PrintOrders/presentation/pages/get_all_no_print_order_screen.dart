import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/core/error/error_page.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_state.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/order_item_grid.dart';


class GetAllNoPrintOrderScreen extends StatefulWidget {
  const GetAllNoPrintOrderScreen({super.key});

  @override
  State<GetAllNoPrintOrderScreen> createState() =>
      _GetAllNoPrintOrderScreenState();
}

class _GetAllNoPrintOrderScreenState extends State<GetAllNoPrintOrderScreen> {
  late Timer _timer;
  final ScrollController _scrollController = ScrollController();

  int _itemsToShow = 10; 
  final int _loadMoreItemCount = 5;

  @override
  void initState() {
    if (mounted && !context.read<OrderCubit>().isClosed) {
      context.read<OrderCubit>().getAllNotPRintedOrders();
      _timer = Timer.periodic(const Duration(seconds: 60), (_) {
        context.read<OrderCubit>().getAllNotPRintedOrders();
      });
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more items
        setState(() {
          _itemsToShow += _loadMoreItemCount;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
title: Text('no_print_orders'.tr()),
          ),
          body: state is OrderSuccessState
              ?    _buildOrderList(state, context)
              :
               Center(
                  child: state is OrderErrorState
                      ?              ErrorStateWidget(errorMessage: state.error,onRetry: () => context.read<OrderCubit>().getAllNotPRintedOrders(),)

                      : const SizedBox(),
                ),
        );
      },
    );
  }

  Widget _buildOrderList(OrderSuccessState state, BuildContext context) {
    final allOrders = state.orderModel.reversed;

    final displayedOrders = allOrders
        .take(_itemsToShow)
        .toList();

    return ListView.builder(

      controller: _scrollController,
      itemCount: displayedOrders.length +
          (displayedOrders.length < allOrders.length ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < displayedOrders.length) {
          return OrderDetailsCard(order: displayedOrders[index],isNoPrintOrderPage: true,);
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  @override
  void deactivate() {
    _timer.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }
}