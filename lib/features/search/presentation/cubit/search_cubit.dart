import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_appp/features/search/Data/search_remote_data_source.dart';
import 'package:search_appp/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRemoteDataSource searchRemoteDataSource = SearchRemoteDataSourceImp();
  SearchCubit() : super(InitalizeSearchState());

  List<dynamic> searchDataList = [];
  void getSearch({required String search})async {
    emit(SearchLoadingState());
 final res = await   searchRemoteDataSource.search(key: search);
     
  
  res.fold((ifLeft)=> emit(SearchErrorState(message: ifLeft)), (ifRight)=>emit(SearchSuccessState(message: ifRight)));
   
  
  }

  // String? scannedValue;

  // void setScannedValue(String value) {
  //   scannedValue = value;
  // }
}
