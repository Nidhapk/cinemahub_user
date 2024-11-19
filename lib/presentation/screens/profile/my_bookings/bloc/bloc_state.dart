import 'package:equatable/equatable.dart';
import 'package:userside/data/model/booking_model.dart';

abstract class MyBookingsStates extends Equatable {
  const MyBookingsStates();
  @override
  List<Object> get props => [];
}

class MyBookingsInitialState extends MyBookingsStates {
  const MyBookingsInitialState();
  @override
  List<Object> get props => [];
}

class MyBookingsLoadedState extends MyBookingsStates {
  final List<BookingModel> bookings;
  const MyBookingsLoadedState(this.bookings);
  @override
  List<Object> get props => [bookings];
}

class MyBookingsLoadedErrorState extends MyBookingsStates {
  final String error;
  const MyBookingsLoadedErrorState(this.error);
  @override
  List<Object> get props => [error];
}
