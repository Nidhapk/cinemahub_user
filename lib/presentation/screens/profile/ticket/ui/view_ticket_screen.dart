import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:userside/presentation/screens/main_screen.dart';
import 'package:userside/presentation/screens/profile/ticket/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/ticket/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/ticket/bloc/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/custom_alertbox.dart';

class ViewTicketScreen extends StatelessWidget {
  final String bookingId;
  const ViewTicketScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<TicketBloc>().add(FetchTicketEvent(bookingId));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 243),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
          ),
        ),
        title: const Text(
          'Reservation Details',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is TicketLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TicketLoadedState) {
            final bookingModel = state.model;
            return ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  child: Container(
                    height: height * 0.08,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.05),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${bookingModel.movieName}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  TextSpan(
                                    text:
                                        'Booked on ${DateFormat('d MMM yyyy h:mm a').format(bookingModel.timeStamp.toDate())}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 0.3,
                  color: Color.fromARGB(255, 238, 238, 243),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  child: Container(
                    //height: height * 0.4,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.04,
                          top: height * 0.04,
                          right: width * 0.2,
                          bottom: height * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Cinema',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            bookingModel.theatreName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    DateFormat('d MMM yyyy')
                                        .format(bookingModel.showDate),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Time',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    bookingModel.showTime,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Screen',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    bookingModel.screenName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Seats',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    bookingModel.seatNumbers.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 0.3,
                  color: Color.fromARGB(255, 238, 238, 243),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  child: Container(
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20)),
                      child:
                          // SizedBox(
                          //   width: width * 0.02,
                          // ),

                          Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'SEE YOU IN CINEMA!                   ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(shadows: [
                              Shadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 2)
                            ], fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Note : ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 108, 108, 108),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Show your Ticket at the ticket counter',
                      style: TextStyle(
                          color: Color.fromARGB(255, 108, 108, 108),
                          fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            );
          } else if (state is TicketLoadedErrorState) {
            return Text('Error:${state.error}');
          } else {
            return const CustomAlertBox(
                title: 'Something went wrong',
                content: 'something went wrong.Please try again later',
                confirmText: 'Ok');
          }
        },
      ),
    );
  }
}
