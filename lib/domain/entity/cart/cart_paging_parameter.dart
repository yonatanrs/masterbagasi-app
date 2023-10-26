class CartPagingParameter {
  int page;
  int itemEachPageCount;

  CartPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}