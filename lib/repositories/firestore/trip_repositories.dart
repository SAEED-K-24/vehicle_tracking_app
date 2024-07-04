import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_tracking/models/trip.dart';

class TripRepository {
  final CollectionReference _tripsCollection =
  FirebaseFirestore.instance.collection('Trips');

  Future<void> addTrip(Trip trip,String driverId) async {
    await FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips').doc(trip.id).set(trip.toMap());
  }

  Future<void> updateTrip(Trip trip,String driverId) async {
    await FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips').doc(trip.id).update(trip.toMap());
  }

  Future<void> deleteTrip(String tripId,String driverId) async {
    await FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips').doc(tripId).delete();
  }

  Stream<List<Trip>?> getTripsStream(String driverId) {
    return FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips').snapshots().map((snapshot) => snapshot.docs.isEmpty ? null : snapshot.docs
        .map((doc) => Trip.fromMap(doc.data()))
        .toList());
  }

  Future<List<Trip>?> getTrips(String driverId) async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips').get();

    List<Trip>? trips =  querySnapshot.docs.map((e) {
      return Trip.fromMap(e.data());
    }).toList();
    return trips;
  }

  Stream<Trip?> getTripById(String tripId,String driverId) {
    return FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips').doc(tripId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return Trip.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Stream<List<Trip>?> getTripsByTime(DateTime startTime, DateTime endTime,String driverId) {
    return FirebaseFirestore.instance.collection("Users").doc(driverId).collection('Trips')
        .where('startTime', isGreaterThanOrEqualTo: startTime)
        .where('endTime', isLessThanOrEqualTo: endTime)
        .snapshots()
        .map((snapshot) => snapshot.docs.isEmpty ? null :  snapshot.docs
        .map((doc) => Trip.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

}