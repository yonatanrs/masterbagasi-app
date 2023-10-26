class LoginResponse {
  String token;
  String tokenType;
  int expiresIn;

  LoginResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn
  });
}