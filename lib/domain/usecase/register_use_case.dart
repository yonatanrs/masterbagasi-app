import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/register/register_parameter.dart';
import '../entity/register/register_response.dart';
import '../repository/user_repository.dart';

class RegisterUseCase {
  final UserRepository userRepository;

  const RegisterUseCase({
    required this.userRepository
  });

  FutureProcessing<LoadDataResult<RegisterResponse>> execute(RegisterParameter registerParameter) {
    return userRepository.register(registerParameter);
  }
}