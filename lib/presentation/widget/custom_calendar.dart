import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class CustomCalendar extends StatelessWidget {
  final bool Function(DateTime)? selectedDayPredicate;
  final void Function(DateTime, DateTime)? onDaySelected;
  final DateTime focusedDay;
  const CustomCalendar(
      {super.key,
      required this.selectedDayPredicate,
      required this.onDaySelected,
      required this.focusedDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: TableCalendar(
        availableCalendarFormats: const {CalendarFormat.week: ''},
        calendarStyle: CalendarStyle(
            tablePadding: const EdgeInsets.only(top: 10, bottom: 0),
            todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: primaryColor)
                //color: Color.fromARGB(255, 143, 151, 210),
                ),
            selectedDecoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),
            todayTextStyle: TextStyle(color: black),
            cellMargin: const EdgeInsets.all(10)),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle:
                TextStyle(color: primaryColor, fontWeight: FontWeight.w400)),
        headerStyle: HeaderStyle(
            headerPadding: EdgeInsets.zero,
            leftChevronIcon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.grey,
            ),
            rightChevronIcon: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            titleCentered: true,
            titleTextStyle: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5)))),
        calendarFormat: CalendarFormat.week,
        focusedDay: focusedDay,
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030),
        selectedDayPredicate: selectedDayPredicate,
        onDaySelected: onDaySelected,
      ),
    );
  }
}
