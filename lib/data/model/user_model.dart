import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userside/data/methods/encrypt_decrypt.dart';


class UserModel {
  String? userId;
  String emailId;
  String password;

  UserModel({
    this.userId,
    required this.emailId,
    required this.password,
  });

  // Convert to map to store in firebase

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'emailId': encryptData(emailId),
      'password': encryptData(password),
    };
  }

  // Create UserModel instance from Firestore 

  factory UserModel.fromMap(QueryDocumentSnapshot<Object?> data) {
    return UserModel(
      userId: data.id,
      emailId: decryptData(data['emailId']),
      password: decryptData(data['password']),
    );
  }
}
