// class UserNotFoundAuthException implements Exception {}

// class WrongPasswordAuthException implements Exception {}

// class WeakPasswordAuthException implements Exception {}

// class EmailAlreadyInUseAuthException implements Exception {}

// class InvalidEmailAuthException implements Exception {}

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class LogInWithEmailAndPasswordException implements Exception {
  final String message;

  const LogInWithEmailAndPasswordException(
      [this.message = "An unknown error happened."]);

  factory LogInWithEmailAndPasswordException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordException(
          'Email is invalid.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordException(
          'Email not found.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordException(
          'Wrong credentials.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordException(
          'This user account is disabled.',
        );
      case 'network-request-failed':
        return const LogInWithEmailAndPasswordException(
          'Network error.',
        );
      default:
        return const LogInWithEmailAndPasswordException();
    }
  }
}

class RegisterWithEmailAndPasswordException implements Exception {
  final String message;

  const RegisterWithEmailAndPasswordException(
      [this.message = "An unknown error happened."]);

  factory RegisterWithEmailAndPasswordException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const RegisterWithEmailAndPasswordException(
          'Email is invalid.',
        );
      case 'email-already-in-use':
        return const RegisterWithEmailAndPasswordException(
          'This email is already in use.',
        );
      case 'operation-not-allowed':
        return const RegisterWithEmailAndPasswordException(
          'This operation is not allowed..',
        );
      case 'weak-password':
        return const RegisterWithEmailAndPasswordException(
          'Password is too weak.',
        );
      case 'user-disabled':
        return const RegisterWithEmailAndPasswordException(
          'This user account is disabled.',
        );
      case 'network-request-failed':
        return const RegisterWithEmailAndPasswordException(
          'Network error.',
        );
      default:
        return const RegisterWithEmailAndPasswordException();
    }
  }
}
