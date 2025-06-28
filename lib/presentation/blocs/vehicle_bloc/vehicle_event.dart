part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}



class StartTrip extends VehicleEvent {
  final String tripId;
  final String driverId;
  final LatLng location;

  StartTrip(this.tripId,this.driverId,this.location);

  @override
  List<Object> get props => [tripId,driverId,location];
}

class UpdateLocation extends VehicleEvent {
  final Trip trip;

  UpdateLocation(this.trip);

  @override
  List<Object> get props => [trip];
}

// class UpdateLocationFromBackground extends VehicleEvent {
//   final LocationDto location;
//
//   UpdateLocationFromBackground(this.location);
//
//   @override
//   List<Object> get props => [location];
// }



class StopTrip extends VehicleEvent {
  final Trip trip;

  StopTrip(this.trip);

  @override
  List<Object> get props => [trip];
}
