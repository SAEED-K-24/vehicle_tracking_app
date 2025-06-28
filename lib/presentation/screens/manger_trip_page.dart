import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:vehicle_tracking/data/models/trip.dart';
import 'package:vehicle_tracking/data/repositories/firestore/trip_repositories.dart';
import 'package:vehicle_tracking/presentation/blocs/blocs.dart';
import 'package:vehicle_tracking/core/constant.dart';
import 'package:vehicle_tracking/core/reuseable/functions.dart';

class ManagerTripPage extends StatelessWidget {
  String tripId;
  String driverId;
  TripRepository tripRepository;

  ManagerTripPage({required this.tripId,required this.driverId,required this.tripRepository});

  // final Stream<LatLng> locationStream;
  List<Location> _points=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مراقبة الرحلة'),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
      ),
      body: StreamBuilder<Trip?>(
        stream: tripRepository.getTripById(tripId,driverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 100.w,height: 100.h,decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/not_started.png",)
                )),
                ),
                SizedBox(height: 12.h,),
                Text('لم تبدأ الرحلة بعد.'),
              ],
            ));
          }

          if(snapshot.data?.endTime != null){
            _points = snapshot.data?.route ?? [];
            _points.sort((a, b) => a.timestamp.compareTo(b.timestamp),);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter:_points.isNotEmpty ?  LatLng(_points.first.latitude,_points.first.longitude) : LatLng(0, 0),
                  initialZoom: 18,
                  maxZoom: 30,
                  minZoom: 8,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers:[
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(_points.first.latitude, _points.first.longitude),
                        child: Container(
                          child: Icon(Icons.location_on, color: Colors.red, size: 20),
                        ),
                      ),
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(_points.last.latitude, _points.last.longitude),
                        child: Container(
                          child: Icon(Icons.location_on, color: Colors.red, size: 20),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  alignment: Alignment.center,
                  width: 120.w,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text("الرحلة منتهية",style: TextStyle(fontSize: 16.sp,),),
                ),
              )
            ],
          );
          }

          // currentLocation = snapshot.data!;
          _points = snapshot.data?.route ?? [];
          return FlutterMap(
            options: MapOptions(
              initialCenter:_points.isNotEmpty ?  LatLng(_points.first.latitude,_points.first.longitude) : LatLng(0, 0),
              initialZoom: 18,
              maxZoom: 30,
              minZoom: 8,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayer(
                markers:_points.map((e) => Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(e.latitude, e.longitude),
                  child: Container(
                    child: Icon(Icons.location_on, color: Colors.red, size: 20),
                  ),
                ),).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}