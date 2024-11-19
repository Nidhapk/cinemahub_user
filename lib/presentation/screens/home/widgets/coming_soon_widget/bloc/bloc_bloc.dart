import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_state.dart';

class ComingSoonMovieBloc extends Bloc<ComingSoonMovieEvent, ComingsoonMovieState> {
  ComingSoonMovieBloc() : super(ComingMoviesInitial()) {
    on<FetchcomingSoonMovieEvent>(fetchComingSoonMovies);
  }

  Future<void> fetchComingSoonMovies(FetchcomingSoonMovieEvent event,
      Emitter<ComingsoonMovieState> emit) async {
    emit(ComingSoonMoviesLoading());
    try {
      // Preserve existing state for nowShowingMovies and todaysMovies

      // Emit loading state only for comingSoonMovies
     

      // Fetch Coming Soon movies
      final comingSoonMovies =
          await MoviesRepository().fetchComingSoonMovieshows();

      // Emit success state with all movie types
      emit(ComingSoonMoviesSuccess(
        
        comingSoonMovies: comingSoonMovies,
      
      ));
    } catch (e) {
      emit(ComingMoviesError('Error fetching Coming Soon movies: $e'));
    }
  }
}
