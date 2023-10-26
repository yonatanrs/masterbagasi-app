import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/login/login_parameter.dart';
import '../entity/login/login_response.dart';
import '../repository/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  const LoginUseCase({
    required this.userRepository
  });

  FutureProcessing<LoadDataResult<LoginResponse>> execute(LoginParameter loginParameter) {
    return userRepository.login(loginParameter);
  }
}