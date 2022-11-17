class UserSession {
  late String token;
  static UserSession? instance;

  UserSession._();

  static UserSession get userSession => instance ??= UserSession._();

  void  setUserSession(String token){
    this.token = token;
  }

  String get getUserSession{
    return token;
  }
}