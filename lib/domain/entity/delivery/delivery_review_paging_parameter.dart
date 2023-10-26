class DeliveryReviewPagingParameter {
  int page;
  int itemEachPageCount;

  DeliveryReviewPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}