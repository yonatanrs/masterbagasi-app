import '../../../misc/load_data_result.dart';
import '../user/user.dart';

class UserMessageResponseWrapper<T> {
  LoadDataResult<User> userLoadDataResult;
  LoadDataResult<T> valueLoadDataResult;

  UserMessageResponseWrapper({
    required this.userLoadDataResult,
    required this.valueLoadDataResult
  });
}