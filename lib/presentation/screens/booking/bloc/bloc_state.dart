import 'package:equatable/equatable.dart';

abstract class BookingStates extends Equatable {
  const BookingStates();
  @override
  List<Object> get props => [];
}

class BookingInitialState extends BookingStates {
  const BookingInitialState();
  @override
  List<Object> get props => [];
}

class SeatOnTapState extends BookingStates {
  final Map<int, bool> seatStatus;
  final bool isBottomsheetVisible;

  const SeatOnTapState(
      {required this.seatStatus, required this.isBottomsheetVisible});

  @override
  List<Object> get props => [seatStatus];
}

class BookingLoadingState extends BookingStates {
  const BookingLoadingState();
  @override
  List<Object> get props => [];
}

class BookingsuccessState extends BookingStates {
  final String bookingId;
  //final BookingModel bookingModel;
  const BookingsuccessState(this.bookingId
      );
  @override
  List<Object> get props => [];
}

class BookingErrorState extends BookingStates {
  final String error;
  const BookingErrorState(this.error);
  @override
  List<Object> get props => [error];
}
