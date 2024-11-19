import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/ui/theatre_details.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget theatreContainer(
    {required BuildContext context,
    required TheatreModel theatre,
    required void Function()? onTap,
    required void Function()? favonTap,
    required String theatreId,
    required String distance}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        bottom: height * 0.015,
      ),
      child: Container(
        height: height * 0.2,
        width: width * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          color: white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
                bottom: 15,
              ),
              child: Container(
                height: height * 0.16,
                width: width * 0.22,
                decoration: BoxDecoration(
                  border: Border.all(color: white, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 185, 184, 184)
                            .withOpacity(0.5),
                        //offset: Offset(-2, 1),
                        blurRadius: 6,
                        spreadRadius: 3)
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(theatre.profileImage),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, // right: 10,
                  top: 12,
                  bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.02,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.5,
                          child: Text(
                            distance,
                            style: const TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 110, 129, 238)),
                          ),
                        ),
                        BlocBuilder<FavTheatreBloc, FavTheatreStates>(
                          builder: (context, state) {
                            bool isFav = false;

                            if (state is TheatreFavoriteToggledState) {
                              isFav = state.isFavorite[theatreId] ?? false;
                            }
                            return GestureDetector(
                              onTap: favonTap,
                              child: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 18,
                                color: isFav
                                    ? const Color.fromARGB(255, 194, 32, 59)
                                    : const Color.fromARGB(
                                        255,
                                        29,
                                        28,
                                        28,
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theatre.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.045,
                      ),
                      SizedBox(
                        height: 10,
                        width: width * 0.5,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star_outlined,
                              color: Colors.amber,
                              size: 14,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.009,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 17,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      SizedBox(
                        width: width * 0.5,
                        child: Text(
                          theatre.address,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.03),
                        child: GestureDetector(
                          onTap: onTap,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.005,
                                bottom: height * 0.005,
                                left: width * 0.03,
                                right: width * 0.03,
                              ),
                              child: const Text(
                                'View Shows',
                                style: TextStyle(
                                  color: Color.fromARGB(
                                    255,
                                    41,
                                    55,
                                    133,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TheatreDetailsScreen(theatre: theatre),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.005,
                              bottom: height * 0.005,
                              left: width * 0.03,
                              right: width * 0.03,
                            ),
                            child: const Text(
                              'More Deatails',
                              style: TextStyle(
                                color: Color.fromARGB(
                                  255,
                                  41,
                                  55,
                                  133,
                                ),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
