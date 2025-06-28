import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  LogoWidget({super.key,this.height = 180,this.width=180});
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height.h,
        width: width.w,
        decoration:const BoxDecoration(
          image: DecorationImage(image:AssetImage("assets/images/vehicle_tracking_logo.png"), ),
        ),
      ),
    );
  }
}
