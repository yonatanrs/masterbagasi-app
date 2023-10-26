class ShortVideoPagingParameter {
  int page;
  int itemEachPageCount;

  ShortVideoPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}