import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracking/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehicle_tracking/main.dart';
import 'package:vehicle_tracking/models/models.dart';
import 'package:vehicle_tracking/reuseable/functions.dart';
import 'package:vehicle_tracking/screens/driver_layout_screen.dart';
import 'package:vehicle_tracking/screens/login_screen.dart';
import 'package:vehicle_tracking/screens/screens.dart';
import 'package:vehicle_tracking/widgets/custom_button.dart';
import 'package:vehicle_tracking/widgets/logo_widget.dart';
import 'package:vehicle_tracking/constant.dart';
import 'package:vehicle_tracking/widgets/widgets.dart';

class EnterDriverCode extends StatefulWidget {
  EnterDriverCode({super.key});

  @override
  State<EnterDriverCode> createState() => _EnterDriverCodeState();
}

class _EnterDriverCodeState extends State<EnterDriverCode> {
  late TextEditingController _controller ;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final TextEditingController _controller  =TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseSignScreen(),));
        }, icon: Icon(Icons.arrow_back),),
      ),
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context, state) {
        if(state is AuthEnterCodeLoading){
          FocusScope.of(context).unfocus();
          onHorizontalLoading(
              context, "الرجاء الإنتظار", Colors.blue, false);
        }
        if(state is AuthUnValidCodeState){
          Navigator.of(context).pop();
          showMyDialog(context: context,title: "خطأ في الكود",description: "حدث خطأ أثناء فحص الكود",message: state.message);
        }
        if(state is AuthValidCodeState){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>RegisterPage(userRole: UserRole.driver,code: state.code,managerId: state.managerId,)),);
        }
        },
        builder: (context,state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogoWidget(),
                SizedBox(height: 32.h,),
                Text("أدخل الكود الخاص بالسائق",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),),
                SizedBox(height: 16.h,),
                CustomTextFormFieldWidget(label: "ادخل الكود هنا",controller: _controller,validateMsg: "يجب إدخال الكود",),
                SizedBox(height: 20.h,),
                CustomButtonWidget(title: "تسجيل الكود",onTap: () {
                  if(_controller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يجب إدخال الكود")));
                    return;
                  }
                  context.read<AuthBloc>().add(AuthEnterCodeRequest(code: _controller.text));
                },),
              ],
            ),
          );
        }
      ),
    );
  }
}
