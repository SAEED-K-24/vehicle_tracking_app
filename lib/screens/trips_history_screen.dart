import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/repositories/firestore/trip_repositories.dart';
import '../widgets/custom_icon_widget.dart';
import '../widgets/trip_history_widget.dart';

class TripHistoryPage extends StatelessWidget {
  TripHistoryPage({super.key, required this.isOwner, required this.driverId});
  bool isOwner;
  String driverId;

  @override
  Widget build(BuildContext context) {
    TripRepository _tripRepo = TripRepository();
    return Scaffold(
      body: FutureBuilder<List<Trip>?>(
          future: _tripRepo.getTrips(driverId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (isOwner)
                          CustomIconWidget(
                            icon: Icons.arrow_back_ios_new_sharp,
                            onTap: () {
                              if (Navigator.canPop(context)) Navigator.pop(context);
                            },
                          ),
                        if (isOwner)
                          SizedBox(
                            width: 20.w,
                          ),
                        Text(
                          isOwner ? 'التقارير' : 'السجلات',
                          style: TextStyle(fontSize: 24.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty)
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                  "assets/images/empty_folder.png",
                                ))),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text('لا يوجد سجلات!'),
                            ],
                          ))
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TravelHistoryWidget(
                                trip: snapshot.data?[index] ?? Trip(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20.h);
                            },
                            itemCount: snapshot.data?.length ?? 1),
                  ],
                ),
              ),
            );
          }),
    );
  }


}
