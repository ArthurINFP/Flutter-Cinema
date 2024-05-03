// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/home/data/models/movie.dart';

class SearchState {
  BlocStatusState state;
  String? message;
  List<Movie>? result;

  SearchState copyWith({
    BlocStatusState? state,
    String? message,
    List<Movie>? result,
  }) {
    return SearchState(
      state: state ?? this.state,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  SearchState({
    required this.state,
    this.message,
    this.result,
  });
}
