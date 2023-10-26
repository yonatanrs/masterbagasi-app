import '../../../domain/entity/notification/notification.dart';
import '../../../domain/entity/notification/notification_by_user_paging_parameter.dart';
import '../../../domain/entity/notification/short_notification.dart';
import '../../../domain/entity/notification/transaction_notification_detail_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class NotificationDataSource {
  FutureProcessing<PagingDataResult<ShortNotification>> notificationByUserPaging(NotificationByUserPagingParameter notificationByUserPagingParameter);
  FutureProcessing<Notification> transactionNotificationDetail(TransactionNotificationDetailParameter transactionNotificationDetailParameter);
}