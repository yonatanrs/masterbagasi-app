class NotificationByUserPagingParameter {
  int page;
  int itemEachPageCount;

  NotificationByUserPagingParameter({
    required this.page,
    this.itemEachPageCount = 15,
  });
}