import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser extends Equatable {
  final String id;

  const AuthUser({required this.id});

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
      );

  static const empty = AuthUser(id: '');

  bool get isEmpty => this == AuthUser.empty;

  @override
  List<Object?> get props => [id];
}
