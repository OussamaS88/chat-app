part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterTapped extends RegisterEvent {
  const RegisterTapped();
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged({required this.password});
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterConfirmPasswordChanged({required this.password});
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  const RegisterUsernameChanged({required this.username});
}