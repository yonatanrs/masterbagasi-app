import 'package:masterbagasi/data/entitymappingext/order_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/notification/notification.dart';
import '../../domain/entity/notification/short_notification.dart';
import '../../domain/entity/notification/user_notification.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension NotificationEntityMappingExt on ResponseWrapper {
  PagingDataResult<ShortNotification> mapFromResponseToShortNotificationPagingDataResult() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<ShortNotification>(
        (notificationResponse) => ResponseWrapper(notificationResponse).mapFromResponseToShortNotification()
      ).toList()
    );
  }
}

extension NotificationDetailEntityMappingExt on ResponseWrapper {
  Notification mapFromResponseToNotification() {
    return Notification(
      id: response["id"],
      userId: response["user_id"],
      title: response["title"],
      type: response["type"],
      subtype: response["subtype"],
      combinedOrderId: response["combined_order_id"],
      message: response["message"],
      orderId: response["order_id"],
      isRead: response["is_read"],
      userNotification: ResponseWrapper(response["user"]).mapFromResponseToUserNotification(),
      combinedOrder: ResponseWrapper(response["combined_order"]).mapFromResponseToCombinedOrder()
    );
  }

  ShortNotification mapFromResponseToShortNotification() {
    dynamic combinedOrder = response["combined_order"];
    return ShortNotification(
      id: response["id"],
      userId: response["user_id"],
      title: response["title"],
      type: response["type"],
      subtype: response["subtype"],
      combinedOrderId: response["combined_order_id"],
      message: response["message"],
      orderId: response["order_id"],
      isRead: response["is_read"],
      userNotification: ResponseWrapper(response["user"]).mapFromResponseToUserNotification(),
      orderCode: combinedOrder["order_code"]
    );
  }

  UserNotification mapFromResponseToUserNotification() {
    return UserNotification(
      id: response["id"],
      name: response["name"],
      role: response["role"],
      email: response["email"],
      createdAt: response["created_at"] != null ? ResponseWrapper(response["created_at"]).mapFromResponseToDateTime() : null
    );
  }
}