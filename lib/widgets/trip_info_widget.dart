import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// class SendRequestWidget extends StatelessWidget {
//   const SendRequestWidget({super.key, required this.trip, this.onTap});
//
//   final Trip trip;
//   final Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 20.h,
//       left: 10.w,
//       right: 10.w,
//       child: Container(
//         padding: EdgeInsets.all(10.r),
//         decoration: BoxDecoration(
//           color: primaryColor,
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         // height: 40.h,
//         width: MediaQuery.sizeOf(context).width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RichText(
//               text: TextSpan(
//                 text: 'time of trip:',
//                 style: TextStyle(fontSize: 18.sp),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: ' ${trip.timeOfTrip} mints',
//                       style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             RichText(
//               text: TextSpan(
//                 text: 'distance:',
//                 style: TextStyle(fontSize: 18.sp),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: ' ${trip.distance} km',
//                       style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             RichText(
//               text: TextSpan(
//                 text: 'from:',
//                 style: TextStyle(fontSize: 18.sp),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: ' ${trip.fromCity}',
//                       style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             RichText(
//               text: TextSpan(
//                 text: 'to:',
//                 style: TextStyle(fontSize: 18.sp),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: ' ${trip.toCity}',
//                       style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Center(
//                 child: CustomButtonWidget(
//                   title: 'Next',
//                   onTap: onTap,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
