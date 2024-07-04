import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/screens/screens.dart';
import 'package:vehicle_tracking/widgets/logo_widget.dart';
import 'package:vehicle_tracking/widgets/widgets.dart';
import '../blocs/blocs.dart';
import '../reuseable/functions.dart';

class LoginPage extends StatefulWidget {

  String? email;
  String? password;
  // UserRole userRole;
  LoginPage({super.key,this.email,this.password});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController ;

  late TextEditingController _passwordController ;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.email != null && widget.password != null){
      _loginAuto();
    }

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  _loginAuto(){
    BlocProvider.of<AuthBloc>(context).add(AuthLoginRequested(email: widget.email!, password: widget.password!));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'تسجيل الدخول',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseSignScreen(),));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),

      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthLoading){
            FocusScope.of(context).unfocus();
            onHorizontalLoading(
                context, "الرجاء الإنتظار", Colors.blue, false);
          }else if (state is AuthAuthenticatedManager) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ManagerLayoutScreen(user: state.user,drivers: state.drivers),
            ),);
          } else if (state is AuthAuthenticatedDriver) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DriverLayoutScreen(user: state.user),
            ),);
          }else if(state is AuthAccountNotFound){
            Fluttertoast.showToast(
                msg: "الحساب تم حدف");
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ChooseSignScreen(),),(route) => false,);
          }else if (state is AuthError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LogoWidget(),
                  CustomTextFormFieldWidget(label: "الإيميل",controller: _emailController,validateMsg: "يرجى إدخال الإيميل",),
                  SizedBox(
                    height: 12.h,
                  ),
                 CustomTextFormFieldWidget(label: "كلمة المرور",validateMsg: "يرجى إدخال كلمة المرور",controller: _passwordController,obscureText: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthLoginRequested(email: email, password: password,),
                        );
                      }
                    },
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
