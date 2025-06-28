import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_tracking/presentation/screens/screens.dart';
import '../blocs/blocs.dart';
import 'package:vehicle_tracking/data/models/models.dart';


class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي'),
      ),
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context, state) {

          if(state is AuthUnauthenticated || state is AuthAccountDeleted){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ChooseSignScreen(),), (route) => false);
          }

          // if(state is AuthLoading){
          //   FocusScope.of(context).unfocus();
          //   onHorizontalLoading(context, "الرجاء الإنتظار", Colors.blue, false);
          // }

          },
        builder: (context,state) {
          if(state is AuthLoading){
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'اسم المستخدم:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user.name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  title: Text(
                    'البريد الإلكتروني:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                if(user.subscriptionEndDate != null)ListTile(
                  title: Text(
                    'نهاية الاشتراك:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat("dd : MM : yyyy").format(user.subscriptionEndDate!),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 40),
                Divider(thickness: 2),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // افتح شاشة تغيير كلمة المرور
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordScreen(),),);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                        ),
                        child: Text('تغيير كلمة المرور',style: TextStyle(color: Colors.white,),),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            // عرض مربع حوار لتأكيد حذف الحساب
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('تأكيد حذف الحساب'),
                                  content: Text('هل أنت متأكد أنك تريد حذف حسابك نهائياً؟ سيتم فقدان جميع البيانات المرتبطة بهذا الحساب.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // إغلاق مربع الحوار
                                      },
                                      child: Text('إلغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // تنفيذ عملية حذف الحساب
                                        Navigator.of(context).pop();
                                        context.read<AuthBloc>().add(AuthDeleteAccountRequested(user: user));
                                      },
                                      child: Text('حذف الحساب'),
                                    ),
                                  ],
                                );
                              },
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                        ),
                        child: Text('حذف الحساب',style: TextStyle(color: Colors.white),),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // عرض مربع حوار لتأكيد تسجيل الخروج
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('تأكيد تسجيل الخروج'),
                                content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // إغلاق مربع الحوار
                                    },
                                    child: Text('إلغاء'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // تنفيذ عملية تسجيل الخروج
                                      BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
                                    },
                                    child: Text('تسجيل الخروج'),
                                  ),
                                ],
                              );
                            },
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                        ),
                        child: Text('تسجيل الخروج',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
