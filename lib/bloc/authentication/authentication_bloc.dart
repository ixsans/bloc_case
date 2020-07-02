import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloccase/repository/repository.dart';
import 'package:flutter/foundation.dart';
import '../bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository});

  @override
  AuthenticationState get initialState => AuthenticationStateInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      bool hasLoggedIn = await userRepository.hasToken();
      if (hasLoggedIn) {
        yield AuthenticationSuccessState();
      } else {
        yield AuthenticationFailureState();
      }
    } else if (event is AuthenticationLoggedIn) {
      yield AuthenticationLoadingState();
      await userRepository.persistToken(event.token);
      yield AuthenticationSuccessState();
    } else if (event is AuthenticationLoggedOut) {
      yield AuthenticationLoadingState();
      await userRepository.deleteToken();
      yield AuthenticationFailureState();
    }
  }
}
