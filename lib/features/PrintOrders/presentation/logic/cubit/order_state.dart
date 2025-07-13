import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';

abstract class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class UpdateOrderStateOrderNoSuccess extends OrderState {}

final class OrderSuccessState extends OrderState {
  List<PrintOrderModel> orderModel;
  OrderSuccessState({required this.orderModel});
}

final class GetAllOrdersState extends OrderState {
  List<PrintOrderModel> orderModel;
  GetAllOrdersState({required this.orderModel});
}

final class OrderErrorState extends OrderState {
  String error;
  OrderErrorState({required this.error});
}
final class UpdateOrderStateLoadingState extends OrderState {}
final class UpdateOrderStateSuccessState extends OrderState {}

final class UpdateOrderStateFailedState extends OrderState {
   String error;
  UpdateOrderStateFailedState({required this.error}); 
}


