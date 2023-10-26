class ProductDiscussionDialogPagingParameter {
  int page;
  int itemEachPageCount;

  ProductDiscussionDialogPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}