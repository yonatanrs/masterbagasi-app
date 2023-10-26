import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../../domain/entity/componententity/dynamic_item_carousel_directly_component_entity.dart';
import '../../../domain/entity/componententity/i_component_entity.dart';
import '../../../domain/entity/delivery/delivery_review.dart';
import '../../../domain/entity/delivery/delivery_review_paging_parameter.dart';
import '../../../domain/entity/user/getuser/get_user_parameter.dart';
import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/get_user_use_case.dart';
import '../../../domain/usecase/get_waiting_to_be_reviewed_delivery_review_paging_use_case.dart';
import '../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../misc/error/message_error.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../../misc/multi_language_string.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../base_getx_controller.dart';

class WaitingToBeReviewedDeliveryReviewSubController extends BaseGetxController {
  final GetWaitingToBeReviewedDeliveryReviewPagingUseCase getWaitingToBeReviewedDeliveryReviewPagingUseCase;
  final GetUserUseCase getUserUseCase;
  WaitingToBeReviewedDeliveryReviewSubDelegate? _waitingToBeReviewedDeliveryReviewSubDelegate;

  WaitingToBeReviewedDeliveryReviewSubController(
    super.controllerManager,
    this.getWaitingToBeReviewedDeliveryReviewPagingUseCase,
    this.getUserUseCase
  );

  Future<LoadDataResult<PagingDataResult<DeliveryReview>>> getWaitingToBeReviewedDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return getWaitingToBeReviewedDeliveryReviewPagingUseCase.execute(deliveryReviewPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("waiting-to-be-reviewed-delivery-review").value
    );
  }

  IComponentEntity getUserProfile() {
    return DynamicItemCarouselDirectlyComponentEntity(
      title: MultiLanguageString(""),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<User>());
        LoadDataResult<User> userLoadDataResult = await getUserUseCase.execute(
          GetUserParameter()
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("logged-user-profile").value
        ).map<User>(
          (getUserResponse) => getUserResponse.user
        );
        if (userLoadDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, userLoadDataResult);
      },
      observeDynamicItemActionStateDirectly: (title, description, itemLoadDataResult, errorProvider) {
        LoadDataResult<User> userLoadDataResult = itemLoadDataResult.castFromDynamic<User>();
        if (_waitingToBeReviewedDeliveryReviewSubDelegate != null) {
          return _waitingToBeReviewedDeliveryReviewSubDelegate!.onObserveLoadUserDirectly(
            _OnObserveLoadUserDirectlyParameter(
              userLoadDataResult: userLoadDataResult
            )
          );
        } else {
          throw MessageError(title: "Waiting to be reviewed delivery review sub delegate must be not null");
        }
      },
    );
  }

  WaitingToBeReviewedDeliveryReviewSubController setWaitingToBeReviewedDeliveryReviewSubDelegate(WaitingToBeReviewedDeliveryReviewSubDelegate? waitingToBeReviewedDeliveryReviewSubDelegate) {
    _waitingToBeReviewedDeliveryReviewSubDelegate = waitingToBeReviewedDeliveryReviewSubDelegate;
    return this;
  }
}

class WaitingToBeReviewedDeliveryReviewSubControllerInjectionFactory {
  final GetWaitingToBeReviewedDeliveryReviewPagingUseCase getWaitingToBeReviewedDeliveryReviewPagingUseCase;
  final GetUserUseCase getUserUseCase;

  WaitingToBeReviewedDeliveryReviewSubControllerInjectionFactory({
    required this.getWaitingToBeReviewedDeliveryReviewPagingUseCase,
    required this.getUserUseCase
  });

  WaitingToBeReviewedDeliveryReviewSubController inject(ControllerManager controllerManager, String pageName) {
    return GetExtended.put<WaitingToBeReviewedDeliveryReviewSubController>(
      WaitingToBeReviewedDeliveryReviewSubController(
        controllerManager,
        getWaitingToBeReviewedDeliveryReviewPagingUseCase,
        getUserUseCase
      ),
      tag: pageName
    );
  }
}

class WaitingToBeReviewedDeliveryReviewSubDelegate {
  ListItemControllerState Function(_OnObserveLoadUserDirectlyParameter) onObserveLoadUserDirectly;

  WaitingToBeReviewedDeliveryReviewSubDelegate({
    required this.onObserveLoadUserDirectly
  });
}

class _OnObserveLoadUserDirectlyParameter {
  LoadDataResult<User> userLoadDataResult;

  _OnObserveLoadUserDirectlyParameter({
    required this.userLoadDataResult
  });
}