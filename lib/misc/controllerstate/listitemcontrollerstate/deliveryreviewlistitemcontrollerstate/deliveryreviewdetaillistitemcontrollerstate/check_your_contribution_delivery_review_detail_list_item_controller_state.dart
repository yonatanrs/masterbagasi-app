import '../../../../../domain/entity/user/user.dart';
import '../../../../errorprovider/error_provider.dart';
import '../../../../load_data_result.dart';
import 'base_delivery_review_detail_list_item_controller_state.dart';

class CheckYourContributionDeliveryReviewDetailListItemControllerState extends BaseDeliveryReviewDetailListItemControllerState {
  LoadDataResult<User> userLoadDataResult;
  ErrorProvider errorProvider;
  void Function()? onTap;

  CheckYourContributionDeliveryReviewDetailListItemControllerState({
    required this.userLoadDataResult,
    required this.errorProvider,
    this.onTap
  });
}