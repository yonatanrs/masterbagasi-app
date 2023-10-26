class OrderPagingParameter {
  int page;
  int itemEachPageCount;
  String status;

  OrderPagingParameter({
    required this.page,
    this.itemEachPageCount = 15,
    this.status = ""
  });
}