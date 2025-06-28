import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_tracking/data/models/models.dart';

class UserRepository {
  // UserRepository._();
  // static UserRepository userRepository = UserRepository._();

  final FirebaseFirestore _firestore;
  UserRepository({required FirebaseFirestore firestore}):_firestore=firestore;

  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('Users');

  Future<void> addUser(User user) async {
    await _usersCollection.doc(user.id).set(user.toMap());
  }

  Future<void> updateUser(User user) async {
    await _usersCollection.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String userId) async {
    await _usersCollection.doc(userId).delete();
  }

  Future<User?> getUserById(String userId) async {
    try {
      final userData = await _firestore.collection('Users').doc(userId).get();
      if (userData.exists) {
        return User.fromMap(userData.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<List<User>?> getUsers() async{
    QuerySnapshot<Map<String,dynamic>> snapshot =   await FirebaseFirestore.instance.collection("Users").get();
    return snapshot.docs.map((e) {
      return User.fromMap(e.data());
    }).toList();
  }

  Stream<List<User>?> getUsersStream() {
    return _usersCollection.snapshots().map((snapshot) {
      if(snapshot.docs.isEmpty)return null;
      return snapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    }
    );
  }

  Stream<User?> getUserByIdStream(String userId) {
    return _usersCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return User.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Future<List<User>?> getUsersByRole(String role) async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('Users')
        .where('role', isEqualTo: role)
        .get();
        List<User> drivers  = querySnapshot.docs.map((e) {
          // if(e.data().isEmpty) return null;
          return User.fromMap(e.data());
        }).toList();
        return drivers;
  }


}