import 'package:geocoding/geocoding.dart';

class Trip {
  String? id;
  String? driverId;
  String? fromCity;
  String? toCity;
  // LatLong? fromLatLong;
  // LatLong? toLatLong;
  double? distance;
  double? estimatedTime;
  DateTime? startTime;
  DateTime? endTime;
  final List<Location>? route;

  Trip({
     this.id,
     this.driverId,
     this.fromCity,
     this.toCity,
     this.estimatedTime,
     // this.fromLatLong,
     // this.toLatLong,
     this.distance,
     this.startTime,
     this.endTime,
    this.route,
  });
  factory Trip.fromMap(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      driverId: json['driverId'],
      fromCity: json['fromCity'],
      toCity: json['toCity'],
      distance: json['distance'],
      startTime: json['startTime']?.toDate(),
      estimatedTime:json['estimatedTime'] ,
      endTime:json['endTime']?.toDate(),
      route: (json['route'] as List)
          .map((item) => Location.fromMap(item))
          .toList(),
      // fromLatLong: json['fromLatLong'] != null ? LatLong.fromJson(json['fromLatLong']):null,
      // toLatLong: json['toLatLong'] != null ? LatLong.fromJson(json['toLatLong']):null,
    );
  }

  toMap() {
    return {
      "id":id,
      'driverId': driverId,
      'fromCity': fromCity,
      'toCity': toCity,
      'distance': distance,
      'startTime': startTime,
      'endTime': endTime,
      'estimatedTime':estimatedTime,
      // 'fromLatLong': fromLatLong?.toJson(),
      // 'toLatLong': toLatLong?.toJson(),
      'route': route?.map((location) => location.toJson()).toList(),
    };
  }

  Trip copyWith({
    String? id,
    String? driverId,
    String? fromCity,
    String? toCity,
    // LatLong? fromLatLong,
    // LatLong? toLatLong,
    double? distance,
    double? estimatedTime,
    DateTime? startTime,
    DateTime? endTime,
    List<Location>? route,
  }) {
    return Trip(
        id: id ?? this.id,
        driverId: driverId ?? this.driverId,
        fromCity: fromCity ?? this.fromCity,
        toCity: toCity ?? this.toCity,
        // fromLatLong: fromLatLong,
        // toLatLong: toLatLong,
        distance: distance ?? this.distance,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        estimatedTime:estimatedTime ?? this.estimatedTime,
        route: route ?? this.route,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trip &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          driverId == other.driverId &&
          fromCity == other.fromCity &&
          toCity == other.toCity &&
          // fromLatLong == other.fromLatLong &&
          // toLatLong == other.toLatLong &&
          distance == other.distance &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          estimatedTime == other.estimatedTime;

  @override
  int get hashCode =>
      id.hashCode ^
      driverId.hashCode ^
      fromCity.hashCode ^
      toCity.hashCode ^
      // fromLatLong.hashCode ^
      // toLatLong.hashCode ^
      distance.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      estimatedTime.hashCode;

  @override
  String toString() {
    return 'Trip{id: $id, driverId: $driverId, estimatedTime: $estimatedTime, fromCity: $fromCity, toCity: $toCity,'
        // ' fromLatLong: $fromLatLong, toLatLong: $toLatLong,'
        ' distance: $distance, startTrip: $startTime, endTrip: $endTime}';
  }
}


//
// import 'location.dart';
//
// class Trip {
//   final String id;
//   final String vehicleId;
//   final String driverId;
//   final String? fromCity;
//   final String? toCity;
//   final DateTime startTime;
//   final DateTime endTime;
//
//
//   Trip({
//     required this.id,
//     required this.vehicleId,
//     required this.driverId,
//     required this.startTime,
//     required this.endTime,
//     required this.route,
//   });
//
//   factory Trip.fromMap(Map<String, dynamic> data) {
//     return Trip(
//       id: data['id'],
//       vehicleId: data['vehicleId'],
//       driverId: data['driverId'],
//       startTime: DateTime.parse(data['startTime']),
//       endTime: DateTime.parse(data['endTime']),
//       route: (data['route'] as List)
//           .map((item) => Location.fromMap(item))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'vehicleId': vehicleId,
//       'driverId': driverId,
//       'startTime': startTime.toIso8601String(),
//       'endTime': endTime.toIso8601String(),
//       'route': route.map((location) => location.toMap()).toList(),
//     };
//   }
//
//   Trip copyWith({
//     String? id,
//     String? vehicleId,
//     String? driverId,
//     DateTime? startTime,
//     DateTime? endTime,
//     List<Location>? route,
//   }) {
//     return Trip(
//       id: id ?? this.id,
//       vehicleId: vehicleId ?? this.vehicleId,
//       driverId: driverId ?? this.driverId,
//       startTime: startTime ?? this.startTime,
//       endTime: endTime ?? this.endTime,
//       route: route ?? this.route,
//     );
//   }
// }