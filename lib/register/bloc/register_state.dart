part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Username username;
  final FormzStatus status;
  final String? errorMessage;

  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Username? username,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      username: username ?? this.username,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [email, password, confirmedPassword, username, status];
}
