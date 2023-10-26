class AddressPagingParameter {
  int page;
  int itemEachPageCount;

  AddressPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}