import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracking/data/models/trip.dart';
import 'package:vehicle_tracking/main.dart';

import 'custom_button.dart';

class SendRequestWidget extends StatelessWidget {
  const SendRequestWidget({super.key, required this.trip, this.onTap});

  final Trip trip;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      left: 10.w,
      right: 10.w,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(16.r),
        ),
        // height: 40.h,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'الوقت المتوقع للرحلة: ',
                style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ${trip.estimatedTime} دقيقة ',
                      style: GoogleFonts.cairo(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            RichText(
              text: TextSpan(
                text: 'مسافة الرحلة: ',
                style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ${trip.distance} كم ',
                      style: GoogleFonts.cairo(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            RichText(
              text: TextSpan(
                text: 'من: ',
                style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ${trip.fromCity}',
                      style: GoogleFonts.cairo(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            RichText(
              text: TextSpan(
                text: 'إلى: ',
                style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ${trip.toCity}',
                      style: GoogleFonts.cairo(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: CustomButtonWidget(
              title: 'بدأ الرحلة',
              onTap: onTap,
              width: 120.w,
              color: Colors.grey,
            )),
          ],
        ),
      ),
    );
  }
}
