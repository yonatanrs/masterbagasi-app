import '../../../domain/entity/user/user.dart';
import '../../errorprovider/error_provider.dart';
import '../../load_data_result.dart';
import 'list_item_controller_state.dart';

class MenuProfileHeaderListItemControllerState extends ListItemControllerState {
  LoadDataResult<User> userLoadDataResult;
  ErrorProvider errorProvider;

  MenuProfileHeaderListItemControllerState({
    required this.userLoadDataResult,
    required this.errorProvider
  });
}