class LoginWithGoogleResponse {
  String token;
  String tokenType;
  int expiresIn;

  LoginWithGoogleResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn
  });
}