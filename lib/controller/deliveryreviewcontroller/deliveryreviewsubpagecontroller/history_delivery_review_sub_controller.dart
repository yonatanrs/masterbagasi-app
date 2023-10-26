import '../../../domain/entity/delivery/delivery_review.dart';
import '../../../domain/entity/delivery/delivery_review_paging_parameter.dart';
import '../../../domain/usecase/get_history_delivery_review_paging_use_case.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../base_getx_controller.dart';

class HistoryDeliveryReviewSubController extends BaseGetxController {
  final GetHistoryDeliveryReviewPagingUseCase getHistoryDeliveryReviewPagingUseCase;

  HistoryDeliveryReviewSubController(
    super.controllerManager,
    this.getHistoryDeliveryReviewPagingUseCase
  );

  Future<LoadDataResult<PagingDataResult<DeliveryReview>>> getHistoryDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return getHistoryDeliveryReviewPagingUseCase.execute(deliveryReviewPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("history-delivery-review").value
    );
  }
}

class HistoryDeliveryReviewSubControllerInjectionFactory {
  final GetHistoryDeliveryReviewPagingUseCase getHistoryDeliveryReviewPagingUseCase;

  HistoryDeliveryReviewSubControllerInjectionFactory({
    required this.getHistoryDeliveryReviewPagingUseCase
  });

  HistoryDeliveryReviewSubController inject(ControllerManager controllerManager, String pageName) {
    return GetExtended.put<HistoryDeliveryReviewSubController>(
      HistoryDeliveryReviewSubController(
        controllerManager,
        getHistoryDeliveryReviewPagingUseCase
      ),
      tag: pageName
    );
  }
}