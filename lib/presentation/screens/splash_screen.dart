import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:vehicle_tracking/core/helper/save_sign_in_helper.dart';
import 'package:vehicle_tracking/presentation/screens/screens.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isSaveSignIn = false;
  String? email;
  String? password;
  @override
  void initState() {
    super.initState();
    _checkSignInSave();
  }

  _checkSignInSave(){
     email =  CacheHelper.getEmail();
     password =  CacheHelper.getPassword();
    if(email == null || password == null|| email == '' || password == '') {
      _isSaveSignIn = false;
    }
    else{
     _isSaveSignIn = true;
      }
    }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SplashScreenView(
          navigateRoute:_isSaveSignIn ? LoginPage(email:email ,password: password,): ChooseSignScreen(),
          duration: 5000,
          imageSize: 250,
          imageSrc: "assets/images/vehicle_tracking_logo.png",
          text: "طريقك نحو خدمة مميزة",
          textType: TextType.TyperAnimatedText,
          textStyle: GoogleFonts.roboto(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            // leadingDistribution: TextLeadingDistribution.proportional,
            letterSpacing: 3.8,
            decorationThickness: 2.3,
            wordSpacing: 3,
            color: Color(0xffd19712),
            decoration: TextDecoration.none,
          ),
          backgroundColor: Colors.white,
        ),
      // ),
    );
  }
}
