class CountryDeliveryReviewMediaPagingParameter {
  String countryId;
  int page;
  int itemEachPageCount;

  CountryDeliveryReviewMediaPagingParameter({
    required this.countryId,
    required this.page,
    this.itemEachPageCount = 15
  });
}