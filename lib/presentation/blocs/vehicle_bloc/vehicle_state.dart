part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class TripInProgress extends VehicleState {
  final Trip trip;

  TripInProgress(this.trip);

  @override
  List<Object> get props => [trip];
}

class TripStopped extends VehicleState {}
