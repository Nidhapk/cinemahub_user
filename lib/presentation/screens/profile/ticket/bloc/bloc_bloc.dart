import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/booking_model.dart';
import 'package:userside/data/services/booking_repository.dart';
import 'package:userside/presentation/screens/profile/ticket/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/ticket/bloc/bloc_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(const TicketLoadingState()) {
    on<FetchTicketEvent>(fetchTicket);
  }

  Future<void> fetchTicket(
      FetchTicketEvent event, Emitter<TicketState> emit) async {
    emit(const TicketLoadingState());
    try {
      BookingModel model =
          await BookingRepository().fetchBookingDetails(event.bookingId);
      emit(TicketLoadedState(model));
    } catch (e) {
      emit(
        TicketLoadedErrorState('Error: $e'),
      );
    }
  }
}
