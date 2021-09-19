import 'package:bluestacks_flutter_dev_assignment/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bluestacks_flutter_dev_assignment/config/themes/bloc/bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/services/app_localization.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/theme_config.dart';
import 'package:bluestacks_flutter_dev_assignment/core/login/bloc/login_bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/core/login/repository/login_repository.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/ui_utils.dart';
import 'package:bluestacks_flutter_dev_assignment/widgets/app_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SetAppScreenConfiguration.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>.value(
          value: BlocProvider.of<ThemeBloc>(context),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(loginRepository: LoginRepositoryImpl()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSpacing.m),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.s),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Logo(),
                          const Divider(),
                          const AppSizedBoxSpacing(),
                          Login(themeState: themeState),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Stateless class to display the Game.tv logo
class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 160,
        child: Image.asset("assets/images/gametv_logo.png"),
      ),
    );
  }
}

/// Stateful widget for login form
class Login extends StatefulWidget {
  final ThemeState themeState;
  const Login({Key? key, required this.themeState}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameTextController.text = _passwordTextController.text = "";
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _handleLoginListner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInputLabelText(
            themeState: widget.themeState,
            labelText:
                "${AppLocalizations.of(context)!.translate('input_lable_username')}:",
          ),
          _displayUsernameTextField(widget.themeState),
          const AppSizedBoxSpacing(),
          AppInputLabelText(
            themeState: widget.themeState,
            labelText:
                "${AppLocalizations.of(context)!.translate('input_lable_password')}:",
          ),
          _displayPasswordTextField(widget.themeState),
          const AppSizedBoxSpacing(),
          _displayLoginButton(widget.themeState),
          const AppSizedBoxSpacing(heightSpacing: AppSpacing.m),
        ],
      ),
    );
  }

  Widget _displayUsernameTextField(ThemeState themeState) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previousState, currentState) =>
          previousState.inputUsernameErrorMessage !=
          currentState.inputUsernameErrorMessage,
      builder: (context, state) {
        return AppInputForm(
          themeState: themeState,
          placeholderText:
              AppLocalizations.of(context)!.translate('placeholder_username')!,
          controller: _usernameTextController,
          textInputType: TextInputType.emailAddress,
          errorText: AppLocalizations.of(context)!
              .translate('${state.inputUsernameErrorMessage}'),
          icon: Icons.person_outline,
          onChanged: (username) => BlocProvider.of<LoginBloc>(context)
              .add(UsernameChanged(username: username)),
        );
      },
    );
  }

  Widget _displayPasswordTextField(ThemeState themeState) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previousState, currentState) =>
          previousState.inputPasswordErrorMessage !=
          currentState.inputPasswordErrorMessage,
      builder: (context, state) {
        return AppInputForm(
          themeState: themeState,
          placeholderText:
              AppLocalizations.of(context)!.translate('placeholder_password')!,
          controller: _passwordTextController,
          obscureText: true,
          errorText: AppLocalizations.of(context)!
              .translate('${state.inputPasswordErrorMessage}'),
          icon: Icons.lock_open,
          onChanged: (password) => BlocProvider.of<LoginBloc>(context)
              .add(PasswordChanged(password: password)),
        );
      },
    );
  }

  Widget _displayLoginButton(ThemeState themeState) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Center(
          child: Opacity(
            opacity: state.inputUsernameErrorMessage.isEmpty &&
                    state.inputPasswordErrorMessage.isEmpty
                ? 1.0
                : 0.1,
            child: AppElevatedButton(
              themeState: themeState,
              message: AppLocalizations.of(context)!.translate('login')!,
              onPressed: state.inputUsernameErrorMessage.isEmpty &&
                      state.inputPasswordErrorMessage.isEmpty
                  ? () {
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<LoginBloc>(context).add(
                          SubmitButtonPressed(
                              username: _usernameTextController.text,
                              password: _passwordTextController.text));
                    }
                  : null,
            ),
          ),
        );
      },
    );
  }

  void _handleLoginListner(BuildContext context, LoginState loginState) {
    if (loginState.error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "${AppLocalizations.of(context)!.translate('invalid_credentials')}"),
          duration: const Duration(milliseconds: 3000),
        ),
      );
    } else if (loginState.success) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    }
  }
}
