import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth/auth_exceptions.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/utilities/form_inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService;
  RegisterBloc(this._authService) : super(const RegisterState()) {
    on<RegisterTapped>(_registerTapped);
    on<RegisterEmailChanged>(_registerEmailChanged);
    on<RegisterPasswordChanged>(_registerPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_registerConfirmPasswordChanged);
    on<RegisterUsernameChanged>(_registerUsernameChanged);
    
  }

  void _registerTapped(
      RegisterTapped event, Emitter<RegisterState> emit) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authService.register(
        email: state.email.value,
        password: state.password.value,
        username: state.username.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on RegisterWithEmailAndPasswordException catch (e) {
      emit(RegisterState(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } on Exception catch (_) {
      emit(const RegisterState(
          status: FormzStatus.submissionFailure,
          errorMessage: "An unknown error has occurred."));
    }
  }

  void _registerEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void _registerPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    final password = Password.dirty(event.password);
    final confirmedPassword = ConfirmedPassword.dirty(
        password: event.password, value: state.confirmedPassword.value);
    emit(state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ])));
  }

  void _registerConfirmPasswordChanged(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: event.password,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  void _registerUsernameChanged(
      RegisterUsernameChanged event, Emitter<RegisterState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }
}
