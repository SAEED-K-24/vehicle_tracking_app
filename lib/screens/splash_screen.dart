import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:vehicle_tracking/helper/save_sign_in_helper.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/repositories/repositories.dart';
import 'package:vehicle_tracking/screens/choose_sign_screen.dart';
import 'package:vehicle_tracking/screens/login_screen.dart';


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
    // TODO: implement initState
    super.initState();
    _checkSignInSave();
  }

  _checkSignInSave(){
     email =  CacheHelper.getEmail();
     password =  CacheHelper.getPassword();
    if(email == null || password == null){
    _isSaveSignIn = false;
    }else if(email == '' || password == ''){
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
          // navigateRoute: const LanguageScreen(),
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
