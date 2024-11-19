import 'package:equatable/equatable.dart';
import 'package:userside/data/model/booking_model.dart';


abstract class BookingEvents extends Equatable {
  const BookingEvents();
  @override
  List<Object> get props => [];
}

class SeatOnTapEvent extends BookingEvents {
  final int seatIndex;
  const SeatOnTapEvent({required this.seatIndex});

  @override
  List<Object> get props => [seatIndex];
}

class BuyTicketOnpressed extends BookingEvents {
  final BookingModel bookingModel;
  final String showId;
 final Map<int, String> seatUpdates;
  const BuyTicketOnpressed(
      {required this.bookingModel,
      required this.showId,
      required this.seatUpdates});
  @override
  List<Object> get props => [bookingModel, seatUpdates];
}
