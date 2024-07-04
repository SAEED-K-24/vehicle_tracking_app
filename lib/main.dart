import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehicle_tracking/blocs/blocs.dart';
import 'package:vehicle_tracking/blocs/hidemode_bloc/hidemode_bloc.dart';
import 'package:vehicle_tracking/helper/save_sign_in_helper.dart';
import 'package:vehicle_tracking/models/trip.dart';
import 'package:vehicle_tracking/repositories/fireauth/auth_data.dart';
import 'package:vehicle_tracking/screens/splash_screen.dart';
import 'package:vehicle_tracking/widgets/send_request_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);



  CacheHelper.init();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("ar"),],
      path: 'assets/translations',
      child: MultiBlocProvider( providers:[
       BlocProvider(create:  (context) => AuthBloc(authHelper: FireAuthHelper.instance),),
       BlocProvider(create:  (context) => VehicleBloc(),),
        BlocProvider(create: (context) => HideModeBloc(),),
      ],child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'BayanHR',
          supportedLocales:const [
            Locale("ar"),
          ],
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          theme: ThemeData(
            // scaffoldBackgroundColor: Colors.brown,
            primarySwatch: Colors.blue,
            useMaterial3: true,
            fontFamily: 'Cairo',
          ),
          home: const SplashScreen(),
          // home: TestScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// class TestScreen extends StatelessWidget {
//   const TestScreen();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text("data"),
//             SendRequestWidget(trip: Trip(estimatedTime: 89,distance: 4,fromCity: "خانوينس",toCity: "غزة")),
//           ],
//         ),
//       ),
//     );
//   }
// }

