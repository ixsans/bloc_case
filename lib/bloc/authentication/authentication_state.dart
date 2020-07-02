import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationStateInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccessState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailureState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
