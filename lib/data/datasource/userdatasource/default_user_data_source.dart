import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/user_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../../domain/entity/login/login_parameter.dart';
import '../../../domain/entity/login/login_response.dart';
import '../../../domain/entity/login/login_with_google_parameter.dart';
import '../../../domain/entity/login/login_with_google_response.dart';
import '../../../domain/entity/logout/logout_parameter.dart';
import '../../../domain/entity/logout/logout_response.dart';
import '../../../domain/entity/register/register_parameter.dart';
import '../../../domain/entity/register/register_response.dart';
import '../../../domain/entity/register/register_with_google_parameter.dart';
import '../../../domain/entity/register/register_with_google_response.dart';
import '../../../domain/entity/user/getuser/get_user_parameter.dart';
import '../../../domain/entity/user/getuser/get_user_response.dart';
import '../../../misc/option_builder.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'user_data_source.dart';

class DefaultUserDataSource implements UserDataSource {
  final Dio dio;

  const DefaultUserDataSource({
    required this.dio
  });

  @override
  FutureProcessing<LoginResponse> login(LoginParameter loginParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "email": loginParameter.email,
        "password": loginParameter.password
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/auth/login", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<LoginResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToLoginResponse());
    });
  }

  @override
  FutureProcessing<LoginWithGoogleResponse> loginWithGoogle(LoginWithGoogleParameter loginWithGoogleParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "id_token": loginWithGoogleParameter.idToken,
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/auth/google", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<LoginWithGoogleResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToLoginWithGoogleResponse());
    });
  }

  @override
  FutureProcessing<RegisterResponse> register(RegisterParameter registerParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "name": registerParameter.name,
        "email": registerParameter.email,
        "password": registerParameter.password,
        "password_confirmation": registerParameter.passwordConfirmation
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/auth/register", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<RegisterResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToRegisterResponse());
    });
  }

  @override
  FutureProcessing<RegisterWithGoogleResponse> registerWithGoogle(RegisterWithGoogleParameter registerWithGoogleParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "id_token": registerWithGoogleParameter.idToken,
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/auth/google", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<RegisterWithGoogleResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToRegisterWithGoogleResponse());
    });
  }

  @override
  FutureProcessing<LogoutResponse> logout(LogoutParameter logoutParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/auth/logout", cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<LogoutResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToLogoutResponse());
    });
  }

  @override
  FutureProcessing<GetUserResponse> getUser(GetUserParameter getUserParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/auth/me", cancelToken: cancelToken)
        .map<GetUserResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetUserResponse());
    });
  }
}