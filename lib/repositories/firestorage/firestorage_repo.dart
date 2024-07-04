import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirestorageRepo{
  FirestorageRepo._();
  static FirestorageRepo firestorageRepo = FirestorageRepo._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
// *********/********/*****
  Future<String> uploadNewImage(File file,String folderName) async {
    try {
      String fileName = file.path
          .split('/')
          .last;
      Reference reference = firebaseStorage.ref('$folderName/$fileName');
      await reference.putFile(file);
      String imageUrl = await reference.getDownloadURL();
      return imageUrl;
    }catch(e){
      throw e.toString();
    }
  }

  deleteImageFromStorage(String imageUrl) async{
    try {
      Reference reference = firebaseStorage.refFromURL(imageUrl);
      await reference.delete();
    }catch(e){
      throw e.toString();
    }
  }
}