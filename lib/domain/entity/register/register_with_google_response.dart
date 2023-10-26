class RegisterWithGoogleResponse {
  String token;
  String tokenType;
  int expiresIn;

  RegisterWithGoogleResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn
  });
}