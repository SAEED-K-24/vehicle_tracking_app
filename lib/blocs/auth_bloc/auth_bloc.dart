import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:vehicle_tracking/blocs/blocs.dart';
import 'package:vehicle_tracking/helper/save_sign_in_helper.dart';
import '../../exceptions/fireauth_exceptions.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';
part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FireAuthHelper authHelper;
  late UserRepository userRepository;
  AuthBloc({required this.authHelper}) : super(AuthInitial()) {
    userRepository = UserRepository(firestore: FirebaseFirestore.instance);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthEnterCodeRequest>(_onCodeRequest);
    on<AuthChangePasswordRequested>(_onChangePasswordRequest);
    on<AuthDeleteAccountRequested>(_onDeleteAccountRequest);
    on<AuthDeleteDriverRequested>(_onDeleteDriverRequest);
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    // إرسال حالة التحميل أثناء تسجيل الدخول
    emit(AuthLoading());
    try {
      // تسجيل الدخول باستخدام مساعد مصادقة النار
      final userId = await authHelper.login(event.email, event.password);
      if (userId != null) {
        // الحصول على نوع المستخدم بناءً على معرف المستخدم
        final user = await userRepository.getUserById(userId);
        if(user == null){
          await authHelper.deleteUserFromAuth();
          emit(AuthAccountNotFound());
          return;
        }
        if (user.role == UserRole.manager) {

          List<User> drivers=[];

          if(user.driverIds != null && user.driverIds!.isNotEmpty) {
          for(String driverId in user.driverIds!){
            User? driver = await userRepository.getUserById(driverId);
            if(driver != null) {
              drivers.add(driver);
            }
          }
          }
          await CacheHelper.saveEmail(event.email);
          await CacheHelper.savePassword(event.password);
          // إرسال حالة المدير المصادق عليه
          emit(AuthAuthenticatedManager(user,drivers));
        } else if (user.role == UserRole.driver) {
          // إرسال حالة السائق المصادق عليه
          User? manager = await userRepository.getUserById(user.managerId!);
          if(manager == null){
            await authHelper.deleteUserFromAuth();
            emit(AuthAccountNotFound());
            return;
          }
          await CacheHelper.saveEmail(event.email);
          await CacheHelper.savePassword(event.password);
          emit(AuthAuthenticatedDriver(user));
        } else {
          // إرسال حالة خطأ إذا كان نوع المستخدم غير معروف
          emit(AuthError('نوع المستخدم غير معروف'));
        }
      } else {
        // إرسال حالة خطأ في حالة فشل تسجيل الدخول
        emit(AuthError('فشل في تسجيل الدخول'));
      }
    }on LoginWrongPasswordException catch(e){
      emit(AuthError("كلمة المرور غير صحيحة"));
    }on LoginUserNotFoundException catch(e){
      emit(AuthError("الإيميل غير موجود"));
    } catch (e) {
      // إرسال حالة خطأ في حالة وجود أي استثناء
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    // إرسال حالة التحميل أثناء عملية التسجيل
    emit(AuthLoading());
    try {
      // تسجيل المستخدم الجديد باستخدام مساعد مصادقة النار
      final userId = await authHelper.register(event.email, event.password);
      if (userId != null) {
        User user = User(id: userId, name: event.name, email: event.email, role: event.userRole,vehicleId: event.code,
            managerId: event.managerId,vehicleIds: event.vehicleIds,isSubscribed: event.isSubscribed,subscriptionEndDate: event.subscriptionEndDate);
        await userRepository.addUser(user);

        if (event.userRole == UserRole.manager) {
          // إرسال حالة المدير المصادق عليه
          await CacheHelper.saveEmail(event.email);
          await CacheHelper.savePassword(event.password);
          emit(AuthAuthenticatedManager(user,[]));
        } else if (event.userRole == UserRole.driver) {
          // اضافة موديل خاص بخصاية الاخفاء
          HideModeRepository hideModeRepository = HideModeRepository();
          HideModeModel hideModeModel = HideModeModel(id: event.code,managerId: event.managerId,driverId: userId,isHide: false);
          await hideModeRepository.addHideModeModel(hideModeModel);
          // اضافة ال id الخاص بالسائق الى المدير
          User? _manager = await userRepository.getUserById(event.managerId!);
          List<String> _driverIds = _manager?.driverIds ?? [];
          _driverIds.add(userId);
          User newManager = _manager!.copyWith(driverIds: _driverIds);
          await userRepository.updateUser(newManager);
          await CacheHelper.saveEmail(event.email);
          await CacheHelper.savePassword(event.password);
          // إرسال حالة السائق المصادق عليه
          emit(AuthAuthenticatedDriver(user));
        } else {
          // إرسال حالة خطأ إذا كان نوع المستخدم غير معروف
          emit(AuthError('غير معروف نوع المستخدم'));
        }
      } else {
        // إرسال حالة خطأ في حالة فشل التسجيل
        emit(AuthError('فشل التسجيل'));
      }
    }on RegisterWeakPasswordException catch(e){
    emit(AuthError("كلمة المرور ضعيفة"));
    }on RegisterEmailAlreadyInUseException catch(e) {
      emit(AuthError("الإيميل تم استخدامه مسبقاً"));
    }catch (e) {
      // إرسال حالة خطأ في حالة وجود أي استثناء
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    // إرسال حالة التحميل أثناء تسجيل الخروج
    emit(AuthLoading());
    try {
      // تسجيل الخروج باستخدام مساعد مصادقة النار
      await authHelper.logOut();
      // إرسال حالة الغير مصادق عليه بعد تسجيل الخروج
      await CacheHelper.saveEmail(null);
      await CacheHelper.savePassword(null);
      emit(AuthUnauthenticated());
    } catch (e) {
      // إرسال حالة خطأ في حالة وجود أي استثناء
      emit(AuthError(e.toString()));
    }
  }

  _onChangePasswordRequest(AuthChangePasswordRequested event,Emitter<AuthState> emit)async{
        emit(AuthLoading());
        try{
        await authHelper.changePassword(event.oldPassword, event.newPassword);
        await CacheHelper.savePassword(event.newPassword);
        emit(AuthChangePasswordSuccess());
        }catch(e){
        emit(AuthError(e.toString()));
        }
  }

  Future<void> _onCodeRequest(AuthEnterCodeRequest event,Emitter<AuthState> emit)async {
    emit(AuthEnterCodeLoading());
    try {
      List<User>? users = await userRepository.getUsersByRole("manager");
      if (users == null || users.isEmpty) {
        emit(AuthUnValidCodeState("لا يوجد مستخدمين"));
      } else {
        User? manager;

        for(User user in users){
          for(String id in user.vehicleIds!){
            if (id == event.code) {
              manager = user;
              if(manager.driverIds != null && manager.driverIds!.isNotEmpty){
                for(String driverId in manager.driverIds!){
                  User? driver = await userRepository.getUserById(driverId);
                  if(driver?.vehicleId == event.code){
                    emit(AuthUnValidCodeState("الكود مستخدم من قبل"));
                    return;
                  }
                }
              }
            }
          }
        }

        if (manager == null) {
          emit(AuthUnValidCodeState("الكود غير صالح"));
        } else {
          emit(AuthValidCodeState(code: event.code, managerId: manager!.id));
        }
      }
    } catch (e) {
      emit(AuthUnValidCodeState(e.toString()));
    }
  }

  Future<void> _onDeleteAccountRequest(AuthDeleteAccountRequested event,Emitter<AuthState> emit)async{
    emit(AuthLoading());
    try{
      if(event.user.role == UserRole.manager){
        await authHelper.deleteUser();
      }else{
      User? manager = await userRepository.getUserById(event.user.managerId!);
      List<String> driverIds = [];
      for(String driverId in  manager!.driverIds!) {
        if (driverId != event.user.id) {
          driverIds.add(driverId);
        }
      }
      User newManager = manager!.copyWith(driverIds: driverIds);
      await userRepository.updateUser(newManager);
      HideModeRepository hideModeRepository = HideModeRepository();
      await hideModeRepository.deleteHideModeModel(event.user.vehicleId!);
      await authHelper.deleteUser();
      }
      await CacheHelper.saveEmail(null);
      await CacheHelper.savePassword(null);
      emit(AuthAccountDeleted());
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onDeleteDriverRequest(AuthDeleteDriverRequested event,Emitter<AuthState> emit)async{
    emit(DeleteDriverLoading());
    try{
      await userRepository.deleteUser(event.driver.id);
      HideModeRepository hideModeRepository = HideModeRepository();
      await hideModeRepository.deleteHideModeModel(event.driver.vehicleId!);
      List<String> driverIds = [];
      for(String driverId in  event.manager!.driverIds!) {
        if (driverId != event.driver.id) {
          driverIds.add(driverId);
        }
      }
      User newManager = event.manager!.copyWith(driverIds: driverIds);
      await userRepository.updateUser(newManager);
      emit(DeleteDriverSuccess(driver: event.driver));
    }catch(e){
      emit(DeleteDriverError());
    }
}




}
