import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'custom_icon_widget.dart';

class TravelHistoryWidget extends StatefulWidget {
  final Trip trip;
  const TravelHistoryWidget({super.key, required this.trip});

  @override
  State<TravelHistoryWidget> createState() => _TravelHistoryWidgetState();
}

class _TravelHistoryWidgetState extends State<TravelHistoryWidget> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isTapped = true;
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(bottom: isTapped ? 20.h : 0.h),
            width: 335.w,
            height: isTapped ? 300.h : null,
            // alignment: Alignment.center,
            padding: EdgeInsetsDirectional.only(
                start: 31.w, top: 20.h, bottom: 20.h),
            decoration: BoxDecoration(
              color: PRIMARY_COLOR.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: PRIMARY_COLOR),
                        ),
                        Container(
                          height: 92.h,
                          width: 0.2.w,
                          color: Colors.white70,
                        ),
                        Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF70B200),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'من',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            Text(
                              DateFormat('hh:mm a').format(
                                  widget.trip.startTime ?? DateTime.now()),
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: !isTapped ? 120.w : 160.w,
                          child: Text(
                            "${widget.trip.fromCity}",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                            maxLines: !isTapped ? 1 : 3,
                            overflow: !isTapped ? TextOverflow.ellipsis : null,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Container(
                          width: 253.5.w,
                          height: 0.2.h,
                          color: Colors.white70,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'إلى',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            Text(
                              DateFormat('hh:mm a').format(
                                  widget.trip.endTime ?? DateTime.now()),
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                            width: !isTapped ? 120.w : 160.w,
                            child: Text(
                              "${widget.trip.toCity}",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                              maxLines: !isTapped ? 1 : 3,
                              overflow:
                                  !isTapped ? TextOverflow.ellipsis : null,
                            )),
                      ],
                    ),
                  ],
                ),
                if (isTapped)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "التاريخ: ${DateFormat("yyyy:MM:dd").format(widget.trip.startTime ?? DateTime.now())}",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              " المسافة: ${widget.trip.distance}",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (isTapped)
            CustomIconWidget(
              icon: Icons.keyboard_arrow_up_rounded,
              onTap: () {
                isTapped = false;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
