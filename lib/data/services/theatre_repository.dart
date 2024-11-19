import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:userside/data/model/movie/theatre_model.dart';

class TheatreRepository {
  final theatreCollection = FirebaseFirestore.instance.collection('theatres');
  final favCollection =
      FirebaseFirestore.instance.collection('favourite_theatres');

  Future<List<TheatreModel>> fetchTheatres() async {
    try {
      final docRef = await theatreCollection.get();
      List<TheatreModel> theatres = docRef.docs.map((doc) {
        return TheatreModel.fromMap(doc.data());
      }).toList();
      return theatres;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<TheatreModel>> searchTheatresInTheatrePage(String query) async {
    final docRef = await theatreCollection.get();
    List<TheatreModel> theatres = docRef.docs.map((doc) {
      return TheatreModel.fromMap(doc.data());
    }).toList();
    List<TheatreModel> filteredTheatres = theatres.where((theatre) {
      final lowerCaseQuery = query.toLowerCase();
      final lowerCaseName = theatre.name.toLowerCase();
      String lowerAddress = theatre.address.toLowerCase();
      return lowerCaseName.contains(lowerCaseQuery) ||
          lowerAddress.contains(lowerCaseQuery);
    }).toList();
    return filteredTheatres;
  }

  Future<void> addTofavTheatre(
      {required String theatreId, required String userId}) async {
    try {
      await favCollection
          .doc(userId)
          .collection('favourites')
          .doc(theatreId)
          .set({'theatreId': theatreId});
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> removeFromFavTheatre(
      {required String theatreId, required String userId}) async {
    try {
      await favCollection
          .doc(userId)
          .collection('favourites')
          .doc(theatreId)
          .delete();
    } on FirebaseException catch (e) {
      log('errordelete: $e');
      rethrow;
    }
  }

  Future<bool> isTheatreInFavorites(
      {required String theatreId, required String userId}) async {
    try {
      DocumentSnapshot documentSnapshot = await favCollection
          .doc(userId)
          .collection('favourites')
          .doc(theatreId)
          .get();
      return documentSnapshot.exists;
    } on FirebaseException catch (e) {
      log('Error checking if theatre exists in favorites: $e');

      return false;
    }
  }

  Future<List<TheatreModel>> fetchFavTheatres({required emailId}) async {
    try {
      final docRef =
          await favCollection.doc(emailId).collection('favourites').get();
      final favEmails = docRef.docs.map((doc) => doc['theatreId']).toList();
      final allTheatres = await fetchTheatres();
       List<TheatreModel> favTheatres = allTheatres.where((theatre) {
      return favEmails.contains(theatre.emailId);
    }).toList();

      return favTheatres;
    } on FirebaseException catch (e) {
      log('Error fetching in favorites: $e');
    }
    return [];
  }
}
