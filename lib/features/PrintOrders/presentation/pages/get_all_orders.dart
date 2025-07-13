import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/core/error/error_page.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_state.dart';
import 'package:search_appp/features/PrintOrders/presentation/widgets/order_item_grid.dart';

class GetAllOrders extends StatefulWidget {
  const GetAllOrders({super.key});

  @override
  State<GetAllOrders> createState() => _GetAllOrdersState();
}

class _GetAllOrdersState extends State<GetAllOrders> {
  final ScrollController _scrollController = ScrollController();

  int _itemsToShow = 5; // Initial number of items to show
  final int _loadMoreItemCount = 5; // Number of items to add on scroll

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more items when reaching the end
        setState(() {
          _itemsToShow += _loadMoreItemCount;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..getAllOrders(),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadingState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(                title: const Text('احصل على جميع الطلبات'),
elevation: 0, backgroundColor: Colors.white),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is OrderErrorState) {
            return Scaffold(
              appBar: AppBar(                title: const Text('احصل على جميع الطلبات'),
),
              body: ErrorStateWidget(errorMessage: state.error,onRetry: () => context.read<OrderCubit>().getAllOrders(),),
            );
          }

          if (state is OrderSuccessState) {
            final allOrders = state.orderModel.reversed; 
            // Limit the number of items shown initially
            final displayedOrders = allOrders  .take(_itemsToShow).toList();

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('احصل على جميع الطلبات'),
              ),
              body: 
              
               ListView.builder(
                controller: _scrollController,
                itemCount: displayedOrders.length +
                    (_itemsToShow < allOrders.length ? 1 : 0), // +1 for loader
                itemBuilder: (context, index) {
                  if (index < displayedOrders.length) {
                    return OrderDetailsCard(order: displayedOrders[index],isNoPrintOrderPage: false);
                  } else {
                    // Show loading indicator at the end
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),

            );
          }

          return const SizedBox();
        },
      ),
    );
  }

}