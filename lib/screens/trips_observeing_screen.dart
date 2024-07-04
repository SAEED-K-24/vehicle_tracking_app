import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/repositories/repositories.dart';
import 'package:vehicle_tracking/screens/manger_trip_page.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/screens/screens.dart';

import '../blocs/blocs.dart';
import '../reuseable/functions.dart';

class TripsObservingScreen extends StatefulWidget {
  const TripsObservingScreen({super.key,required this.user,required this.drivers});
  final User user;
  final List<User> drivers;

  @override
  State<TripsObservingScreen> createState() => _TripsObservingScreenState();
}

class _TripsObservingScreenState extends State<TripsObservingScreen> {
  // List<User> drivers = [];
  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchTextFormField(context),
                SizedBox(height: 12.h,),
                Text("السائقين",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600),),
                SizedBox(height: 8.h,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx,index) {
                    if(index < widget.drivers.length) {
                      return _driverWidget(driver: widget.drivers[index]);
                    }
                    return _noDriverWidget(vehicleId: '${widget.user.vehicleIds?[index]}');
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.h,);
                  },
                  itemCount: widget.user.vehicleIds?.length??widget.drivers.length,
                ),
              ]),
        ),
      ),
    );
  }

  Widget _driverWidget({required User driver}){
    return Container(
      width: MediaQuery.sizeOf(context).width,
      // height: 200.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${driver.name}",style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),),
              InkWell(
                onLongPress: ()async {
                  await Clipboard.setData(ClipboardData(text: "${driver.vehicleId}"));
                  Fluttertoast.showToast(
                      msg: "تم نسخ النص",);
                },
                child: Text("${driver.vehicleId}",style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                ),),
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("هل تريد مشاهدة تحركات السائق ؟",style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),),
              // SizedBox(width: 4.w,),
              // Text(isHasTrip ? "نعم" : "لا",style: TextStyle(
              //   fontSize: 14.sp,
              //   fontWeight: FontWeight.w500,
              // ),),
              Spacer(),
              InkWell(
                onTap: () async{

                  TripRepository tripRepo = TripRepository();
                  List<Trip>? trips =  await tripRepo.getTrips(driver.id);
                  trips?.sort((a, b) => a.startTime!.compareTo(b.startTime!),);
                  if(trips == null || trips.isEmpty){
                    Fluttertoast.showToast(msg:"لا يوجد رحلة لمشاهدتها");
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManagerTripPage(tripId: trips!.last.id!,driverId: driver.id,tripRepository: tripRepo),));
                  },
                child: Container(
                    padding: EdgeInsets.all(6.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2.w),
                      shape: BoxShape.circle,
                      color: PRIMARY_COLOR,
                    ),
                    child: Icon(Icons.tv,color: Colors.black54,size: 30.r,)),
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("مشاهدة سجلات رحلات السائق",style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),),
              Spacer(),
              InkWell(
                onTap: (){
                  // TripRepository tripRepo = TripRepository();
                  // List<Trip>? trips =  await tripRepo.getTrips(driver.id);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TripHistoryPage(isOwner: true,driverId: driver.id),));
                },
                child: Container(
                    padding: EdgeInsets.all(6.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2.w),
                      shape: BoxShape.circle,
                      color: PRIMARY_COLOR,
                    ),
                    child: Icon(Icons.history,color: Colors.black54,size: 30.r,)),
              ),
            ],
          ),
          SizedBox(height: 12.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(icon: Icon(Icons.edit,color: Colors.grey,),onPressed: () {
              //   Fluttertoast.showToast(msg: "تعديل حساب السائق");
              // },),
              // SizedBox(width: 12.w,),
              IconButton(icon:Icon(Icons.delete,color: Colors.red,),onPressed: () async{

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('تأكيد حذف السائق'),
                      content: Text('هل أنت متأكد أنك تريد حذف حساب السائق نهائياً؟ سيتم فقدان جميع البيانات المرتبطة بهذا الحساب.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // إغلاق مربع الحوار
                          },
                          child: Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // تنفيذ عملية حذف الحساب
                            Navigator.of(context).pop();
                            context.read<AuthBloc>().add(AuthDeleteDriverRequested(driver: driver,manager: widget.user));
                          },
                          child: Text('حذف السائق'),
                        ),
                      ],
                    );
                  },
                );
              },),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noDriverWidget({required String vehicleId}){
    return Container(
      width: MediaQuery.sizeOf(context).width,
      // height: 200.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("لا يوجد حساب سائق",style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),),
          Text(vehicleId,style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
          ),),
          IconButton(onPressed: ()async {
            await Clipboard.setData(ClipboardData(text: vehicleId));
            Fluttertoast.showToast(
              msg: "تم نسخ النص",);
          }, icon: Icon(Icons.copy),),
        ],
      ),
      ],
    ),
    );
  }

  Widget _searchTextFormField(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(SearchScreen.searchScreenRoute);
      },
      child: Container(
        padding:EdgeInsets.only(right: 12.w),
        alignment: Alignment.centerRight,
        width: MediaQuery.sizeOf(context).width,
        height: 45.h,
        margin: EdgeInsetsDirectional.only(top: 12.h, start: 8.w, end: 8.w, bottom: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: PRIMARY_COLOR.withOpacity(0.1)
        ),
        child:const Icon(Icons.manage_search_outlined),
      ),
    );
  }
}


