class CartListParameter {
  int page;
  int itemEachPageCount;

  CartListParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}