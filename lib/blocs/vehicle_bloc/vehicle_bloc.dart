import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:vehicle_tracking/extensions/extensions.dart';
import 'package:vehicle_tracking/repositories/repositories.dart';
import '../../models/models.dart';
part 'vehicle_event.dart';
part 'vehicle_state.dart';



class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  late TripRepository _tripRepository;
  late StreamSubscription _getPositionSubscription;

  VehicleBloc() : super(VehicleInitial()) {
    _tripRepository = TripRepository();

    on<StartTrip>((event, emit)async {
      emit(VehicleLoading());
      String _currentAddress = await _getAddressFromLatLng(event.location);
      Trip trip = Trip(id: event.tripId,driverId: event.driverId,startTime: DateTime.now(),
        fromCity: _currentAddress,
        route: [
          Location(latitude: event.location.latitude,longitude: event.location.longitude,timestamp: DateTime.now())
        ],
      );

      //استمر في الحصول على تحديثات الموقع
      _getPositionSubscription =  Geolocator.getPositionStream().listen((Position newPosition) async{
        List<Location> route = trip.route ?? [];
        route.add(Location(latitude: newPosition.latitude,longitude: newPosition.longitude,timestamp: DateTime.now()));
        trip = trip.copyWith(route: route);
        if(await FirestoreRepo.firestoreRepo.isDuplicateUniqueName("${trip.id}", "Trips")){
          _tripRepository.updateTrip(trip,event.driverId);
        }else{
          _tripRepository.addTrip(trip,event.driverId);
        }
        add(UpdateLocation(trip));
      });


    });

    on<UpdateLocation>((event, emit)async {
      _tripRepository.addTrip(event.trip,event.trip.driverId!);
      emit(TripInProgress(event.trip));
    });

    // on<UpdateLocationFromBackground>((event, emit) async {
    //   Trip trip = (state as TripInProgress).trip;
    //   List<Location> route = trip.route ?? [];
    //   route.add(Location(latitude: event.location.latitude, longitude: event.location.longitude, timestamp: DateTime.now()));
    //   trip = trip.copyWith(route: route);
    //   await _tripRepository.updateTrip(trip, trip.driverId!);
    //   emit(TripInProgress(trip));
    // });

    on<StopTrip>((event, emit)async {
      emit(VehicleLoading());
      _getPositionSubscription.cancel();
      String _currentAddress = await _getAddressFromLatLng(LatLng(event.trip.route!.last.latitude, event.trip.route!.last.longitude));
      double distance  = Geolocator.distanceBetween(event.trip.route!.first.latitude, event.trip.route!.first.longitude,
          event.trip.route!.last.latitude, event.trip.route!.last.longitude).toPrecision(2);
      Trip trip = event.trip.copyWith(
        endTime: DateTime.now(),
        distance:distance,
        toCity: _currentAddress,
      );
      await _tripRepository.updateTrip(trip,event.trip.driverId!);
      emit(TripStopped());
    });

  }

  @override
  Future<void> close() {
    _getPositionSubscription.cancel();
    return super.close();
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    String _currentAddress = '';
    await placemarkFromCoordinates(
        position!.latitude, position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
      '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      return _currentAddress;
    }).catchError((e) {
      throw Exception(e.toString());
    });
    return _currentAddress;
  }



}
