import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/data/model/room_model.dart';
import 'package:userside/data/model/show_model.dart';
import 'package:userside/presentation/screens/booking/widgets/booking_appbar.dart';
import 'package:userside/presentation/screens/booking/widgets/booking_bottomsheet.dart';
import 'package:userside/presentation/screens/booking/widgets/seating_arrangements.dart';

class BookingScreen extends StatefulWidget {
  final MovieClass movie;

  final RoomModel screen;
  final String theatreName;
  final ShowModel show;
  const BookingScreen(
      {super.key,
      required this.movie,
      required this.screen,
      required this.theatreName,
      required this.show});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final ScrollController _listScrollController = ScrollController();

  Razorpay razorPay = Razorpay();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 63, 240).withOpacity(0.9),
      appBar: bookinAppbar(
          context: context,
          movieName: widget.movie.movieName,
          theatreName: '${widget.theatreName}, ${widget.screen.roomName}'),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 78, 63, 240).withOpacity(0.9),
              const Color.fromARGB(255, 151, 49, 246).withAlpha(100)
            ],
          ),
        ),
        child: Stack(
          children: [
            seatingArrangements(
              context: context,
              controller: _listScrollController,
              row: widget.screen.rows ?? 0,
              column: widget.screen.columns ?? 0,
              screen: widget.screen,
            ),
            bookingBottomSheet(movie: widget.movie,
                date: widget.show.date,
                show: widget.show,
                theatreName: widget.theatreName,
                ticketPrice: widget.show.ticketPrice,
                context: context,
                razorPay: razorPay)
          ],
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
