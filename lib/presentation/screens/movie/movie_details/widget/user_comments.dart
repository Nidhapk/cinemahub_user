import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget userComments(
    {required BuildContext context, required List<MovieReviewModel> reviews}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Expanded(
    flex: 0,
    child: Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 232, 226, 243).withOpacity(0.5),
        ),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Padding(
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        CircleAvatar(
                          backgroundColor: primaryColor.withOpacity(0.1),
                          radius: 20,
                          backgroundImage: review.userProfile.isNotEmpty
                              ? NetworkImage(review.userProfile)
                              : null,
                          child: review.userProfile.isEmpty
                              ? Text(review.userName[0].toUpperCase())
                              : null,
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.55,
                                  child: Text(review.userName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text(
                                  DateFormat('d MMM yyyy')
                                      .format(review.dateTime),
                                  style: TextStyle(
                                      fontSize: width * 0.028,
                                      color:
                                          Color.fromARGB(255, 140, 140, 141)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                                height: 12,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: review.rating,
                                    itemBuilder: (context, index) {
                                      return Icon(
                                        Icons.star_outlined,
                                        color: Colors.amber,
                                        size: 14,
                                      );
                                    })),
                            SizedBox(
                              width: width * 0.73,
                              child: Text('${review.comment}',
                                  style: TextStyle(fontSize: 12)),
                            )
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 3,
                    // ),
                  ],
                ),
              );
            }),
      ),
    ),
  );
}
