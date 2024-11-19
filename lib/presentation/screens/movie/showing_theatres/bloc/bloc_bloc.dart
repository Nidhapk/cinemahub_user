import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/shows_repository.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/bloc/bloc_state.dart';

class NowShowingBloc extends Bloc<NowShowingPageEvent, NowShowingPageState> {
  NowShowingBloc() : super(NowShowingPageinitialState()) {
    on<BookNowOnpressedEvent>(fetchShowingThetares);
    on<SearchButtonOnPressedEvent>(searchOnpreesed);
    on<SearchShowsByTheatreNameEvent>(fetchshowsBySearchingTheatre);
   
  }

  void searchOnpreesed(
      SearchButtonOnPressedEvent event, Emitter<NowShowingPageState> emit) {
    if (state is SearchBaropenedInNowShowingPagesate) {
      emit(const SearchBarClosedInNowShowingPagesate());
    } else {
      emit(const SearchBaropenedInNowShowingPagesate());
    }
  }

  Future<void> fetchShowingThetares(
      BookNowOnpressedEvent event, Emitter<NowShowingPageState> emit) async {
    emit(const NowShowingTheatresLoadingState());
    try {
      final theatres =
          await ShowsRepository().fetchTheatresByMovieId(event.movieId);
      emit(NowShowingTheatresLoadedState(theatres));
    } catch (e) {
      emit(
        NowShowingTheatresLoadingErrorState(' error : $e'),
      );
    }
  }

  Future<void> fetchshowsBySearchingTheatre(SearchShowsByTheatreNameEvent event,
      Emitter<NowShowingPageState> emit) async {
    emit(const NowShowingTheatresLoadingState());
    try {
      final theatres = await ShowsRepository()
          .fetchTheatresBySearchingTheatreName(event.movieId, event.query);
      //  emit(const SearchBaropenedInNowShowingPagesate());
      emit(NowShowingTheatresLoadedState(theatres));
    } catch (e) {
      emit(NowShowingTheatresLoadingErrorState('error : $e'));
    }
  }
}
