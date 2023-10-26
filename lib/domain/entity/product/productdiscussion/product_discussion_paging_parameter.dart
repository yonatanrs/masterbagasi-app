class ProductDiscussionPagingParameter {
  int page;
  int itemEachPageCount;

  ProductDiscussionPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}