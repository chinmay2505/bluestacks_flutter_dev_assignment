abstract class LoginRepository {
  /// To login the user in the application.
  /// In real application we use Future<LoginData> as a return type
  /// to authenticate the user but we are using bool to check whether user is
  /// valid or not as we have hardcoded login credentials
  bool isValidUser(String username, String password);
}

class LoginRepositoryImpl implements LoginRepository {
  @override
  bool isValidUser(String username, String password) {
    String _username = username.trim();
    String _password = password.trim();

    int _userIndex =
        _credentials.indexWhere((element) => element["username"] == _username);

    if (_userIndex != -1 && _credentials[_userIndex]["password"] == _password) {
      return true;
    }

    return false;
  }
}

/// Here is the hardcoded login credentials for this application
List<Map<String, String>> _credentials = [
  {"username": "9898989898", "password": "password123"},
  {"username": "9876543210", "password": "password123"},
  {"username": "9898989890", "password": "password123"},
  {"username": "9876543211", "password": "password123"}
];
