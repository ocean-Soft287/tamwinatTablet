import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/Home/Presentation/Screen/home_screen.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/features/PrintOrders/presentation/logic/cubit/order_cubit.dart';
import 'package:search_appp/features/PrintOrders/presentation/pages/get_all_no_print_order_screen.dart';
import 'package:search_appp/features/PrintOrders/presentation/pages/get_all_orders.dart';
import 'package:search_appp/features/PrintOrders/presentation/pages/print_order_screen.dart';
import 'package:search_appp/features/PrintOrders/presentation/pages/update_order_state_order_no.dart';
import 'package:search_appp/core/routes/routes.dart';
import 'package:search_appp/features/search/presentation/screen/search_screen.dart';

class AppRoutes {
  Route generateroute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.getAllNoPrintOrderScreen:
        return MaterialPageRoute(
          builder: (context) => 
          BlocProvider(create: (context)=>OrderCubit(),child:  const GetAllNoPrintOrderScreen())
          ,
        );

      case Routes.getAllOrders: 
        return MaterialPageRoute(
          builder: (context) => const GetAllOrders(),
        );

      case Routes.printOrderScreen: 
        return MaterialPageRoute(
          builder: (context) =>  PrintOrderScreen(order: settings.arguments as PrintOrderModel, ),
        
        );

      case Routes.updateOrderStateOrderNo:
        return MaterialPageRoute(
          builder: (context) => UpdateOrderStateOrderNo(
            orderid: settings.arguments as int,
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case Routes.search:
        return MaterialPageRoute(
          builder: (context) => SearchScreen(keyword: '',),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SizedBox(),
        );
    }
  }
}
