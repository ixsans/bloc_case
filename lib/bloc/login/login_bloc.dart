import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloccase/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import '../bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc});

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      try {
        String token = await userRepository.login(
            email: event.email, password: event.password);
        yield LoginSuccessState(token);
        authenticationBloc.add(AuthenticationLoggedIn(token));
      } catch (e) {
        yield LoginFailureState(e.toString());
      }
    }
  }
}
