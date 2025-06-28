import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper {
  static late SharedPreferences _preferences;
  static init() async {
    _preferences =await SharedPreferences.getInstance();
  }



  static String? getEmail() {
    String? email =  _preferences.getString('email');
    return email;
  }

  static Future<void> saveEmail(String? email)async{
    await _preferences.setString('email', email ?? '');
  }

  static String? getPassword(){
    // استرجاع كلمة المرور
    String? password =  _preferences.getString('password');
    return password;
  }

  static Future<void> savePassword(String? password)async{
  // حفظ كلمة المرور
  await _preferences.setString('password',password??'');
  }



}
