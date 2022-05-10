part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}


class AppState extends Equatable {
  final AppStatus status;
  final AuthUser user;

  const AppState._({
    required this.status,
    this.user = AuthUser.empty,
  });

  const AppState.authenticated(AuthUser user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  
  @override
  List<Object> get props => [status, user];
}
