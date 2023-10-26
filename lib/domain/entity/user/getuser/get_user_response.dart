import '../user.dart';

class GetUserResponse {
  User user;

  GetUserResponse({
    required this.user
  });
}

class WrappedGetUserResponse<T> {
  GetUserResponse? getUserResponse;
  T value;

  WrappedGetUserResponse({
    required this.getUserResponse,
    required this.value
  });
}