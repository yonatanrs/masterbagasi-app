import '../../domain/entity/notification/notification.dart';
import '../../domain/entity/notification/notification_by_user_paging_parameter.dart';
import '../../domain/entity/notification/short_notification.dart';
import '../../domain/entity/notification/transaction_notification_detail_parameter.dart';
import '../../domain/repository/notification_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/notificationdatasource/notification_data_source.dart';

class DefaultNotificationRepository implements NotificationRepository {
  final NotificationDataSource notificationDataSource;

  const DefaultNotificationRepository({
    required this.notificationDataSource
  });

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ShortNotification>>> notificationByUserPaging(NotificationByUserPagingParameter notificationByUserPagingParameter) {
    return notificationDataSource.notificationByUserPaging(notificationByUserPagingParameter).mapToLoadDataResult<PagingDataResult<ShortNotification>>();
  }

  @override
  FutureProcessing<LoadDataResult<Notification>> transactionNotificationDetail(TransactionNotificationDetailParameter transactionNotificationDetailParameter) {
    return notificationDataSource.transactionNotificationDetail(transactionNotificationDetailParameter).mapToLoadDataResult<Notification>();
  }
}