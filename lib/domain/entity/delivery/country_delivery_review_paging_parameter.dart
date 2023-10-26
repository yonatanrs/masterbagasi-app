class CountryDeliveryReviewPagingParameter {
  int page;
  int itemEachPageCount;

  CountryDeliveryReviewPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}