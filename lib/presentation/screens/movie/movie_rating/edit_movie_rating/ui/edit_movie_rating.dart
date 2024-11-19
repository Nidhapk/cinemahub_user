import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/custom_ratingbar.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/movie_rating_appbar.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/review_submitbutton.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/review_textformfield.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/custom_snackbar.dart';

class EditMovieRating extends StatefulWidget {
  final String movieId;
  final MovieReviewModel reviewModel;
  const EditMovieRating(
      {super.key, required this.movieId, required this.reviewModel});

  @override
  State<EditMovieRating> createState() => _EditMovieRatingState();
}

class _EditMovieRatingState extends State<EditMovieRating> {
  final TextEditingController reviewController = TextEditingController();

  int rating = 0;

  @override
  Widget build(BuildContext context) {
    reviewController.text = widget.reviewModel.comment;
    rating = widget.reviewModel.rating;
    log('rating: ${widget.reviewModel.rating}');
    return Scaffold(
      appBar: movieRatingAppbar(
        onPressed: () {
          context.read<EditMovieRatingReviewBloc>().add(
                EditClearMovieRatingEvent(
                  widget.reviewModel.rating,
                ),
              );
          Navigator.of(context).pop();
        },
        title: 'Edit your rating',
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              BlocConsumer<EditMovieRatingReviewBloc, EditMovieRatingReviewState>(
                listener: (context, state) {
                  if (state is EditMovieRatingReviewSubmitSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        text: state.message,
                        icon: Icons.check_circle_rounded,
                        iconColor: Colors.green,
                        borderColor: black,
                        backgroundColor: black,
                      ),
                    );
                    Navigator.pop(context);
                    context.read<EditMovieRatingReviewBloc>().add(
                          EditClearMovieRatingEvent(
                            widget.reviewModel.rating,
                          ),
                        );
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is EditMovieRatingState) {
                    rating = state.rating;
                  }
                  return customRatingBar(
                    onPressed: () {
                      context.read<EditMovieRatingReviewBloc>().add(
                            EditMovieRatingTapedEvent(
                              rating + 1,
                            ),
                          );
                    },
                    rating: rating,
                  );
                },
              ),
              reviewTextFormField(
                reviewController: reviewController,
              ),
              ReviewSubmitButton<EditMovieRatingReviewBloc, EditMovieRatingReviewState>(
                listener: (context, state) {
                  if (state is EditMovieRatingState) {
                    rating = state.rating;
                  }
                },
                onPressed: () {
                  context.read<EditMovieRatingReviewBloc>().add(
                        EditMovieReviewSubmitted(
                          review: MovieReviewModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            userName: FirebaseAuth
                                .instance.currentUser!.email
                                .toString(),
                            rating: rating,
                            comment: reviewController.text.trim(),
                            dateTime: DateTime.now(),
                            userProfile: FirebaseAuth.instance.currentUser!.photoURL??'',
                            movieId: widget.movieId,
                          ),
                        ),
                      );
                },
              ),
            ],
          ),
          BlocBuilder<EditMovieRatingReviewBloc, EditMovieRatingReviewState>(
            builder: (context, state) {
              if (state is EditMovieRatingReviewSubmittingState) {
                rating = state.rating;
                return const CircularProgressIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
