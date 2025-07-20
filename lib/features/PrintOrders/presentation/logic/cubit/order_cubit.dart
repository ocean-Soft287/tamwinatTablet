import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_appp/features/PrintOrders/Data/datasource/remote.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {


Map<String, dynamic> delivery = {
    'startDeliver'.tr() :'1',
    'prepare'.tr() : '2',
    'under_delivery'.tr() : '3',
    'delivered'.tr(): '4',
    };

  PrintOrdersRemoteDataSource remoteDataSource =
      PrintOrdersRemoteDataSourceImpl();
  OrderCubit() : super(OrderInitial());
  void getAllNotPRintedOrders() async {
    emit(OrderLoadingState());
    final result = await remoteDataSource.getAllNotPRintedOrders();
    result.fold((l) => emit(OrderErrorState(error: l)),
        (r) => emit(OrderSuccessState(orderModel: r)));
  
  }

  void getAllOrders() async {
    emit(OrderLoadingState());
    final result = await remoteDataSource.getAllOrders();
    result.fold((l) => emit(OrderErrorState(error: l)),
        (r) => emit(OrderSuccessState(orderModel: r)));
  }

  void updateOrderStateOrderNo({required String id}) async {
    emit(OrderLoadingState());
    final result = await remoteDataSource.pdateOrderStateOrderNo(id: id);
    result.fold((l) => emit(OrderErrorState(error: l)),
        (r) { 
                    Fluttertoast.showToast(msg: "تم تحديث حالة طباعةالفاتورة بنجاح");

          emit(UpdateOrderStateOrderNoSuccess());});
         getAllNotPRintedOrders();
  }


  void updateOrderState({required String orderNo, required String orderType,required bool isNoPrintOrderPage}) async {
    emit(UpdateOrderStateLoadingState());
    final result = await remoteDataSource.updateOrderState( orderNo: orderNo, orderType: orderType);
    result.fold((l) => emit(UpdateOrderStateFailedState(error: l)),
        (r) { 
          emit(UpdateOrderStateSuccessState( ));
          Fluttertoast.showToast(msg: 'the_request_was_updated_successfully'.tr());
        
                if(isNoPrintOrderPage){
             getAllNotPRintedOrders();
            }else {
             getAllOrders();
            }
        });
  }
}
