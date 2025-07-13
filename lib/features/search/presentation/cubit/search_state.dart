abstract class SearchState {}

class InitalizeSearchState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  List<dynamic> message;
  SearchSuccessState({required this.message});
}

class SearchErrorState extends SearchState {
   String message;
  SearchErrorState({required this.message});
}
