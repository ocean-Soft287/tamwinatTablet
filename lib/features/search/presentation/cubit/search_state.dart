import 'package:search_appp/features/search/model/search_result.dart';

abstract class SearchState {}

class InitalizeSearchState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  List<ProductModel> products;
  SearchSuccessState({required this.products});
}

class SearchErrorState extends SearchState {
   String message;
  SearchErrorState({required this.message});
}
