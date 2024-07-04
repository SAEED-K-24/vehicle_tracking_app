import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/repositories/firestore/hidemode_repositories.dart';
import 'package:vehicle_tracking/repositories/firestore/user_repositories.dart';

class HideModeScreen extends StatefulWidget {
  HideModeScreen({super.key,required this.user,required this.drivers});
  User user;
  List<User> drivers;

  @override
  State<HideModeScreen> createState() => _HideModeScreenState();
}

class _HideModeScreenState extends State<HideModeScreen> {
  late HideModeRepository hideModeRepository;
  List<HideModeModel> hideModels = [];
  List<String> driverNames=[];
  // bool _isLoading = false;
  @override
  void initState() {
    hideModeRepository = HideModeRepository();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          "وضع الخفي",
          style: GoogleFonts.cairo(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body:FutureBuilder(
            future: hideModeRepository.getHideModeModels(),
            builder: (context,snapshot) {
              if(snapshot.hasError || !snapshot.hasData){
                return Center(child: Text("لا يوجد سائقين"),);
              }
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              for(HideModeModel hideModeModel in snapshot.data!){
                for(User driver in widget.drivers){
                  if(hideModeModel.driverId == driver.id){
                    hideModels.add(hideModeModel);
                    driverNames.add(driver.name);
                  }
                }
              }

              return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(children: [
                      Text(
                        "يمكنك البدأ في تفعيل الوضع الخفي حتى لو كان السائق يقوم برحلة.",
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "في حالة السائق يقوم برحلة قد يأخذ بعض الوقت لتفعيل الوضع الخفي.",
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      hideModels.isEmpty ? Text("لا يوجد سائقين"): ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _widget(hideModels[index],driverNames[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(start: 8.0.w),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: 1.h,
                                color: Colors.grey,
                              ),
                            );
                          },
                          itemCount: hideModels.length),
                    ]),
                  ),
                );
            }
          ),
    );
  }

  _widget(HideModeModel hideModeModel,String name) {
    return Container(
      color: PRIMARY_COLOR.withOpacity(0.05),
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.key_off_rounded),
          SizedBox(
            width: 16.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${hideModeModel.id}",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                name,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () async{
                HideModeModel newHideMode = hideModeModel.copyWith(isHide: !(hideModeModel.isHide??false));
                hideModeModel = newHideMode;
                // hideModels = [];
                log("newHideMode ${newHideMode.isHide}");
                log("hideMode ${hideModeModel.isHide}");
                await hideModeRepository.updateHideModeModel(newHideMode);
                hideModels=[];
                setState(() {
                });
                Fluttertoast.showToast(
                    msg: hideModeModel.isHide??false
                        ? "لقد فعلت الوضع الخفي للسائق"
                        : "لقد الغيت الوضع الخفي");
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: hideModeModel.isHide??false ? PRIMARY_COLOR : Colors.grey,
              )),
        ],
      ),
    );
  }
}
