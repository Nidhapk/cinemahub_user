import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userside/data/model/booking_model.dart';

class BookingRepository {
  final bookingCollection = FirebaseFirestore.instance.collection('booking');
  final fireStoreCollection = FirebaseFirestore.instance.collection('Shows');

  Future<DocumentReference<Map<String, dynamic>>> bookingSeat(
      BookingModel bookingModel) async {
    final docRef = await bookingCollection.add(bookingModel.toJson());
    final docId = docRef.id;
    await docRef.update({'bookingId': docId,'timeStamp':FieldValue.serverTimestamp()});
    return docRef;
  }

  Future<void> updateMultipleSeatDetails(
      String showId, Map<int, String> seatUpdates) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await fireStoreCollection.doc(showId).get();

      if (docSnapshot.exists) {
        // Extract the 'room' field from the document
        Map<String, dynamic> room =
            docSnapshot.data()?['room'] as Map<String, dynamic>? ?? {};

        // Extract the 'seatDetails' from the 'room' field
        List<String> seatDetails = List<String>.from(room['seatDetails'] ?? []);

        // Loop through the Map<int, String> seatUpdates
        seatUpdates.forEach((index, newSeatDetail) {
          if (index >= 0 && index < seatDetails.length) {
            seatDetails[index] = newSeatDetail;
          } else {
            throw Exception("Index $index out of bounds");
          }
        });

        // Update the 'seatDetails' inside the 'room'
        await fireStoreCollection.doc(showId).update({
          'room.seatDetails':
              seatDetails, // Updating 'seatDetails' inside 'room'
        });
      } else {
        throw Exception("Show document does not exist");
      }
    } on FirebaseException catch (e) {
      log('Error updating seat details at indexes: $e');
      rethrow;
    }
  }

  Future<BookingModel> fetchBookingDetails(final String bookingId) async {
    try {
      final docRef = await bookingCollection.doc(bookingId).get();
      if (docRef.exists) {
        return BookingModel.fromJson(docRef.data() as Map<String, dynamic>);
      } else {
        throw Exception('Booking not found');
      }
    } on FirebaseException catch (e) {
      log('FirebaseException: $e');
      rethrow;
    } catch (e) {
      log('Error fetching booking details: $e');
      rethrow;
    }
  }

  Future<List<BookingModel>> fetchMyBookings(String userId) async {
    try {
      final docRef = await bookingCollection.get();
      final List<BookingModel> bookings = docRef.docs.map((doc) {
        return BookingModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      final filteredbookings =
          bookings.where((booking) => booking.userId == userId).toList();
      return filteredbookings;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
