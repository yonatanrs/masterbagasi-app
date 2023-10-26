class CouponPagingParameter {
  int page;
  int itemEachPageCount;

  CouponPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}