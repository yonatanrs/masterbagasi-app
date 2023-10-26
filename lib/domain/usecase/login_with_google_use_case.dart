import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/login/login_with_google_parameter.dart';
import '../entity/login/login_with_google_response.dart';
import '../repository/user_repository.dart';

class LoginWithGoogleUseCase {
  final UserRepository userRepository;

  const LoginWithGoogleUseCase({
    required this.userRepository
  });

  FutureProcessing<LoadDataResult<LoginWithGoogleResponse>> execute(LoginWithGoogleParameter loginWithGoogleParameter) {
    return userRepository.loginWithGoogle(loginWithGoogleParameter);
  }
}