class CountryPagingParameter {
  int page;
  int itemEachPageCount;

  CountryPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}