import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/screens/hide_mode_screen.dart';
import 'package:vehicle_tracking/screens/profile_screen.dart';
import 'package:vehicle_tracking/screens/trips_history_screen.dart';
import 'package:vehicle_tracking/screens/trips_observeing_screen.dart';
import 'package:vehicle_tracking/constant.dart';

class ManagerLayoutScreen extends StatefulWidget {
  final User user;
  final List<User> drivers;
  const ManagerLayoutScreen({super.key,required this.user,required this.drivers});

  @override
  State<ManagerLayoutScreen> createState() => _ManagerLayoutScreenState();
}

class _ManagerLayoutScreenState extends State<ManagerLayoutScreen>{
  int _index = 0;
  var pages = [];
  List<User> _drvivers = [];
  @override
  void initState() {
    // TODO: implement initState
    _drvivers = widget.drivers;
    pages = [
      TripsObservingScreen(user: widget.user,drivers: _drvivers),
      // TripHistoryPage(
      //   isOwner: true,
      // ),
      HideModeScreen(user: widget.user,drivers: _drvivers),
      ProfileScreen(user: widget.user,),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthState>(
      listener: (context, state) {
        if(state is DeleteDriverError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حدث خطأ، لم يتم حذف السائق")));
        }
        if(state is DeleteDriverSuccess){
          _drvivers.remove(state.driver);
          pages = [
            TripsObservingScreen(user: widget.user,drivers: _drvivers),
            // TripHistoryPage(
            //   isOwner: true,
            // ),
            HideModeScreen(user: widget.user,drivers: _drvivers),
            ProfileScreen(user: widget.user,),
          ];
          setState(() {

          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حذف السائق")));
        }
      },
      builder: (context,state) {
        if(state is DeleteDriverLoading){
          return Scaffold(body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 5.h,),
                Text("يتم حدف السائق الآن"),
              ],
            ),
          ),);
        }
        return Scaffold(
          body: pages[_index],
          bottomNavigationBar: Theme(
            data: ThemeData(
              canvasColor: PRIMARY_COLOR.withOpacity(0.8),
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    label: 'مراقبة الرحلات'),
                // BottomNavigationBarItem(
                //     icon: Icon(Icons.history), label: 'التقارير'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.hide_source), label: 'وضع الخفي'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'الصفحة الشخصية'),
              ],

              // backgroundColor: PRIMARY_COLOR.withOpacity(0.8),
              showSelectedLabels: false,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              currentIndex: _index,
              onTap: (value) => setState(() {
                _index = value;
              }),
            ),
          ),
        );
      }
    );
  }
}
