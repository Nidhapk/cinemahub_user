import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/bloc/calendar/bloc_event.dart';
import 'package:userside/presentation/bloc/calendar/bloc_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<DateSelected>((event, emit) {
      emit(CalendarDateSelected(event.selectedDate));
    });
  }
}