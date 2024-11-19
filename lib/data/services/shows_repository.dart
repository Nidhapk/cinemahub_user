import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/data/model/show_model.dart';
import 'package:userside/data/services/movies_repository.dart';

class ShowsRepository {
  final showsCollection = FirebaseFirestore.instance.collection('Shows');
  Future<Map<TheatreModel, List<ShowModel>>> fetchTheatresByMovieId(
      String movieId) async {
    log('Fetching theatres and shows for movie ID: $movieId');
    try {
      final data = await showsCollection.get();
      log('Data retrieved from Firestore: $data');

      final shows = data.docs.map((show) {
        log('Raw data from Firestore: ${show.data()}');
        return ShowModel.fromMap(show.data());
      }).toList();

      log('Shows after mapping: $shows');
      final filteredShows =
          shows.where((show) => show.movieName == movieId).toList();
      log('Filtered shows: $filteredShows');

      Map<TheatreModel, List<ShowModel>> theatreShowMap = {};

      for (var show in filteredShows) {
        TheatreModel theatre = TheatreModel(
          userId: show.theatre.userId,
          emailId: show.theatre.emailId,
          name: show.theatre.name,
          address: show.theatre.address,
          latLng: show.theatre.latLng,
          phone: show.theatre.phone,
          profileImage: "profileImage",
          images: [],
        );

        // Check if this theatre already exists in the map
        if (theatreShowMap.containsKey(theatre)) {
          theatreShowMap[theatre]!
              .add(show); // Add the show to the existing list
        } else {
          theatreShowMap[theatre] = [
            show
          ]; // Initialize a new list for this theatre
        }
      }

      return theatreShowMap;
    } catch (e) {
      log('Error fetching theatres and shows: $e');
    }
    return {};
  }

  Future<Map<TheatreModel, List<ShowModel>>>
      fetchTheatresBySearchingTheatreName(
          String movieId, String searchQuery) async {
    log('Fetching theatres and shows for movie ID: $movieId');
    try {
      final data = await showsCollection.get();
      log('Data retrieved from Firestore: $data');

      final shows = data.docs.map((show) {
        log('Raw data from Firestore: ${show.data()}');
        return ShowModel.fromMap(show.data());
      }).toList();

      log('Shows after mapping: $shows');

      // Filter shows based on the movieId
      final filteredShows =
          shows.where((show) => show.movieName == movieId).toList();
      log('Filtered shows: $filteredShows');

      Map<TheatreModel, List<ShowModel>> theatreShowMap = {};

      for (var show in filteredShows) {
        TheatreModel theatre = TheatreModel(
          userId: show.theatre.userId,
          emailId: show.theatre.emailId,
          name: show.theatre.name,
          address: show.theatre.address,
          latLng: show.theatre.latLng,
          phone: show.theatre.phone,
          profileImage: "profileImage",
          images: [],
        );

        //query to filter theatres by name
        if (theatre.name.toLowerCase().contains(searchQuery.toLowerCase())) {
          if (theatreShowMap.containsKey(theatre)) {
            theatreShowMap[theatre]!.add(show);
          } else {
            theatreShowMap[theatre] = [show];
          }
        }
      }

      return theatreShowMap;
    } catch (e) {
      log('Error fetching theatres and shows: $e');
    }
    return {};
  }

  Future<List<ShowModel>> fetchAllShows() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Shows').get();

      List<ShowModel> shows = querySnapshot.docs.map((doc) {
        return ShowModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return shows;
    } catch (e) {
      throw Exception('Failed to fetch shows: $e');
    }
  }

  List<ShowModel> filterShowsByDate(List<ShowModel> shows) {
    // final startOfDay = DateTime(date.year, date.month, date.day);
    // final endOfDay =
    //     startOfDay.add(const Duration(hours: 23, minutes: 59, seconds: 59));

    // Filter shows where 'showDate' is between startOfDay and endOfDay
    final todaysShows = shows.where((show) {
      DateTime showDate = show.date;
      return isSameDay(showDate, DateTime.now());
    }).toList();
    log('todays shows: $todaysShows');
    return todaysShows;
  }

  Future<List<ShowModel>> fetchShowsForToday() async {
    try {
      List<ShowModel> allShows = await fetchAllShows();

      //  Filter shows by today's date
      //DateTime today = DateTime.now();
      List<ShowModel> todayShows = filterShowsByDate(allShows);
      log('new $todayShows');
      return todayShows;
    } catch (e) {
      throw Exception('Error fetching shows for today: $e');
    }
  }

  Future<List<MovieClass>> fetchTodaysMoviesByShow(
      List<ShowModel> shows) async {
    try {
      List<MovieClass> movies = [];

      // Step 1: Extract unique movie names from shows
      final Set<String> movieNamesInShows =
          shows.map((show) => show.movieName).toSet();

      // Step 2: Fetch all movies
      final allMovies = await MoviesRepository().fetchAllMovieshows();

      // Step 3: Filter movies based on unique movie names from shows
      movies = allMovies
          .where((movie) => movieNamesInShows.contains(movie.movieName))
          .toList();

      return movies;
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }

  Future<Map<String, List<ShowContainer>>> showingMoviesInSelectedTheatre(
      String emailId, DateTime selectedDate) async {
    try {
      log('date: $selectedDate');
      final List<ShowModel> allShows = await fetchAllShows();
      final List<ShowModel> allshowsInTheatre = allShows
          .where((show) =>
              show.theatre.emailId == emailId &&
              isSameDay(show.date, selectedDate))
          .toList();
      final Map<String, List<ShowContainer>> movieRoomsMap = {};
      for (var show in allshowsInTheatre) {
        final ShowContainer room = ShowContainer(
          showTime: show.time,
          screen: show.room.roomName,
        );
        if (movieRoomsMap.containsKey(show.movieName)) {
          movieRoomsMap[show.movieName]!.add(room);
        } else {
          movieRoomsMap[show.movieName] = [room];
        }
      }
      log('mo $movieRoomsMap');
      return movieRoomsMap;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}

class ShowContainer {
  final String showTime;
  final String screen;

  ShowContainer({
    required this.showTime,
    required this.screen,
  });
}
