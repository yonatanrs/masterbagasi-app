class NewsPagingParameter {
  int page;
  int itemEachPageCount;

  NewsPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}