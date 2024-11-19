import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/theatre_repository.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_state.dart';

class FavTheatreBloc extends Bloc<FavTheatreEvent, FavTheatreStates> {
  FavTheatreBloc() : super(const FavTheatreInitialState()) {
    on<ToggleFavoriteEventInTheatre>(toggleFavButtonInTheatre);
  }
Future<void> toggleFavButtonInTheatre(
    ToggleFavoriteEventInTheatre event, Emitter<FavTheatreStates> emit) async {
  
  // Start by getting the current favorite status map.
  Map<String, bool> currentStatus = {};
  if (state is TheatreFavoriteToggledState) {
    currentStatus = Map.from((state as TheatreFavoriteToggledState).isFavorite);
  }
  
  // Check if the current theatre is a favorite.
  bool isFavourite = await TheatreRepository().isTheatreInFavorites(
    theatreId: event.theatreId,
    userId: event.userId,
  );

  try {
    // Toggle the favorite status.
    if (!isFavourite) {
      await TheatreRepository().addTofavTheatre(
        theatreId: event.theatreId,
        userId: event.userId,
      );
      currentStatus[event.theatreId] = true; // Mark as favorite
    } else {
      await TheatreRepository().removeFromFavTheatre(
        theatreId: event.theatreId,
        userId: event.userId,
      );
      currentStatus[event.theatreId] = false; // Remove from favorites
    }

    // Emit the updated state with the entire favorite status map.
    emit(TheatreFavoriteToggledState(currentStatus));
  } catch (e) {
    emit(
      TheatreFavoriteToggleFailureState('Error: $e'),
    );
  }
}

  
}
