part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginTapped extends LoginEvent {
  const LoginTapped();
}

class LoginEmailChanged extends LoginEvent {
  final String email;
  const LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged({required this.password});
}
