import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/booking_repository.dart';
import 'package:userside/presentation/screens/profile/my_bookings/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/my_bookings/bloc/bloc_state.dart';

class MyBookingsBloc extends Bloc<MybookingsEvent, MyBookingsStates> {
  MyBookingsBloc() : super(const MyBookingsInitialState()) {
    on<FetchMyBookings>(fetchMyBookings);
  }

  Future<void> fetchMyBookings(
      FetchMyBookings event, Emitter<MyBookingsStates> emit) async {
    // emit(const MyBookingsInitialState());
    try {
      final bookings = await BookingRepository().fetchMyBookings(event.userId);
      emit(MyBookingsLoadedState(bookings));
    } catch (e) {
      emit(
        MyBookingsLoadedErrorState('Error;$e'),
      );
    }
  }
}
