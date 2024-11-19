

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/data/model/show_model.dart';
import 'package:userside/presentation/screens/booking/ui/booking_screen.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/ui/theatre_details.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget theatreBuilderInShowPage(
    {required Map<TheatreModel, List<ShowModel>> theatreShowMap,
    required void Function()? favIconOnPressed,
    void Function()? infoOnTap,
    required void Function()? showContainerOnTap,
    required DateTime selectedDate,
    required BuildContext context}) {
  final height = MediaQuery.of(context).size.height;
  // }
  final filteredTheatreShowMap = theatreShowMap.entries
      .map((entry) {
        final filteredShows = entry.value.where((show) {
          return isSameDay(show.date, selectedDate);
        }).toList();

        // Return only the theatre and its filtered shows
        return MapEntry(entry.key, filteredShows);
      })
      .where((entry) => entry.value.isNotEmpty)
      .toList();
  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 230, 230, 236),
      ),
      width: double.infinity,
      child: filteredTheatreShowMap.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.2),
                child: const Text(
                  'Currently no shows are available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredTheatreShowMap.length,
              itemBuilder: (context, index) {
                // TheatreModel theatre = theatreShowMap.keys.elementAt(index);
                // log('theatre: ${theatre.name}');
                // List<ShowModel> shows = theatreShowMap[theatre] ?? [];
                // final filteredShows = shows.where((show) {
                //   return isSameDay(show.date, selectedDate);
                // }).toList();
                // if (theatreShowMap.isEmpty) {
                //   return Padding(
                //     padding: EdgeInsets.only(top: height * 0.2),
                //     child:
                //         const Center(child: Text('Currenty no shows are available')),
                //   );
                final theatre = filteredTheatreShowMap[index].key;
                final filteredShows = filteredTheatreShowMap[index].value;

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // IconButton(
                            //   onPressed: favIconOnPressed,
                            //   icon: const Icon(
                            //     Icons.favorite,
                            //     size: 19,
                            //     color: Color.fromARGB(
                            //       255,
                            //       209,
                            //       16,
                            //       100,
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              width: 14,
                            ),
                            SizedBox(
                              width: 265,
                              child: Text(
                                theatre.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TheatreDetailsScreen(
                                          theatre: theatre,
                                        )));
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'INFO',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 14),
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredShows.length,
                            itemBuilder: (context, index) {
                              final show = filteredShows[index];
                              return Container(
                                width: 99,
                                height: 20,
                                margin: const EdgeInsets.only(
                                  right: 11,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.7,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BookingScreen(
                                          movie: show.movie,
                                          screen: show.room,
                                          theatreName: show.theatre.name,
                                          show: show,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        show.time,
                                        style: const TextStyle(
                                          color: green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        show.room.roomName,
                                        style: const TextStyle(
                                          color: green,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                );
              }),
    ),
  );
}
