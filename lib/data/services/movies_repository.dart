import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';
import 'package:userside/data/model/show_model.dart';

class MoviesRepository {
  final movies = FirebaseFirestore.instance.collection('movies');

  Future<List<MovieClass>> fetchAllMovieshows() async {
    try {
      final movieShows = await movies.get();
      final movieList = movieShows.docs.map((doc) {
        return MovieClass.fromJson(doc.data());
      }).toList();
      return movieList;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<MovieClass>> fetchComingSoonMovieshows() async {
    try {
      final movies = await fetchAllMovieshows();
      final moviesList = movies.where((movie) {
        DateTime releaseDate =
            DateFormat("dd/MM/yyyy").parse(movie.releaseDate);
        return releaseDate.isAfter(DateTime.now());
      }).toList();
      return moviesList;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<MovieClass>> nowShowingMovies() async {
    try {
      final data = await FirebaseFirestore.instance.collection('Shows').get();
      final shows = data.docs.map((doc) {
        return ShowModel.fromMap(doc.data());
      }).toSet();
      final movies = await fetchAllMovieshows();
      // Assuming `movies` is a list of MovieClass and `shows` is a list of ShowModel
      final showMovieIds = shows
          .map((show) => show.movie.movieName)
          .toSet(); // Get unique movie IDs from shows
      final showMovies = movies
          .where((movie) => showMovieIds.contains(movie.movieName))
          .toList(); // Filter movies based on IDs in shows

      return showMovies;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<MovieClass> getMovie(String movieId) async {
    try {
      final movie = await movies.doc(movieId).get();
      if (movie.exists) {
        return MovieClass.fromJson(movie.data() ?? {});
      } else {
        throw Exception("Movie not found");
      }
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<MovieClass> getMovieByName(String movieName) async {
    try {
      final querySnapshot =
          await movies.where('movieName', isEqualTo: movieName).get();
      if (querySnapshot.docs.isNotEmpty) {
        final movie = querySnapshot.docs.first;
        return MovieClass.fromJson(movie.data() as Map<String, dynamic>);
      } else {
        throw Exception("Movie not found");
      }
    } on FirebaseException catch (e) {
      print('Error fetching movie: $e');
      rethrow;
    }
  }

  Future<void> addReviewToMovie(
      String movieId, MovieReviewModel newReview) async {
    DocumentReference movieRef =
        FirebaseFirestore.instance.collection('movies').doc(movieId);

    try {
      DocumentSnapshot movieSnapshot = await movieRef.get();
      if (movieSnapshot.exists) {
        MovieClass movie =
            MovieClass.fromJson(movieSnapshot.data() as Map<String, dynamic>);
        List<MovieReviewModel> updatedReviews = List.from(movie.review)
          ..add(newReview);
        await movieRef.update({
          'reviews': updatedReviews.map((review) => review.toMap()).toList(),
        });

        print('Review added successfully.');
      } else {
        print('Movie not found.');
      }
    } catch (e) {
      print('Failed to add review: $e');
    }
  }

  Future<bool> checkIfUserHasRated(
      {required MovieClass? movie, required String movieId}) async {
    if (movie != null) {
      return movie.review.any(
          (review) => review.userId == FirebaseAuth.instance.currentUser!.uid);
    }
    return false;
  }

  Future<MovieReviewModel?> movieReviewToEdit({
    required MovieClass? movie,
    required String movieId,
  }) async {
    if (movie != null) {
      try {
        return movie.review.firstWhere((review) =>
            review.userId == FirebaseAuth.instance.currentUser!.uid);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> editUserReview({
    required String movieId,
    required String newComment,
    required int newRating,
  }) async {
    final doc = await FirebaseFirestore.instance
        .collection('movies')
        .doc(movieId)
        .get();

    if (doc.exists) {
      final movie = MovieClass.fromJson(doc.data() as Map<String, dynamic>);
      List<MovieReviewModel> reviews = movie.review;
      final userReviewIndex = reviews.indexWhere(
        (review) => review.userId == FirebaseAuth.instance.currentUser!.uid,
      );

      if (userReviewIndex != -1) {
        reviews[userReviewIndex] = MovieReviewModel(
          userId: reviews[userReviewIndex].userId,
          userName: reviews[userReviewIndex].userName,
          rating: newRating,
          comment: newComment,
          dateTime: DateTime.now(),
          movieId: movieId,
          userProfile: reviews[userReviewIndex].userProfile,
        );
        await FirebaseFirestore.instance
            .collection('movies')
            .doc(movieId)
            .update({
          'reviews': reviews.map((review) => review.toMap()).toList(),
        });
      } else {
        throw Exception("User's review not found");
      }
    } else {
      throw Exception('Movie not found');
    }
  }

  Future<List<MovieClass>> filterMoviesByName(String query) async {
    try {
      final movies = await fetchAllMovieshows();
      List<MovieClass> filteredMovies = movies.where((movie) {
        return movie.movieName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      return filteredMovies;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Map<int, double> calculateStarPercentages(List<MovieReviewModel> reviews) {
    final totalReviews = reviews.length;
    final starCounts = List<int>.filled(5, 0);

    for (var review in reviews) {
      if (review.rating >= 1 && review.rating <= 5) {
        starCounts[review.rating - 1]++;
      }
    }

    final starPercentages = {
      for (var i = 1; i <= 5; i++)
        i: totalReviews > 0 ? (starCounts[i - 1] / totalReviews) * 100 : 0.0,
    };

    return starPercentages;
  }
}
