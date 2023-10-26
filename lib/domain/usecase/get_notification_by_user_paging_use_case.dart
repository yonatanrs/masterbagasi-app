import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/notification/notification_by_user_paging_parameter.dart';
import '../entity/notification/short_notification.dart';
import '../repository/notification_repository.dart';

class GetNotificationByUserPagingUseCase {
  final NotificationRepository notificationRepository;

  const GetNotificationByUserPagingUseCase({
    required this.notificationRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ShortNotification>>> execute(NotificationByUserPagingParameter notificationByUserPagingParameter) {
    return notificationRepository.notificationByUserPaging(notificationByUserPagingParameter);
  }
}