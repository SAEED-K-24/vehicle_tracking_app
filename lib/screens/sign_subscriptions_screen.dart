import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:vehicle_tracking/main.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/screens/driver_layout_screen.dart';
import 'package:vehicle_tracking/screens/manger_layout_screen.dart';
import 'package:vehicle_tracking/screens/screens.dart';
import 'package:vehicle_tracking/widgets/custom_button.dart';
import 'package:vehicle_tracking/widgets/logo_widget.dart';
import 'package:vehicle_tracking/constant.dart';

class SignSubscriptionsScreen extends StatefulWidget {
  const SignSubscriptionsScreen({super.key});

  @override
  State<SignSubscriptionsScreen> createState() => _SignSubscriptionsScreenState();
}

class _SignSubscriptionsScreenState extends State<SignSubscriptionsScreen> {
  List<String> monthsSubList = ['3 شهور','6 شهور','سنة'];
  String monthsSubValue = '3 شهور';

  List<int> driverNumList = [1,2,3,4,5,6,7,8,9,10];
  int driverNumValue = 1;

  double price = 13.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text("الاشتراكات"),
        leading: IconButton(
          onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseSignScreen(),));
        },
        icon: Icon(Icons.arrow_back),),
    ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoWidget(),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("الإشتراكات الشهرية",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),),
                DropdownButton(
                  items: monthsSubList.map((value) => DropdownMenuItem(value: value,child: Text(value),)).toList(),
                  onChanged: (value) {
                    monthsSubValue  = value ?? '';
                    if(monthsSubValue == monthsSubList[0]){
                      price = price;
                    }else if (monthsSubValue == monthsSubList[1]){
                      price *= 1.5;
                    }else{
                      price *=2 ;
                    }
                    setState(() {

                    });
                  },
                  value: monthsSubValue,
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("عدد السائقين",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),),
                DropdownButton(
                  items: driverNumList.map((value) => DropdownMenuItem(value: value,child: Text('$value'),)).toList(),
                  onChanged: (value) {
                    driverNumValue  = value??1;
                    price *= driverNumValue;
                    setState(() {

                    });
                  },
                  value: driverNumValue,
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("سعر الاشتراك",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),),
                Text("$price \$",style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),),
              ],
            ),
            SizedBox(height: 20.h,),
            CustomButtonWidget(title: "تسجيل الاشتراك",onTap: () {
              List<String> vehicleIds = [];
              for(int i = 0 ; i < driverNumValue ; i++){
                var uuid = const Uuid();
                var uuidString = uuid.v1().substring(0,8);
                vehicleIds.add(uuidString);
              }
              DateTime endDate;
              if (monthsSubValue == '3 شهور') {
                endDate = DateTime.now().add(Duration(days: 90));
              } else if (monthsSubValue == '6 شهور') {
                endDate = DateTime.now().add(Duration(days: 180));
              } else {
                endDate = DateTime.now().add(Duration(days: 365));
              }
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>RegisterPage(userRole: UserRole.manager,vehicleIds: vehicleIds,subscriptionEndDate: endDate,isSubscribed: true,),),);
            },),
          ],
        ),
      ),
    );
  }
}
