// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_event.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_state.dart';
import 'package:userside/presentation/screens/movie/movie_details/widget/movie_rating.dart';
import 'package:userside/presentation/screens/movie/movie_details/widget/rating_bar.dart';
import 'package:userside/presentation/screens/movie/movie_details/widget/user_comments.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/ui/add_movie_rating.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/edit_movie_rating.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/ui/showing_theatres_screen.dart';
import 'package:userside/presentation/screens/movie/video_screen/ui/video_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/backdrop_conatiner.dart';
import 'package:userside/presentation/widget/play_button.dart';
import 'package:userside/presentation/widget/sizedbox_one.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String movieId;
  final String movieName;
  const MovieDetailsScreen(
      {super.key, required this.movieId, required this.movieName});

  @override
  Widget build(BuildContext context) {
    log('mpviezid: $movieId');
    context.read<MovieDetailsBloc>().add(FetchMovieDetailsinPageEvent(movieId));
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsLoaded) {
            final movie = state.movie;
            bool reviewAdded = state.reviewAdded;
            final ratings = state.ratings;
            List<MovieReviewModel> reviews = movie.review;
            int sum = 0;
            for (var i in reviews) {
              int rating = i.rating;
              sum += rating;
            }
            final average = sum / reviews.length;
            // DateTime parsedDate =
            //     DateFormat("dd/MM/yyyy").parse(movie.releaseDate);
            log('movie: $movie');
            return Stack(
              children: [
                Positioned(
                  top: height * 0.27,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Center(
                          child: Text(
                            movie.movieName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        Center(
                          child: Text(
                            movie.genres.join(', '),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${movie.duration.split(':')[0]}hr ${movie.duration.split(':')[1]}min . ${movie.certificate} . ${DateFormat('MMM dd yyy').format(DateFormat("dd/MM/yyyy").parse(movie.releaseDate))} ',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 92, 92, 92),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBoxOne(),
                        Center(
                          child: Container(
                            color: const Color.fromARGB(255, 192, 192, 192),
                            child: Text('  ${movie.languages.join(', ')}  '),
                          ),
                        ),
                        const SizedBoxOne(),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 27, 27, 30)),
                            child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, // Number of items per row
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 0, childAspectRatio: 1,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    shadows: const [
                                      Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(0.5, 0.5))
                                    ],
                                    color: index < 2
                                        ? Colors.yellow
                                        : const Color.fromARGB(
                                            255, 226, 224, 224),
                                    size: 20,
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 14, right: 14),
                          child: Text(
                            movie.description,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.05,
                              bottom: 20),
                          child: const Text(
                            'Cast',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.16,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: movie.castMembers.length,
                            itemBuilder: (context, index) {
                              final cast = movie.castMembers[index];
                              return Padding(
                                padding: EdgeInsets.only(right: width * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.18,
                                      height: width * 0.18,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            cast.imagePath,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: width * 0.18,
                                        child: Text(
                                          cast.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        reviewAdded
                            ? movieRating(
                                averagerating: average.toString(),
                                context: context,
                                title: 'Edit Review',
                                rateMovieonPressed: () =>
                                    navigateToEditMovieReview(
                                        context, movie.movieId ?? '', movie),
                              )
                            : movieRating(
                                averagerating: average.toString(),
                                context: context,
                                title: 'Rate this movie',
                                rateMovieonPressed: () =>
                                    navigateToAddMovieReview(
                                  context,
                                  movie.movieId ?? '',
                                ),
                              ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //  mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Column(
                              children: [
                                Text(
                                  average.isNaN ? '0' : average.toString(),
                                  style: const TextStyle(fontSize: 35),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviews.length == 1
                                          ? '1 Vote  '
                                          : '${reviews.length} Votes  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: width * 0.025),
                                    ),
                                    Icon(
                                      Icons.thumb_up_alt_rounded,
                                      color: primaryColor,
                                      size: width * 0.03,
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.12,
                              child: VerticalDivider(
                                color: Colors.grey.withOpacity(0.3),
                                thickness: 1,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ratingBar(
                                    context: context,
                                    star: '1',
                                    value: ratings[1] == null
                                        ? 0
                                        : ratings[1]! / 100,
                                    percentage: ratings[1] == null
                                        ? '0%'
                                        : ' ${ratings[1]!.toInt().toString()}%'),
                                ratingBar(
                                    context: context,
                                    star: '2',
                                    value: ratings[2] == null
                                        ? 0
                                        : ratings[2]! / 100,
                                    percentage: ratings[2] == null
                                        ? '0%'
                                        : ' ${ratings[2]!.toInt().toString()}%'),
                                ratingBar(
                                    context: context,
                                    star: '3',
                                    value: ratings[3] == null
                                        ? 0
                                        : ratings[3]! / 100,
                                    percentage: ratings[3] == null
                                        ? '0%'
                                        : ' ${ratings[3]!.toInt().toString()}%'),
                                ratingBar(
                                    context: context,
                                    star: '4',
                                    value: ratings[4] == null
                                        ? 0
                                        : ratings[4]! / 100,
                                    percentage: ratings[4] == null
                                        ? '0%'
                                        : ' ${ratings[4]!.toInt().toString()}%'),
                                ratingBar(
                                    context: context,
                                    star: '5',
                                    value: ratings[5] == null
                                        ? 0
                                        : ratings[5]! / 100,
                                    percentage: ratings[5] == null
                                        ? '0%'
                                        : ' ${ratings[5]!.toInt().toString()}%'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        userComments(context: context, reviews: reviews)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: height * 0.6,
                  left: -10,
                  right: -10,
                  child: Transform.scale(
                    scale: 1.2,
                    child: BackDropContainer(
                      imgUrl: movie.backdropImage,
                      height: height * 0.24,
                      width: width,
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.3,
                  left: width * 0.5 - 30,
                  child: movie.trailerLink.isEmpty
                      ? const SizedBox.shrink()
                      : PlayButton(
                          onTap: () {
                            context.read<MovieDetailsBloc>().add(
                                  PlayVideoEvent(YoutubePlayer.convertUrlToId(
                                          movie.trailerLink) ??
                                      ''),
                                );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideoScreen(
                                  moviedId: movieId,
                                  link: movie.trailerLink,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          } else if (state is MovieError) {
            return Text(state.message);
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowingTheatresScreen(
                  movieId: movieName,
                ),
              ),
            );
          },
          child: const Text('BOOK NOW'),
        ),
      ),
    );
  }
}

void navigateToEditMovieReview(
    BuildContext context, String movieId, MovieClass movie) async {
  final review = await MoviesRepository()
      .movieReviewToEdit(movie: movie, movieId: movieId);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditMovieRating(
        reviewModel: review!,
        movieId: movieId,
      ),
    ),
  );
}

void navigateToAddMovieReview(BuildContext context, String movieId) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => AddMovieRating(
        movieId: movieId,
      ),
    ),
  );
}
