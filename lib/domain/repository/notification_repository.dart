import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/notification/notification.dart';
import '../entity/notification/notification_by_user_paging_parameter.dart';
import '../entity/notification/short_notification.dart';
import '../entity/notification/transaction_notification_detail_parameter.dart';

abstract class NotificationRepository {
  FutureProcessing<LoadDataResult<PagingDataResult<ShortNotification>>> notificationByUserPaging(NotificationByUserPagingParameter notificationByUserPagingParameter);
  FutureProcessing<LoadDataResult<Notification>> transactionNotificationDetail(TransactionNotificationDetailParameter transactionNotificationDetailParameter);
}