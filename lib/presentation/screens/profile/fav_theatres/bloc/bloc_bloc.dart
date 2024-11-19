import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/theatre_repository.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/bloc/bloc_state.dart';

class FavTheatreBlocInFav
    extends Bloc<FavTheatresInFavEvent, FavTheatresInFavState> {
  FavTheatreBlocInFav() : super(const FavTheatreInitialStateInfav()) {
    on<FetchFavTheatresInFavEvent>(fetchFavTheatres);
  }
  Future<void> fetchFavTheatres(FetchFavTheatresInFavEvent event,
      Emitter<FavTheatresInFavState> emit) async {
    try {
      final theatres =
          await TheatreRepository().fetchFavTheatres(emailId: event.emailId);
      emit(
        FavTheatreLaodedState(theatres),
      );
    } catch (e) {
      emit(
        FavTheatreLaodederrorState('Error: $e'),
      );
    }
  }
}
