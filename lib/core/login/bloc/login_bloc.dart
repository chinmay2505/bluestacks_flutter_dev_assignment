import 'package:bluestacks_flutter_dev_assignment/application.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bluestacks_flutter_dev_assignment/core/login/repository/login_repository.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/mixins/validations.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with ValidationMixin {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(const InitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event);
    } else if (event is SubmitButtonPressed) {
      yield* _mapSubmitButtonPresedToState(event);
    }
  }

  Stream<RequiredInputValidationFails> _mapUsernameChangedToState(
      UsernameChanged event) async* {
    yield RequiredInputValidationFails(
      invalidUsernameMessage:
          isValidLoginInput(event.username) ? "" : "invalid_input_username",
      invalidPasswordMessage: state.inputPasswordErrorMessage,
    );
  }

  Stream<RequiredInputValidationFails> _mapPasswordChangedToState(
      PasswordChanged event) async* {
    yield RequiredInputValidationFails(
      invalidUsernameMessage: state.inputUsernameErrorMessage,
      invalidPasswordMessage:
          isValidLoginInput(event.password) ? "" : "invalid_input_password",
    );
  }

  Stream<LoginState> _mapSubmitButtonPresedToState(
      SubmitButtonPressed event) async* {
    String _username = event.username.trim();
    String _password = event.password.trim();

    ///Return the InitialState
    yield const InitialState();

    /// Check if username and password are empty
    if (_username.isEmpty || _password.isEmpty) {
      yield RequiredInputValidationFails(
        invalidUsernameMessage: _username.isEmpty
            ? "username_required"
            : state.inputUsernameErrorMessage,
        invalidPasswordMessage: _password.isEmpty
            ? "password_required"
            : state.inputPasswordErrorMessage,
      );

      return;
    }

    if (loginRepository.isValidUser(_username, _password)) {
      /// Store the isUserLogged in flag into the repository
      Application.storageService?.isUserLoggedIn =
          Application.isUserLoggedIn = true;

      /// Store the logInUsername into the shared_preference
      /// In real world scenario we do not store username/password in shared_preference
      /// as it is not secured and can be erasedeasily.
      Application.storageService?.loggedInUsername =
          Application.logInUsername = _username;

      yield const Login(success: true);
    } else {
      yield const Login(error: "invalid_credentials");
    }
  }
}
