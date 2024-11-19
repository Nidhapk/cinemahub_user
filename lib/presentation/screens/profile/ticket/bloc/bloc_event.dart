import 'package:equatable/equatable.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
  @override
  List<Object> get props => [];
}

class FetchTicketEvent extends TicketEvent {
  final String bookingId;
const   FetchTicketEvent(this.bookingId);
  @override
  List<Object> get props => [];
}
