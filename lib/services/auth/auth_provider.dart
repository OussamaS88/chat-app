import 'package:chat_app/services/auth/auth_user.dart';

abstract class AuthProvider {
  Stream<AuthUser> get user;

  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String email,
    required String password,
    required String username,
  });

  Future<void> logOut();
}
