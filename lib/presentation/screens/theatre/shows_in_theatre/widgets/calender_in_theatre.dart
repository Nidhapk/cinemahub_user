import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:userside/presentation/bloc/calendar/bloc_bloc.dart';
import 'package:userside/presentation/bloc/calendar/bloc_event.dart';
import 'package:userside/presentation/bloc/calendar/bloc_state.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_event.dart';
import 'package:userside/presentation/widget/custom_calendar.dart';

Widget customCalendarInTheatreScreen(String email) {
  DateTime selectedDate = DateTime.now();
  return BlocBuilder<CalendarBloc, CalendarState>(
    builder: (context, state) {
      selectedDate =
          state is CalendarDateSelected ? state.selectedDate : DateTime.now();

      return CustomCalendar(
        focusedDay:
            state is CalendarDateSelected ? state.selectedDate : DateTime.now(),
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          log('$selectedDay');
          context.read<CalendarBloc>().add(
                DateSelected(selectedDay),
              );
          context.read<ShowsInTheatreBloc>().add(
                ShowingMoviesUnTheatreEvent(
                  email,
                  selectedDay,
                ),
              );
        },
      );
    },
  );
}
