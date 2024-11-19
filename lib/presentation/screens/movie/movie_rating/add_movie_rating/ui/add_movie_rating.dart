import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/custom_ratingbar.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/movie_rating_appbar.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/review_submitbutton.dart';
import 'package:userside/presentation/screens/movie/movie_rating/widget/review_textformfield.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/custom_snackbar.dart';

class AddMovieRating extends StatefulWidget {
  final String movieId;
  const AddMovieRating({super.key, required this.movieId});

  @override
  State<AddMovieRating> createState() => _AddMovieRatingState();
}

class _AddMovieRatingState extends State<AddMovieRating> {
  final TextEditingController reviewController = TextEditingController();

  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: movieRatingAppbar(
        onPressed: () {
          context.read<MovieRatingReviewBloc>().add(
                const ClearMovieRatingEvent(
                  0,
                ),
              );
          Navigator.of(context).pop();
        },
        title: 'Rate this movie',
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              BlocConsumer<MovieRatingReviewBloc, MovieRatingReviewState>(
                listener: (context, state) {
                  if (state is MovieRatingReviewSubmitSuccessState) {
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
                    context.read<MovieRatingReviewBloc>().add(
                          const ClearMovieRatingEvent(
                            0,
                          ),
                        );
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is MovieRatingState) {
                    rating = state.rating;
                  }
                  return customRatingBar(
                    onPressed: () {
                      context.read<MovieRatingReviewBloc>().add(
                            MovieRatingTapedEvent(
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
              ReviewSubmitButton<MovieRatingReviewBloc, MovieRatingReviewState>(
                listener: (context, state) {
                  if (state is MovieRatingState) {
                    rating = state.rating;
                  }
                },
                onPressed: () {
                  context.read<MovieRatingReviewBloc>().add(
                        MovieReviewSubmitted(
                          review: MovieReviewModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            userName: FirebaseAuth.instance.currentUser!.email
                                .toString(),
                            rating: rating,
                            comment: reviewController.text.trim(),
                            dateTime: DateTime.now(),
                            userProfile:
                                FirebaseAuth.instance.currentUser!.photoURL ??
                                    '',
                            movieId: widget.movieId,
                          ),
                        ),
                      );
                },
              ),
            ],
          ),
          BlocBuilder<MovieRatingReviewBloc, MovieRatingReviewState>(
            builder: (context, state) {
              if (state is MovieRatingReviewSubmittingState) {
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
