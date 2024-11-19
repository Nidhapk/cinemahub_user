import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:userside/presentation/bloc/calendar/bloc_bloc.dart';
import 'package:userside/presentation/bloc/calendar/bloc_event.dart';
import 'package:userside/presentation/bloc/calendar/bloc_state.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/custom_filters.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/search_appbar.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/ui/theatre_details.dart';
import 'package:userside/presentation/screens/theatre/theatre_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/common/custom_divider.dart';
import 'package:userside/presentation/widget/custom_calendar.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/ui/filter_bottomsheet.dart';
import 'package:userside/presentation/widget/showing_theatres/showing_theatre_appbar.dart';
import 'package:userside/presentation/widget/showing_theatres/shows_container.dart';

class ShowingTheatresScreen extends StatelessWidget {
  final String movieId;
  const ShowingTheatresScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    log('movieid: $movieId');
    DateTime selectedDate = DateTime.now();
    context.read<NowShowingBloc>().add(
          BookNowOnpressedEvent(
            movieId: movieId,
            selectedDate: selectedDate,
          ),
        );
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: BlocBuilder<NowShowingBloc, NowShowingPageState>(
          builder: (context, state) {
            if (state is SearchBarClosedInNowShowingPagesate) {
              return showingTheatresAppbar(
                titleMovie: 'Movie Name',
                searchOnTap: () {
                  context.read<NowShowingBloc>().add(
                        const SearchButtonOnPressedEvent(
                          searchOnpressed: true,
                        ),
                      );
                },
                filterOntap: () {
                  filterModelBottomSheet(
                    applyFilterOnPressed: () {},
                    context: context,
                    resetFilterOnPressed: () {
                      context.read<ShowFilterBloc>().add(
                            const ResetShowFiltersEvent(),
                          );
                    },
                    //   applyFilterOnPressed: () {context.read<ShowFilterBloc>().add(ShowFiltersAppliedEvent(price: price, language: language))},
                  );
                },
              );
            } else {
              return searchAppbarInNowShowingPage(
                closeOnPressed: () {
                  context.read<NowShowingBloc>().add(
                        const SearchButtonOnPressedEvent(
                          searchOnpressed: true,
                        ),
                      );
                },
                searchOnChanged: (value) {
                  context.read<NowShowingBloc>().add(
                        SearchShowsByTheatreNameEvent(
                          query: value,
                          movieId: movieId,
                        ),
                      );
                },
              );
            }
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              selectedDate = state is CalendarDateSelected
                  ? state.selectedDate
                  : DateTime.now();

              return CustomCalendar(
                focusedDay: state is CalendarDateSelected
                    ? state.selectedDate
                    : DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  context.read<CalendarBloc>().add(
                        DateSelected(selectedDay),
                      );
                  context.read<NowShowingBloc>().add(
                        BookNowOnpressedEvent(
                          movieId: movieId,
                          selectedDate: selectedDate,
                        ),
                      );
                },
              );
            },
          ),
          BlocBuilder<ShowFilterBloc, ShowFilterState>(
            builder: (context, state) {
              if (state is ShowFilterAppliedState) {
                return Column(
                  children: [
                    CustomShowFilters(values: state.prices),
                    customDivider(),
                    CustomShowFilters(values: state.languages)
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<NowShowingBloc, NowShowingPageState>(
            builder: (context, state) {
              if (state is NowShowingTheatresLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowShowingTheatresLoadedState) {
                final showMap = state.theatres;
                return theatreBuilderInShowPage(
                  context: context,
                  selectedDate: selectedDate,
                  theatreShowMap: showMap,
                  favIconOnPressed: () {},
                  infoOnTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TheatreDetailsScreen(
                              theatre: theatre!,
                            )));
                  },
                  showContainerOnTap: () {},
                );
              } else if (state is NowShowingTheatresLoadingErrorState) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: Text(
                    'No Shows available',
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
