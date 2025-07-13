import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:search_appp/core/network/Dio/api_consumer.dart';
import 'package:search_appp/core/network/Dio/dio_consumer.dart';
import 'package:search_appp/core/network/Dio/encrupt.dart';
import 'package:search_appp/core/network/Dio/endpoint.dart';

abstract class SearchRemoteDataSource {
    Future<Either<String, List<dynamic>>> search({required String key});

}
class SearchRemoteDataSourceImp extends SearchRemoteDataSource{
  ApiConsumer apiConsumer = DioConsumer(dio: Dio());


  @override
  Future<Either<String, List<dynamic>>> search({required String key})async {
    try {
       final res  = await apiConsumer.get(Endpoint.search(search: key));

      final decryptedText = decrypt(res, privateKey, publicKey);
      log(decryptedText);
      final data = (json.decode(decryptedText)).map((item) => item as List<dynamic>);
      return Right(data);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
    
  }


}