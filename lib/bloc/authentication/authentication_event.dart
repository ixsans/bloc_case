import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String token;

  AuthenticationLoggedIn(this.token);

  @override
  List<Object> get props => [token];
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
