import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../register.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(context.read<AuthService>()),
          child: const RegisterForm(),
        ),
    );
  }
}