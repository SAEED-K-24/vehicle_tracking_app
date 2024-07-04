import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/main.dart';


class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({super.key,required this.icon,this.onTap});
  final IconData? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        // margin: EdgeInsetsDirectional.only(start: 20),
        height: 40.h,
        width: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: PRIMARY_COLOR,
        ),
        child: Icon(icon,color: Colors.white,),
      ),
    );
  }
}
