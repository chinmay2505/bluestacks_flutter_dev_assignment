part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  /// Input validation error message for username
  final String inputUsernameErrorMessage;

  /// Input validation error message for password
  final String inputPasswordErrorMessage;

  /// Input login error mesaage if input crednetials are not registered in
  /// our system
  final String error;

  /// If login is success
  final bool success;

  const LoginState({
    this.inputUsernameErrorMessage = "",
    this.inputPasswordErrorMessage = "",
    this.error = "",
    this.success = false,
  });
}

/// Initial State when user arrives on the login screen
class InitialState extends LoginState {
  const InitialState();

  @override
  List<String> get props => [];
}

/// This state is return when any fornt end input validations is failed.
/// In our case if username & password fails to meet minimum of 3 charcters
/// and maximum of 11 characters
class RequiredInputValidationFails extends LoginState {
  final String invalidUsernameMessage;
  final String invalidPasswordMessage;

  const RequiredInputValidationFails({
    this.invalidUsernameMessage = "",
    this.invalidPasswordMessage = "",
  }) : super(
          inputUsernameErrorMessage: invalidUsernameMessage,
          inputPasswordErrorMessage: invalidPasswordMessage,
        );

  @override
  List<String> get props => [invalidUsernameMessage, invalidPasswordMessage];
}

/// This state is returned after the user validation attempt is done.
/// If user is validation successfully then error will be empty
/// If user is not authorized user then the errror will be non-empty
class Login extends LoginState {
  final String error;
  final bool success;

  const Login({this.error = "", this.success = false})
      : super(error: error, success: success);

  @override
  List<String> get props => [error, success.toString()];
}
