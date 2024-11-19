import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/booking_repository.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_state.dart';

class BookingBloc extends Bloc<BookingEvents, BookingStates> {
  BookingBloc()
      : super(
          const BookingInitialState(),
        ) {
    on<SeatOnTapEvent>(seatOntap);
    on<BuyTicketOnpressed>(bookingEvent);
  }

  void seatOntap(SeatOnTapEvent event, Emitter<BookingStates> emit) {
    final currentState = state; //currentState of bloc
    Map<int, bool> updatedSeatStatus = {};

    if (currentState is SeatOnTapState) {
      updatedSeatStatus = Map.from(currentState.seatStatus);
    }
    final isTapped = updatedSeatStatus[event.seatIndex] ?? false;
    updatedSeatStatus[event.seatIndex] = !isTapped;
    final anySeatSelected =
        updatedSeatStatus.values.any((isSelected) => isSelected);
    emit(
      SeatOnTapState(
          seatStatus: updatedSeatStatus, isBottomsheetVisible: anySeatSelected),
    );
  }

  Future<void> bookingEvent(
      BuyTicketOnpressed event, Emitter<BookingStates> emit) async {
    emit(
      const BookingLoadingState(),
    );
    try {
    final docRef=  await BookingRepository().bookingSeat(event.bookingModel);
      await BookingRepository()
          .updateMultipleSeatDetails(event.showId, event.seatUpdates);

      emit( BookingsuccessState(docRef.id));
    } catch (e) {
      emit(
        BookingErrorState('Error : $e'),
      );
    }
  }
}
