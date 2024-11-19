import 'package:equatable/equatable.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  @override
  List<Object?> get props => [];
}

class CalendarDateSelected extends CalendarState {
  final DateTime selectedDate;

  const CalendarDateSelected(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}