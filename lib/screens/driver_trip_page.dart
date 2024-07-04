import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:vehicle_tracking/blocs/blocs.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/reuseable/reuseable.dart';
import 'package:uuid/uuid.dart';


class DriverTripPage extends StatefulWidget {
  User user;

  DriverTripPage({super.key,required this.user});
  @override
  State<DriverTripPage> createState() => _DriverTripPageState();
}

class _DriverTripPageState extends State<DriverTripPage> {
  // Position? currentPosition;
  // LatLng currentLocation = LatLng(51.5, -0.09); // الموقع الابتدائي
  bool _isloading = true;
  List<LatLng> _points = [];
  Trip? trip;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showMyDialog(context: context, message: "تم رفض إذن الموقع");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showMyDialog(context: context, message: "لا يمكن استخدام خدمات الموقع بسبب رفض الإذن نهائياً");
      return;
    }

    Position _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _points.add(LatLng(_currentPosition.latitude, _currentPosition.longitude));
      _isloading = false;
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('رحلة السائق'),
      // ),
      body: BlocBuilder<VehicleBloc, VehicleState>(
        builder: (context, state) {

          if (state is TripInProgress) {
            // currentLocation = state.location;
            trip = state.trip;
            _points.add(LatLng(trip?.route!.last.latitude??0, trip?.route!.last.longitude??0));
          }

          return _isloading ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 5.h,),
              Text("تحميل الخرائط"),

            ],
          ),): Stack(
            // fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter:_points.isNotEmpty ?  _points.first : LatLng(0, 0),
                  initialZoom: 18,
                  maxZoom: 30,
                  minZoom: 8,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    // urlTemplate: 'https://basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _points,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers:_points.map((e) => Marker(
                      width: 40.0,
                      height: 40.0,
                      point: LatLng(e.latitude,e.longitude),
                      child: Container(
                        child: Icon(Icons.location_on, color: Colors.red, size: 20),
                      ),
                    ),).toList(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: state is TripInProgress
                    ? ElevatedButton(
                  onPressed: () {
                    if(state is VehicleLoading)return;
                    if(trip == null)return;
                    context.read<VehicleBloc>().add(StopTrip(trip!));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child:(state is VehicleLoading) ? CircularProgressIndicator(): Text('إيقاف الرحلة'),
                )
                    : ElevatedButton(
                  onPressed: () {
                    if(state is VehicleLoading)return;
                    if(_points.isEmpty){
                      showMyDialog(context: context);
                      return;
                    }

                    // _getCurrentLocation();
                    var uuid = const Uuid();
                    var uuidString = uuid.v1();
                    context.read<VehicleBloc>().add(StartTrip(uuidString,widget.user.id,_points.last));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                  ),
                  child:(state is VehicleLoading) ? CircularProgressIndicator(): Text('بدء الرحلة'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
