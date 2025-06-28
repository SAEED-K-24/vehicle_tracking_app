part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password,});

  @override
  List<Object> get props => [email, password];
}

class AuthChangePasswordRequested extends AuthEvent {
  final String oldPassword;
  final String newPassword;

  const AuthChangePasswordRequested({required this.oldPassword, required this.newPassword,});

  @override
  List<Object> get props => [oldPassword,newPassword];
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String name;
  final UserRole userRole;
  final String password;
  final String? code;
  final String? managerId;
  final List<String>? vehicleIds;
  final bool? isSubscribed;
  final DateTime? subscriptionEndDate;

  const AuthRegisterRequested({required this.email,required this.name,required this.userRole,
    required this.password,this.code,this.managerId,this.vehicleIds,this.isSubscribed,this.subscriptionEndDate});

  @override
  List<Object> get props => [email, name,userRole,password,code??"",managerId??"",vehicleIds??[]];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthEnterCodeRequest extends AuthEvent{
  final String code;

  const AuthEnterCodeRequest({required this.code});
  @override
  List<Object> get props => [code];
}

class AuthDeleteAccountRequested extends AuthEvent{
  final User user;

  const AuthDeleteAccountRequested({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthDeleteDriverRequested extends AuthEvent{
  final User driver;
  final User manager;
  const AuthDeleteDriverRequested({required this.driver,required this.manager});

  @override
  List<Object> get props => [driver];
}