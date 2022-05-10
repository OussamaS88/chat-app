import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/auth/auth_exceptions.dart';
import 'package:chat_app/services/auth/auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth_provider.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) return AuthUser.fromFirebase(user);
    return null;
  }

  @override
  Stream<AuthUser> get user {
    return FirebaseAuth.instance.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null
          ? AuthUser.empty
          : AuthUser.fromFirebase(firebaseUser);
      return user;
    });
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) {
        throw UserNotLoggedInAuthException();
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordException.fromCode(e.code);
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    FirebaseAuth.instance.currentUser != null
        ? await FirebaseAuth.instance.signOut()
        : throw UserNotLoggedInAuthException();
  }

  @override
  Future<AuthUser> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) {
        throw UserNotLoggedInAuthException();
      }
      await addUserToDB(user: user, username: username);
      return user;
    } on FirebaseAuthException catch (e) {
      throw RegisterWithEmailAndPasswordException.fromCode(e.code);
    } catch (e) {
      throw GenericAuthException();
    }
  }
}

Future<void> addUserToDB(
    {required AuthUser user, required String username}) async {
  final usersRef = FirebaseFirestore.instance.collection('user');
  await usersRef.doc(user.id).set({'username': username});
}
