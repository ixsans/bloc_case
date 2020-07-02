import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final String token;

  LoginSuccessState(this.token);

  @override
  List<Object> get props => [token];
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}
