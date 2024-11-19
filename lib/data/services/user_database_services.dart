import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userside/data/methods/encrypt_decrypt.dart';
import 'package:userside/data/model/user_model.dart';

class UserDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addUser(UserModel user) async {
    try {
      final userCollection = firestore.collection('users');
      await userCollection.add(user.toMap());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<UserModel> getUserData(String email) async {
  try {
    final usersCollection = firestore.collection('users');
    Query userQuery = usersCollection.where('emailaddress', isEqualTo: encryptData(email));
    QuerySnapshot<Object?> userSnap = await userQuery.get();

    if (userSnap.docs.isEmpty) {
      throw Exception('No user found with the provided email.');
    }

    final user = UserModel.fromMap(userSnap.docs.first);
    return user;
  } catch (e) {
    rethrow;
  }
}

}
