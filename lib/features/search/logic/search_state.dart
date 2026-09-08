abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}

class SearchSearching extends SearchState {}

class SearchResultsLoaded extends SearchState {}

class SearchEmpty extends SearchState {}