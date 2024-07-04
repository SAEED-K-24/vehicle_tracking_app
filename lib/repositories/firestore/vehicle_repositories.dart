import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_tracking/models/vehicle.dart';

class VehicleRepository {
  VehicleRepository._();
  VehicleRepository vehicleRepository = VehicleRepository._();

  final CollectionReference _vehiclesCollection =
      FirebaseFirestore.instance.collection('Vehicles');

  Future<void> addVehicle(Vehicle vehicle) async {
    await _vehiclesCollection.doc(vehicle.id).set(vehicle.toMap());
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    await _vehiclesCollection.doc(vehicle.id).update(vehicle.toMap());
  }

  Future<void> deleteVehicle(String vehicleId) async {
    await _vehiclesCollection.doc(vehicleId).delete();
  }

  Stream<List<Vehicle>?> getVehicles() {
    return _vehiclesCollection.snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      return snapshot.docs
          .map((doc) => Vehicle.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<Vehicle?> getVehicleById(String vehicleId) {
    return _vehiclesCollection.doc(vehicleId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return Vehicle.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Stream<List<Vehicle>?> getVehiclesByUserId(String userId) {
    return _vehiclesCollection
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      return snapshot.docs
          .map((doc) => Vehicle.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
