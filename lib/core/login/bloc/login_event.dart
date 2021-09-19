part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  /// Passing class fields in a list to the Equatable super class
  const LoginEvent([List props = const []]) : super();
}

/// Event when username is changed
class UsernameChanged extends LoginEvent {
  final String username;

  const UsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

/// Event when password is changed
class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

/// Event to login the user when they click on submit button
class SubmitButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const SubmitButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
