class RegisterResponse {
  String token;
  String tokenType;
  int expiresIn;

  RegisterResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn
  });
}