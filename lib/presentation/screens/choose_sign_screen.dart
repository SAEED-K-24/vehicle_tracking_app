import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/presentation/screens/screens.dart';

import '../widgets/widgets.dart';


class ChooseSignScreen extends StatelessWidget {
  const ChooseSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 64.h),
        child: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoWidget(),
            Text("مرحباً",style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),),
            SizedBox(height: 4.h,),
            Text("اختر طريقة التسجيل",style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
            ),),
            SizedBox(height: 32.h,),
            CustomButtonWidget(title: "أدخل الكود",onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  EnterDriverCode(),));
            },),
            SizedBox(height: 16.h,),
            CustomButtonWidget(title: "اشتراك جديد",onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignSubscriptionsScreen(),));
            },),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                },
                child: Text(
                  'لدي حساب مسبق',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
