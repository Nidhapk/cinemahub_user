import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_event.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class LanguageFiltersBuilder extends StatelessWidget {
  final List<String> values;
  final List<String> selectedValues;
  const LanguageFiltersBuilder(
      {super.key, required this.values, required this.selectedValues});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        itemCount: values.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedValues.contains(values[index]);
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: isSelected ? white : primaryColor,
                backgroundColor: isSelected ? primaryColor : Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                side: const BorderSide(
                    color: Color.fromARGB(255, 107, 107, 107), width: 0.5),
              ),
              onPressed: () {
                log('event triggered');
                context
                    .read<ShowFilterBloc>()
                    .add(LanguageAppliedEvent(values[index]));
                log('value: ${values[index]}');
              },
              child: Text(
                values[index],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
