import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/core/constant.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({super.key,required this.title,this.onTap,this.width,this.color});
  String title;
  double? width;
  Color? color;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40.h,
        width: width,
        decoration: BoxDecoration(
          color:color??PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text("$title",style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),),
      ),
    );
  }
}
