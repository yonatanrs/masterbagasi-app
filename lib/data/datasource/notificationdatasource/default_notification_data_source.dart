import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/notification_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../../domain/entity/notification/notification.dart';
import '../../../domain/entity/notification/notification_by_user_paging_parameter.dart';
import '../../../domain/entity/notification/short_notification.dart';
import '../../../domain/entity/notification/transaction_notification_detail_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'notification_data_source.dart';

class DefaultNotificationDataSource implements NotificationDataSource {
  final Dio dio;

  const DefaultNotificationDataSource({
    required this.dio
  });

  @override
  FutureProcessing<PagingDataResult<ShortNotification>> notificationByUserPaging(NotificationByUserPagingParameter notificationByUserPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/notification", queryParameters: {"page": notificationByUserPagingParameter.page, "pageNumber": notificationByUserPagingParameter.itemEachPageCount}, cancelToken: cancelToken)
        .map<PagingDataResult<ShortNotification>>(onMap: (value) => value.wrapResponse().mapFromResponseToShortNotificationPagingDataResult());
    });
  }

  @override
  FutureProcessing<Notification> transactionNotificationDetail(TransactionNotificationDetailParameter transactionNotificationDetailParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/notification/${transactionNotificationDetailParameter.notificationId}/transaction", cancelToken: cancelToken)
        .map<Notification>(onMap: (value) => value.wrapResponse().mapFromResponseToNotification());
    });
  }
}