import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:search_appp/core/network/Dio/api_consumer.dart';
import 'package:search_appp/core/network/Dio/dio_consumer.dart';
import 'package:search_appp/core/network/Dio/encrupt.dart';
import 'package:search_appp/core/network/Dio/endpoint.dart';
import 'package:search_appp/features/search/model/search_result.dart';

abstract class SearchRemoteDataSource {
  
  Future<Either<String, List<ProductModel>>> search({required String key});

  Future<Either<String, List<ProductModel>>> searchbykeyword({required String key});


}
class SearchRemoteDataSourceImp extends SearchRemoteDataSource{
  ApiConsumer apiConsumer = DioConsumer(dio: Dio());


  @override
  Future<Either<String, List<ProductModel>>> search({required String key})async {
    try {
      final res  = await apiConsumer.get(Endpoint.search(search: key));
       final res2  = await apiConsumer.get(Endpoint.searchbykeyword( searchKey: key));
       final decryptedText = decrypt(res, privateKey, publicKey);
       final decryptedText2 = decrypt(res2, privateKey, publicKey);
       final list = json.decode(decryptedText) as List<dynamic>;
       final list2 = json.decode(decryptedText2) as List<dynamic>;
       final List<ProductModel> data = list.map((item) => ProductModel.fromJson(item)).toList();
     final List<ProductModel> data2 = list2.map((item) => ProductModel.fromJson(item)).toList();
      if(data.isEmpty){
        return Right(data2);
      }
      return Right(data);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
    
  }



  @override
  Future<Either<String, List<ProductModel>>> searchbykeyword({required String key})async {
    try {
      final res  = await apiConsumer.get(Endpoint.searchbykeyword( searchKey: key));
      final decryptedText = decrypt(res, privateKey, publicKey);
      final list = json.decode(decryptedText) as List<dynamic>;
      final List<ProductModel> data = list.map((item) => ProductModel.fromJson(item)).toList();

      return Right(data);
    } on DioException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }

  }
}