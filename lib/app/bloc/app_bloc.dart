import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth/auth_user.dart';
import 'package:chat_app/utilities/cache.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthService _authService;
  final CacheClient _cacheClient;
  late final StreamSubscription<AuthUser> _userSubscription;
  AppBloc({
    required AuthService authService,
    required CacheClient cacheClient,
  })  : _authService = authService,
        _cacheClient = cacheClient,
        super(authService.currentUser != null
            ? AppState.authenticated(authService.currentUser!)
            : const AppState.unauthenticated()) {
    on<AppLogoutRequested>(_appLogOutRequested);
    on<AppUserChanged>(_appUserChanged);
    _userSubscription = _authService.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  void _appLogOutRequested(
      AppLogoutRequested event, Emitter<AppState> emit) async {
    await _authService.logOut();
  }

  void _appUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    if (event.user.isEmpty) {
      _cacheClient.write(key: 'cache_user_id', value: AuthUser.empty);
      emit(const AppState.unauthenticated());
    } else {
      _cacheClient.write(key: 'cache_user_id', value: event.user);
      emit(AppState.authenticated(event.user));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
