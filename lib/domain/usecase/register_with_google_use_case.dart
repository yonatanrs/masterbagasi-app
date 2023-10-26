import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/register/register_with_google_parameter.dart';
import '../entity/register/register_with_google_response.dart';
import '../repository/user_repository.dart';

class RegisterWithGoogleUseCase {
  final UserRepository userRepository;

  const RegisterWithGoogleUseCase({
    required this.userRepository
  });

  FutureProcessing<LoadDataResult<RegisterWithGoogleResponse>> execute(RegisterWithGoogleParameter registerWithGoogleParameter) {
    return userRepository.registerWithGoogle(registerWithGoogleParameter);
  }
}