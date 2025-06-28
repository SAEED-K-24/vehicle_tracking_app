import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehicle_tracking/core/exceptions/exceptions.dart';
import 'package:vehicle_tracking/data/repositories/firestore/user_repositories.dart';

class FireAuthHelper {
  FireAuthHelper._();
  static final FireAuthHelper instance = FireAuthHelper._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw RegisterWeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw RegisterEmailAlreadyInUseException();
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw LoginUserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw LoginWrongPasswordException();
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> changePassword(String oldPassword,String newPassword)async{
    try {
      // التحقق من صحة كلمة المرور الحالية للمستخدم
      User? user = _auth.currentUser;
      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);
        // تحديث كلمة المرور
        await user.updatePassword(newPassword);
        // return credential.
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteUser()async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;

        // حذف مستند المستخدم من Firestore
        UserRepository _repo = UserRepository(
            firestore: FirebaseFirestore.instance);
        await _repo.deleteUser(user.uid);

        // حذف حساب المستخدم من Firebase Auth
        await user.delete();
      } else {
        throw Exception("لا يوجد مستخدم");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteUserFromAuth()async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
      } else {
        throw Exception("لا يوجد مستخدم");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
