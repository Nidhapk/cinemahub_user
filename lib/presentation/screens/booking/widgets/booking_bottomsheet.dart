import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:userside/data/model/booking_model.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/data/model/show_model.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/main_screen.dart';
import 'package:userside/presentation/screens/profile/ticket/ui/view_ticket_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget bookingBottomSheet(
    {required BuildContext context,
    required razorPay,
    required String theatreName,
    required ShowModel show,
    required num ticketPrice,
    required DateTime date,
    required MovieClass movie}) {
  Razorpay razorPay = Razorpay();
  String bookingId = '';

  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return BlocBuilder<BookingBloc, BookingStates>(
    builder: (context, state) {
      if (state is SeatOnTapState && state.isBottomsheetVisible) {
        final tickets =
            state.seatStatus.values.where((value) => value == true).length;
        List<int> seatNumbers = state.seatStatus.keys
            .where((key) => state.seatStatus[key] == true)
            .toList();
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * 0.25,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: Container(
                    width: width * 0.2,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.03,
                    right: width * 0.03,
                    top: height * 0.02,
                    bottom: height * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tickets',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            tickets.toString(),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Text('')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$tickets x $ticketPrice'),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            (tickets * ticketPrice).toString(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: height * 0.01,
                        left: width * 0.15,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Price\n',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                            TextSpan(
                              text: '${tickets * ticketPrice} RS',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: const Color.fromARGB(255, 78, 63, 240)
                                    .withOpacity(0.9),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        BookingModel bookingModel = BookingModel(
                          bookingId: '', movieName: movie.movieName,
                          theatreId: show.theatre.emailId,
                          moviePoster: movie.posterImage,
                          theatreName: theatreName,
                          userId: FirebaseAuth.instance.currentUser!
                              .uid, // Replace with actual user ID
                          userEmail: FirebaseAuth.instance.currentUser!.email ??
                              '', // Replace with actual user email
                          screenName: show
                              .room.roomName, // Replace with actual screen name
                          seatNumbers: seatNumbers
                              .map((i) => i.toString())
                              .toList(), // Pass the selected seat numbers
                          totalAmount: tickets * 120,
                          showDate: show.date, // Pass the actual show date
                          showTime: show.time, // Pass the actual show time
                          timeStamp: Timestamp.now(),
                        );
                        var options = {
                          'key': 'rzp_test_jIotm3SaZbXO9x',
                          'amount': (tickets * ticketPrice * 100),
                          'currency': 'INR',
                          'name': 'Acme Corp.',
                          'description': 'Fine T-Shirt',
                          'prefill': {
                            'contact': '8888888888',
                            'email': 'test@razorpay.com'
                          }
                        };
                        razorPay.open(options);
                        razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            (PaymentSuccessResponse response) {
                          Map<int, String> seatUpdates = {
                            for (var seat in seatNumbers) seat: 'unavailable'
                          };
                          _handlePaymentSuccess(
                              context: context,
                              bookingId: bookingId,
                              model: bookingModel,
                              response: response,
                              showId: show.showId,
                              seatUpdates: seatUpdates);
                        });
                      },
                      child: Container(
                        width: width * 0.45,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 203, 161, 11)
                                  .withAlpha(200),
                              const Color.fromARGB(255, 203, 161, 11)
                                  .withAlpha(140)
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'BUY NOW',
                            style: TextStyle(
                              fontSize: 18,
                              color: black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}

void _handlePaymentSuccess(
    {required PaymentSuccessResponse response,
    required BuildContext context,
    required String bookingId,
    required BookingModel model,
    required String showId,
    required Map<int, String> seatUpdates}) {
  context.read<BookingBloc>().add(BuyTicketOnpressed(
      bookingModel: model, showId: showId, seatUpdates: seatUpdates));
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Image.asset(
          'assets/approve_6597168.png',
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.05,
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                    text: 'Payment Successful\n\n',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
                const TextSpan(
                  text:
                      'Your payment has been successfully completed. Your ticket has been proceeded.Enjoy in cinema',
                  style: TextStyle(
                      // color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        actions: [
          BlocListener<BookingBloc, BookingStates>(
            listener: (context, state) {
              if (state is BookingsuccessState) {
                bookingId = state.bookingId;
              }
            },
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    maximumSize: Size.fromHeight(40),
                    foregroundColor: black,
                    backgroundColor: Color.fromARGB(255, 221, 188, 77)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewTicketScreen(
                            bookingId: bookingId,
                          )));
                },
                child: Text('View Ticket')),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: Size.fromHeight(40),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (context) => false);
              },
              child: Text('Back to Home')),
        ],
      );
    },
  );
}
