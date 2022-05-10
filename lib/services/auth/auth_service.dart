import 'package:chat_app/services/auth/auth_provider.dart';
import 'package:chat_app/services/auth/auth_user.dart';
import 'package:chat_app/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  factory AuthService.fromFirebase() {
    final firebaseAuthProvider = FirebaseAuthProvider();
    return AuthService(firebaseAuthProvider);
  }

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
    required String username,
  }) =>
      provider.register(
        email: email,
        password: password,
        username: username,
      );

  @override
  Stream<AuthUser> get user => provider.user;
}
