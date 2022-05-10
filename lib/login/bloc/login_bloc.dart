import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth/auth_exceptions.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/utilities/form_inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;
  LoginBloc(this._authService) : super(const LoginState()) {
    on<LoginTapped>(_loginTapped);
    on<LoginEmailChanged>(_emailChanged);
    on<LoginPasswordChanged>(_passwordChanged);
  }

  void _loginTapped(LoginTapped event, Emitter<LoginState> emit) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authService.logIn(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordException catch (e) {
      emit(LoginState(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } on Exception catch (_) {
      emit(const LoginState(
          status: FormzStatus.submissionFailure, errorMessage: "Unknown"));
    }
  }

  void _emailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _passwordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }
}
