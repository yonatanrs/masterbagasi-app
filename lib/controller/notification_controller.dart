import '../domain/entity/notification/notification.dart';
import '../domain/entity/notification/notification_by_user_paging_parameter.dart';
import '../domain/entity/notification/short_notification.dart';
import '../domain/entity/notification/transaction_notification_detail_parameter.dart';
import '../domain/usecase/get_notification_by_user_paging_use_case.dart';
import '../domain/usecase/get_transaction_notification_detail_use_case.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import 'base_getx_controller.dart';

class NotificationController extends BaseGetxController {
  final GetNotificationByUserPagingUseCase getNotificationByUserPagingUseCase;
  final GetTransactionNotificationDetailUseCase getTransactionNotificationDetailUseCase;

  NotificationController(
    super.controllerManager,
    this.getNotificationByUserPagingUseCase,
    this.getTransactionNotificationDetailUseCase
  );

  Future<LoadDataResult<PagingDataResult<ShortNotification>>> getNotificationByUser(NotificationByUserPagingParameter notificationByUserPagingParameter) {
    return getNotificationByUserPagingUseCase.execute(notificationByUserPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("notification-by-user").value
    );
  }

  Future<LoadDataResult<Notification>> getTransactionNotificationDetail(TransactionNotificationDetailParameter transactionNotificationDetailParameter) {
    return getTransactionNotificationDetailUseCase.execute(transactionNotificationDetailParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("transaction-detail-notification").value
    );
  }
}