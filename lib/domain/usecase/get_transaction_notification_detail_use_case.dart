import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/notification/notification.dart';
import '../entity/notification/transaction_notification_detail_parameter.dart';
import '../repository/notification_repository.dart';

class GetTransactionNotificationDetailUseCase {
  final NotificationRepository notificationRepository;

  const GetTransactionNotificationDetailUseCase({
    required this.notificationRepository
  });

  FutureProcessing<LoadDataResult<Notification>> execute(TransactionNotificationDetailParameter transactionNotificationDetailParameter) {
    return notificationRepository.transactionNotificationDetail(transactionNotificationDetailParameter);
  }
}