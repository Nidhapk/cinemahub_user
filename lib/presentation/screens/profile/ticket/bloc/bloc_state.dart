import 'package:equatable/equatable.dart';
import 'package:userside/data/model/booking_model.dart';

abstract class TicketState extends Equatable {
 const TicketState();
  @override
  List<Object> get props => [];
}

class TicketLoadingState extends TicketState {
 const TicketLoadingState();
  @override
  List<Object> get props => [];
}

class TicketLoadedState extends TicketState {
  final BookingModel model;
  const TicketLoadedState(this.model);
  @override
  List<Object> get props => [model];
}
class TicketLoadedErrorState extends TicketState {
  final String error;
  const TicketLoadedErrorState(this.error);
  @override
  List<Object> get props => [error];
}