import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehicle_tracking/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehicle_tracking/core/reuseable/functions.dart';

class ChangePasswordScreen extends StatefulWidget {

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthState>(
      listener: (context, state) {
        log("state $state");
        if(state is AuthError){
          Navigator.pop(context);
          showMyDialog(context: context,title: "حدث خطأ",message: "فشل إعادة تعيين كلمة المرور",description: state.toString());
        }

        if(state is AuthChangePasswordSuccess){
          Navigator.of(context).pop();
          // Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "تم تغيير كلمة المرور بنجاح");
        }

      },
      builder: (context,state) {
        if(state is AuthLoading){
        return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('تغيير كلمة المرور'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: currentPasswordController,
                  decoration: InputDecoration(labelText: 'كلمة المرور الحالية'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: newPasswordController,
                  decoration: InputDecoration(labelText: 'كلمة المرور الجديدة'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration:
                  InputDecoration(labelText: 'تأكيد كلمة المرور الجديدة'),
                  obscureText: true,
                ),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(currentPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty || newPasswordController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("أحد الحقول فارغة")));
                        return;
                      }
                      // التحقق من تطابق كلمة المرور الجديدة مع تأكيد كلمة المرور
                      if (newPasswordController.text !=
                          confirmPasswordController.text) {
                        showMyDialog(context: context,title: "لديك خطأ",message: "كلمات المرور غير متطابقة",description: "يجب أن تتطابق كلمة المرور الجديدة مع تأكيد كلمة المرور");
                        return;
                      }

                      if (newPasswordController.text ==
                          currentPasswordController.text) {
                        showMyDialog(context: context,title: "لديك خطأ",message: "كلمات المرور لم تتغير",description: "يجب أن تختلف كلمة المرور الجديدة مع كلمة المرور القديمة");
                        return;
                      }

                      context.read<AuthBloc>().add(AuthChangePasswordRequested(oldPassword: currentPasswordController.text, newPassword: newPasswordController.text));

                    },
                    child: Text('حفظ التغييرات'),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
