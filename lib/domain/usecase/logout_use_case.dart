import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/logout/logout_parameter.dart';
import '../entity/logout/logout_response.dart';
import '../repository/user_repository.dart';

class LogoutUseCase {
  final UserRepository userRepository;

  const LogoutUseCase({
    required this.userRepository
  });

  FutureProcessing<LoadDataResult<LogoutResponse>> execute(LogoutParameter logoutParameter) {
    return userRepository.logout(logoutParameter);
  }
}