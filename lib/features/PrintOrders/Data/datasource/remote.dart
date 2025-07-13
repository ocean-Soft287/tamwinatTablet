import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_appp/core/network/Dio/cash_helper.dart';
import 'package:search_appp/features/PrintOrders/Data/models/print_order_model/print_order_model.dart';
import 'package:search_appp/core/network/Dio/api_consumer.dart';
import 'package:search_appp/core/network/Dio/dio_consumer.dart';
import 'package:search_appp/core/network/Dio/encrupt.dart';
import 'package:search_appp/core/network/Dio/endpoint.dart';

abstract class PrintOrdersRemoteDataSource {
  Future<Either<String, List<PrintOrderModel>>> getAllNotPRintedOrders();

  Future<Either<String, String>> pdateOrderStateOrderNo({required String id});
  Future<Either<String, String>> addToken({required String id});
  Future<Either<String, List<PrintOrderModel>>> getAllOrders();



  Future<Either<String, String>> updateOrderState({required String orderNo,required String orderType});
}

class PrintOrdersRemoteDataSourceImpl implements PrintOrdersRemoteDataSource {
  ApiConsumer apiConsumer = DioConsumer(dio: Dio());

  @override
  Future<Either<String, List<PrintOrderModel>>> getAllNotPRintedOrders() async {
    try {
      final res = await apiConsumer.get(
        Endpoint.getAllNotPRintedOrders,
      );
      final decryptedText = decrypt(res, privateKey, publicKey);
      //log(decryptedText);
      final json = jsonDecode(decryptedText) as List<dynamic>;
      final items = json.map((e) => PrintOrderModel.fromJson(e)).toList();
            log(json.toString());

      // for (var element in items) {
      //   log("${element.orderNo} x  prepare${element.prepare} .underDeliver ${element.underDeliver} . startDeliver ${element.startDeliver} . sendingOrder${element.sendingOrder}");
      // }
      return Right(items);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  
  }

  @override
  Future<Either<String, List<PrintOrderModel>>> getAllOrders() async {
    try {
      final res = await apiConsumer.get(
        Endpoint.getAllOrders,
      );
      final decryptedText = decrypt(res, privateKey, publicKey);
      final json = jsonDecode(decryptedText) as List<dynamic>;
      debugPrint(json.toString());
      final items = json.map((e) => PrintOrderModel.fromJson(e)).toList();
   for (var element in items) {
        log("${element.orderNo} x  prepare${element.prepare} .underDeliver ${element.underDeliver} . startDeliver ${element.startDeliver} . Delivered${element.Delivered}");
      }
      return Right(items);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> pdateOrderStateOrderNo(
      {required String id}) async {
    try {
      final res = await apiConsumer.get(
        Endpoint.updateOrderStateByOrderNo(id: id),
      );
      final decryptedText = decrypt(res, privateKey, publicKey);
      debugPrint(decryptedText);

      return const Right('Success');
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  
  }
  
  @override
  Future<Either<String, String>> addToken({required String id}) async{
     try {
     
      final res = await apiConsumer.get(
        Endpoint.addToken(id: id),
      );
      final decryptedText = decrypt(res, privateKey, publicKey) as String;
      log(decryptedText.toString());
     await CacheHelper.saveData(key: 'token', value: id);
      return const Right('Success');
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  
  }
  
  @override
  Future<Either<String, String>> updateOrderState({required String orderNo, required String orderType}) async{
   try {
     
      final res = await apiConsumer.get(
        Endpoint.upadteOrderState(orderNo: orderNo, orderType: orderType),
      );
      final decryptedText = decrypt(res, privateKey, publicKey) as String;
      log(decryptedText.toString());
      return const Right('Success');
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
   
  }
}
