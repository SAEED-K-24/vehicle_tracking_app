import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/models/user.dart';
import 'package:vehicle_tracking/reuseable/functions.dart';
import 'package:vehicle_tracking/screens/screens.dart';
import 'package:vehicle_tracking/widgets/custom_text_form_field_widget.dart';
import 'package:vehicle_tracking/widgets/logo_widget.dart';
import '../blocs/blocs.dart';
import '../constant.dart';


class RegisterPage extends StatefulWidget {
  final UserRole userRole;
  String? code;
  String? managerId;
  List<String>? vehicleIds;
  final DateTime? subscriptionEndDate;
  final bool? isSubscribed;
  RegisterPage({super.key,required this.userRole,this.code,this.managerId,this.vehicleIds,this.subscriptionEndDate,this.isSubscribed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController ;

  late TextEditingController _nameController ;

  late TextEditingController _passwordController ;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text('إنشاء حساب جديد',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthLoading){
            FocusScope.of(context).unfocus();
            onHorizontalLoading(
                context, "الرجاء الإنتظار", Colors.blue, false);
          }
          if (state is AuthAuthenticatedManager) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ManagerLayoutScreen(user: state.user,drivers: [],),));
          } else if (state is AuthAuthenticatedDriver) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DriverLayoutScreen(user: state.user),));
          } else if (state is AuthError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LogoWidget(),
                  CustomTextFormFieldWidget(label: "الاسم",controller: _nameController,validateMsg: "يرجى إدخال الاسم",),
                  SizedBox(
                    height: 12.h,
                  ),
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
                        final name = _nameController.text;
                        final password = _passwordController.text;
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthRegisterRequested(
                              email: email, password: password, userRole: widget.userRole, name: name,managerId: widget.managerId,
                              code: widget.code,vehicleIds: widget.vehicleIds,subscriptionEndDate: widget.subscriptionEndDate,
                              isSubscribed:widget.isSubscribed),
                        );
                      }
                    },
                    child: Text('تسجيل',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14.sp)),
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
