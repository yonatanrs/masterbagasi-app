import '../order/combined_order.dart';
import 'user_notification.dart';

class Notification {
  String id;
  String userId;
  String title;
  String type;
  String subtype;
  String combinedOrderId;
  String message;
  String? orderId;
  int isRead;
  UserNotification userNotification;
  CombinedOrder combinedOrder;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.subtype,
    required this.combinedOrderId,
    required this.message,
    required this.orderId,
    required this.isRead,
    required this.userNotification,
    required this.combinedOrder
  });
}