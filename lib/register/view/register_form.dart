import 'package:chat_app/utilities/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../register.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
          //   );
          showErrorDialog(context,
                state.errorMessage ?? "An unknown error has occurred.");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _UsernameInput(),
              const _EmailInput(),
              const _PasswordInput(),
              const _ConfirmPasswordInput(),
              _RegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (username) => context
              .read<RegisterBloc>()
              .add(RegisterUsernameChanged(username: username)),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Username...',
            helperText: '',
            errorText: state.username.invalid ? 'Invalid username.' : null,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context
              .read<RegisterBloc>()
              .add(RegisterEmailChanged(email: email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email address...',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid email.' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password: password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password...',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password.' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          onChanged: (confirmPassword) => context
              .read<RegisterBloc>()
              .add(RegisterConfirmPasswordChanged(password: confirmPassword)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm password...',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'Passwords don\'t match.'
                : null,
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () =>
                        context.read<RegisterBloc>().add(const RegisterTapped())
                    : null,
                child: const Text('REGISTER'),
              );
      },
    );
  }
}
