import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/search/Data/search_remote_data_source.dart';
import 'package:search_appp/features/search/model/search_result.dart';
import 'package:search_appp/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRemoteDataSource searchRemoteDataSource = SearchRemoteDataSourceImp();
  SearchCubit() : super(InitalizeSearchState());

  List<ProductModel> searchDataList = [];
  void getSearch({required String search})async {
    emit(SearchLoadingState());
 final res = await   searchRemoteDataSource.search(key: search);
     
  
  res.fold((ifLeft)=> emit(SearchErrorState(message: ifLeft)), (ifRight){
    searchDataList = ifRight;
    emit(SearchSuccessState(products: ifRight));});
   
  
  }



  // String? scannedValue;

  // void setScannedValue(String value) {
  //   scannedValue = value;
  // }
}
