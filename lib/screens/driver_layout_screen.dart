import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_tracking/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/reuseable/functions.dart';
import 'package:vehicle_tracking/screens/choose_sign_screen.dart';
import 'package:vehicle_tracking/screens/driver_trip_page.dart';
import 'package:vehicle_tracking/screens/profile_screen.dart';
import 'package:vehicle_tracking/screens/trips_history_screen.dart';
import '../models/user.dart';

class DriverLayoutScreen extends StatefulWidget {
  final User user;
  const DriverLayoutScreen({super.key,required this.user});

  @override
  State<DriverLayoutScreen> createState() => _DriverLayoutScreenState();
}

class _DriverLayoutScreenState extends State<DriverLayoutScreen> {
  int _index = 0 ;
  var pages = [];
  List<String> titles=["رحلة السائق","السجلات","الصفحة الشخصية"];
  @override
  void initState() {
    // TODO: implement initState
    pages = [DriverTripPage(user:widget.user),TripHistoryPage(isOwner: false,driverId: widget.user.id,),
      ProfileScreen(user: widget.user,),];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.gps_fixed),label: 'ابدأ الرحلة'),
          BottomNavigationBarItem(icon: Icon(Icons.history),label: 'السجلات'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'الصفحة الشخصية'),
        ],
        showSelectedLabels: false,
        backgroundColor: PRIMARY_COLOR.withOpacity(0.8),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _index,
        onTap: (value) => setState(() {
          _index = value;
        }),
      ),
    );
  }
}