part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthEnterCodeLoading extends AuthState {}

class AuthAuthenticatedManager extends AuthState {
  final User user;
  final List<User> drivers;

  const AuthAuthenticatedManager(this.user,this.drivers);

  @override
  List<Object> get props => [user,drivers];
}

class AuthAuthenticatedDriver extends AuthState {
  final User user;

  const AuthAuthenticatedDriver(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthValidCodeState extends AuthState{
  final String code;
  final String managerId;

  const AuthValidCodeState({required this.code,required this.managerId});

  @override
  List<Object> get props => [code,managerId];
}
class AuthUnValidCodeState extends AuthState{
  final String message;
  const AuthUnValidCodeState(this.message);

  @override
  List<Object> get props => [message];
}

class AuthChangePasswordSuccess extends AuthState{}

class  AuthAccountDeleted extends AuthState{}

class  AuthAccountNotFound extends AuthState{}


class DeleteDriverLoading extends AuthState{}

class DeleteDriverSuccess extends AuthState{
  final User driver;
  const DeleteDriverSuccess({required this.driver});

  @override
  List<Object> get props => [driver];
}
class DeleteDriverError extends AuthState{}
