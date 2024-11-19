import 'package:latlong2/latlong.dart';

class TheatreModel {
  String userId;
  String emailId; // User ID of the theatre owner
  String name; // Name of the theatre
  String address; // Address of the theatre
  LatLng latLng; // Latitude and longitude of the theatre (using latlong2)
  String phone; // Phone number of the theatre
  String profileImage; // Profile image of the theatre
  List<String> images; // List of other images of the theatre
 @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TheatreModel &&
        other.userId == userId; // Compare based on userId (or any unique identifier)
  }

  @override
  int get hashCode => userId.hashCode; 
  TheatreModel({
    required this.userId,
    required this.emailId,
    required this.name,
    required this.address,
    required this.latLng,
    required this.phone,
    required this.profileImage,
    required this.images,
  });

  // Factory method to create a TheatreModel from a map (useful when retrieving from Firestore)
  factory TheatreModel.fromMap(Map<String, dynamic> map) {
    // Use null-aware operators and provide default values if needed
    return TheatreModel(
      userId: map['userId'] as String? ?? 'Unknown User',
      emailId: map['emailId'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown Theatre',
      address: map['address'] as String? ?? 'Unknown Address',
      latLng: LatLng(
        map['lat'] as double? ?? 0.0, // Default to 0.0 if null
        map['lng'] as double? ?? 0.0, // Default to 0.0 if null
      ),
      phone: map['phone'] as String? ?? 'N/A', // Default to 'N/A' if null
      profileImage: map['profileImage'] as String? ?? '', // Default empty string if null
      images: List<String>.from(map['images'] ?? []), // Default to empty list if null
    );
  }

  // Method to convert TheatreModel to a map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'emailId': emailId,
      'name': name,
      'address': address,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
      'phone': phone,
      'profileImage': profileImage,
      'images': images,
    };
  }
}

