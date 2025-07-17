import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/search/Data/search_remote_data_source.dart';
import 'package:search_appp/features/search/model/search_result.dart';
import 'package:search_appp/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRemoteDataSource searchRemoteDataSource = SearchRemoteDataSourceImp();
  SearchCubit() : super(InitalizeSearchState());

  List<ProductModel> searchDataList = [];
  Future<void> getSearch({required String search})async {
    emit(SearchLoadingState());
    Timer(const Duration(milliseconds:800 ),()async{
      final res = await searchRemoteDataSource.search(key: search);
      res.fold((ifLeft) => emit(SearchErrorState(message: ifLeft)), (ifRight) {

        searchDataList = ifRight;
        emit(SearchSuccessState(products: ifRight));

      });
    });
  }

  Future<void> getSearchkeyword({required String search})async {
    emit(SearchLoadingState());
    Timer(const Duration(milliseconds: 0),()async{
      final res = await   searchRemoteDataSource.searchbykeyword(key: search);

      res.fold((ifLeft)=> emit(SearchErrorState(message: ifLeft)), (ifRight){
        searchDataList = ifRight;
        emit(SearchSuccessState(products: ifRight));});

    });


  }


  // String? scannedValue;

  // void setScannedValue(String value) {
  //   scannedValue = value;
  // }
}
