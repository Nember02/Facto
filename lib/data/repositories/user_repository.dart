import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String uid, String email, String role) async {
    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'role': role,
    });
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }
}
