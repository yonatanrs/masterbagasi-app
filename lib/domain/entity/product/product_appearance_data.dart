abstract class ProductAppearanceData {
  String get productId;
  String get name;
  double get price;
  double? get discountPrice;
  double get weight;
  String get imageUrl;
}

abstract class ProductEntryAppearanceData extends ProductAppearanceData {
  String get productEntryId;
  int get soldCount;
  bool get hasAddedToWishlist;
}