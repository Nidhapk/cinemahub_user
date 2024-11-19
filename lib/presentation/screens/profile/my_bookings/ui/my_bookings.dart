import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:userside/presentation/screens/profile/my_bookings/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/my_bookings/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/my_bookings/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/profile/ticket/ui/view_ticket_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    context.read<MyBookingsBloc>().add(
          FetchMyBookings(FirebaseAuth.instance.currentUser!.uid),
        );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 22, 47),
        foregroundColor: white,
        title: const Text(
          'My Bookings',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: BlocBuilder<MyBookingsBloc, MyBookingsStates>(
        builder: (context, state) {
          if (state is MyBookingsInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MyBookingsLoadedState) {
            final bookings = state.bookings;
            if (bookings.isEmpty) {
              return const Center(
                child: Text('No bookings'),
              );
            } else {
              return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.03,
                          right: width * 0.03,
                          top: height * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewTicketScreen(
                                  bookingId: bookings[index].bookingId),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: white, boxShadow: [
                            BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 7,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width * 0.26,
                                height: height * 0.18,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            bookings[index].moviePoster))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        bookings[index].movieName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        '${DateFormat('d MMM yyy').format(bookings[index].showDate)} |  ${bookings[index].showTime}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        bookings[index].theatreName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 106, 106, 106),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'SCREEN',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 126, 126, 126),
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'SCREEN 1',
                                              style: TextStyle(
                                                  // color: Color.fromARGB(255, 94, 92, 92),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'SEATS',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 126, 126, 126),
                                                  fontSize: 10),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              bookings[index]
                                                  .seatNumbers
                                                  .join(', '),
                                              style: const TextStyle(
                                                  // color: Color.fromARGB(255, 94, 92, 92),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          } else if (state is MyBookingsLoadedErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text('something went wrong'),
            );
          }
        },
      ),
    );
  }
}
