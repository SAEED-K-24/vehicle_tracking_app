import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/models.dart';

class HideModeRepository {
  final CollectionReference _hideModeModelsCollection =
  FirebaseFirestore.instance.collection('HideMode');

  Future<void> addHideModeModel(HideModeModel hideModeModel) async {
    await _hideModeModelsCollection.doc(hideModeModel.id).set(hideModeModel.toMap());
  }

  Future<void> updateHideModeModel(HideModeModel hideModeModel) async {
    await _hideModeModelsCollection.doc(hideModeModel.id).update(hideModeModel.toMap());
  }

  Future<void> deleteHideModeModel(String hideModeModelId) async {
    await _hideModeModelsCollection.doc(hideModeModelId).delete();
  }

  Stream<List<HideModeModel>?> getHideModeModelsStream() {
    return FirebaseFirestore.instance.collection('HideMode').snapshots().map((snapshot) => snapshot.docs.isEmpty ? null : snapshot.docs
        .map((doc) => HideModeModel.fromMap(doc.data()))
        .toList());
  }

  Future<List<HideModeModel>?> getHideModeModels() async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('HideMode').get();

    List<HideModeModel>? HideModeModels =  querySnapshot.docs.map((e) {
      return HideModeModel.fromMap(e.data());
    }).toList();
    return HideModeModels;
  }

  Stream<HideModeModel?> getHideModeModelById(String hideModeModelId) {
    return FirebaseFirestore.instance.collection('HideMode').doc(hideModeModelId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return HideModeModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }


}