import '../../errorprovider/error_provider.dart';
import 'list_item_controller_state.dart';

class FailedPromptIndicatorListItemControllerState extends ListItemControllerState {
  ErrorProvider errorProvider;
  dynamic e;

  FailedPromptIndicatorListItemControllerState({
    required this.errorProvider,
    required this.e
  });
}