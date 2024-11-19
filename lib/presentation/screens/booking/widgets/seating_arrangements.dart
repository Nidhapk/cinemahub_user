import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/room_model.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/booking/widgets/custom_clipper.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget seatingArrangements({
  required BuildContext context,
  required ScrollController? controller,
  required int row,
  required int column,
  required RoomModel screen,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return ListView(
    controller: controller,
    children: [
      SizedBox(height: height * 0.1),
      SizedBox(
        height: row * 35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            SizedBox(height: height * 0.1),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: CustomClipper140Degrees(),
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: white.withBlue(170),
                          width: 7,
                        ),
                      ),
                      gradient: LinearGradient(
                          colors: [
                            white.withAlpha(2),
                            Colors.white.withAlpha(25),
                            Colors.white.withAlpha(1),
                            Colors.white.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                ),
                SizedBox(
                  height: row * 28,
                  width: column * 28,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(width * 0.05),
                    itemCount: row * column,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: row),
                    itemBuilder: (context, index) {
                      if (screen.seatStates![index] == 'unselected') {
                        return BlocBuilder<BookingBloc, BookingStates>(
                          builder: (context, state) {
                            bool? currentState;
                            if (state is SeatOnTapState) {
                              currentState = state.seatStatus[index] ?? false;
                            }
                            return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<BookingBloc>()
                                        .add(SeatOnTapEvent(seatIndex: index));
                                  },
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: currentState == true
                                          ? const Color.fromARGB(
                                              255, 108, 210, 238)
                                          : Colors.transparent,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: currentState == true
                                            ? const Color.fromARGB(
                                                255, 108, 210, 238)
                                            : white,
                                      ),
                                    ),
                                    width: 20,
                                    child: Center(
                                      child: Text(
                                        index.toString(),
                                        style: TextStyle(
                                          color: currentState == true
                                              ? primaryColor
                                              : white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                //available

                                );
                          },
                        );
                      } else if (screen.seatStates![index] == 'unavailable') {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            width: 20,
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 12,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                width: 1,
                color: white,
              ),
            ),
          ),
          const Text(
            'Available',
            style: TextStyle(
              color: white,
            ),
          ),
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: const Center(
              child: Text(
                'X',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
          ),
          const Text(
            'Unavailable',
            style: TextStyle(color: white),
          ),
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 44, 173, 220),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                width: 0,
                color: white,
              ),
            ),
          ),
          const Text(
            'selected',
            style: TextStyle(
              color: white,
            ),
          ),
        ],
      ),
      BlocBuilder<BookingBloc, BookingStates>(
        builder: (context, state) {
          if (state is SeatOnTapState && state.isBottomsheetVisible) {
            return SizedBox(
              height: 290 + height * 0.02,
            );
          } else {
            return SizedBox(
              height: height * 0.05,
            );
          }
        },
      ),
    ],
  );
}
