// import 'dart:developer';
// import 'package:vehicle_tracking/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:vehicle_tracking/blocs/map_bloc/map_bloc.dart';
// import 'package:vehicle_tracking/main.dart';
// import 'package:vehicle_tracking/models/latlong.dart';
// import 'package:vehicle_tracking/reuseable/functions.dart';
//
// class SeacrhLocationPage extends StatefulWidget {
//   const SeacrhLocationPage({super.key});
//
//   @override
//   State<SeacrhLocationPage> createState() => _SeacrhLocationPageState();
// }
//
// class _SeacrhLocationPageState extends State<SeacrhLocationPage> {
//   final TextEditingController _textEditingController = TextEditingController();
//   var searchInfo = <SearchInfo>[];
//   bool isLoading = false;
//   String country = '';
//   List<String> countries = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: TextField(
//                     controller: _textEditingController,
//                     decoration: const InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: PRIMARY_COLOR),
//                       ),
//                     ),
//                   )),
//                   IconButton(
//                       onPressed: () async {
//                         if (_textEditingController.text.isEmpty) {
//                           Fluttertoast.showToast(msg: "يجب ملأ مستطيل البحث");
//                           return;
//                         }
//                         isLoading = true;
//                         setState(() {
//
//                         });
//                         var data = await addressSuggestion(
//                             _textEditingController.text);
//                         if (data.isNotEmpty) {
//                           searchInfo = data;
//                           setState(() {
//                             isLoading = false;
//                           });
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.search,
//                         color: Colors.black,
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Text(
//               'اختار المدينة',
//               style: TextStyle(fontSize: 16.sp),
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Expanded(
//               child: isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : searchInfo.isEmpty
//                       ? Container()
//                       : BlocConsumer<MapBloc, MapState>(
//                           builder: (context, state) {
//                             return ListView.separated(
//                               padding: EdgeInsets.symmetric(horizontal: 10.w),
//                               separatorBuilder: (context, index) {
//                                 return SizedBox(
//                                   height: 20.h,
//                                 );
//                               },
//                               itemCount: searchInfo.length,
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   color: PRIMARY_COLOR,
//                                   padding: EdgeInsets.all(4.h),
//                                   child: ListTile(
//                                     onTap: () {
//                                       FocusScope.of(context).unfocus();
//                                       context.read<MapBloc>().add(
//                                             DrawRoadEvent(
//                                                 city: searchInfo[index]
//                                                     .address!
//                                                     .city,
//                                                 latLong: LatLong(
//                                                     lat: searchInfo[index]
//                                                         .point!
//                                                         .latitude,
//                                                     long: searchInfo[index]
//                                                         .point!
//                                                         .longitude)),
//                                           );
//                                       Navigator.pop(context);
//                                     },
//                                     title: Text(searchInfo[index]
//                                         .address!
//                                         .country
//                                         .toString()),
//                                     subtitle:
//                                         Text('${searchInfo[index].point}'),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           listener: (BuildContext context, MapState state) {
//                             // if (state is DrawingRoadErrorState) {
//                             //   FocusScope.of(context).unfocus();
//                             //   Navigator.of(context).pop();
//                             //   showMyDialog(
//                             //       context: context, description: "حدث خطأ ما!");
//                             // }
//                             // if (state is DrawingRoadLoadingState) {
//                             //   FocusScope.of(context).unfocus();
//                             //   onHorizontalLoading(
//                             //     context,
//                             //     "الرجاء الإنتظار قليلاً!",
//                             //     Colors.blue,
//                             //     false,
//                             //   );
//                             // }
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
