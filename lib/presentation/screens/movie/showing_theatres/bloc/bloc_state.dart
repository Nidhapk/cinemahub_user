import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/data/model/show_model.dart';

class NowShowingPageState extends Equatable {
  const NowShowingPageState();
  @override
  List<Object> get props => [];
}

class NowShowingPageinitialState extends NowShowingPageState {}

class NowShowingTheatresLoadedState extends NowShowingPageState {
  final Map<TheatreModel, List<ShowModel>> theatres;
  const NowShowingTheatresLoadedState(this.theatres);
  @override
  List<Object> get props => [theatres];
}

class NowShowingTheatresLoadingState extends NowShowingPageState {
  const NowShowingTheatresLoadingState();
  @override
  List<Object> get props => [];
}

class NowShowingTheatresLoadingErrorState extends NowShowingPageState {
  final String error;
  const NowShowingTheatresLoadingErrorState(this.error);
  @override
  List<Object> get props => [];
}

class SearchBaropenedInNowShowingPagesate extends NowShowingPageState {
  
 const SearchBaropenedInNowShowingPagesate();


}
class SearchBarClosedInNowShowingPagesate extends NowShowingPageState {
  
 const SearchBarClosedInNowShowingPagesate();


}
class SearchBarWithResultsState extends NowShowingPageState {
  final Map<TheatreModel, List<ShowModel>> theatres;

  const SearchBarWithResultsState({required this.theatres});
}