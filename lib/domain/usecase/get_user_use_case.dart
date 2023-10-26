import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/user/getuser/get_user_parameter.dart';
import '../entity/user/getuser/get_user_response.dart';
import '../repository/user_repository.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  const GetUserUseCase({
    required this.userRepository
  });

  FutureProcessing<LoadDataResult<GetUserResponse>> execute(GetUserParameter getUserParameter) {
    return userRepository.getUser(getUserParameter);
  }
}