import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_tracking/data/models/models.dart';

class FirestoreRepo{
  FirestoreRepo._();
  static FirestoreRepo firestoreRepo = FirestoreRepo._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> isDuplicateUniqueName(String id, String collection) async {
    QuerySnapshot query = await firestore
        .collection(collection)
        .where('id', isEqualTo: id)
        .get();
         return query.docs.isNotEmpty;
  }


}