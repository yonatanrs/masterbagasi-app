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
import '../../../misc/processing/future_processing.dart';

abstract class UserDataSource {
  FutureProcessing<LoginResponse> login(LoginParameter loginParameter);
  FutureProcessing<LoginWithGoogleResponse> loginWithGoogle(LoginWithGoogleParameter loginWithGoogleParameter);
  FutureProcessing<RegisterResponse> register(RegisterParameter registerParameter);
  FutureProcessing<RegisterWithGoogleResponse> registerWithGoogle(RegisterWithGoogleParameter registerWithGoogleParameter);
  FutureProcessing<LogoutResponse> logout(LogoutParameter logoutParameter);
  FutureProcessing<GetUserResponse> getUser(GetUserParameter getUserParameter);
}