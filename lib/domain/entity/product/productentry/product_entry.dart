import '../../cart/support_cart.dart';
import '../../order/support_order_product.dart';
import '../../wishlist/support_wishlist.dart';
import '../product.dart';
import '../product_appearance_data.dart';
import '../productvariant/product_variant.dart';

class ProductEntry implements ProductEntryAppearanceData, SupportCart, SupportWishlist, SupportOrderProduct {
  String id;
  @override
  String productId;
  @override
  String productEntryId;
  String sku;
  String sustension;
  @override
  double weight;
  int isViral;
  int isKitchen;
  int isHandycrafts;
  int isFashionable;
  int purchasePrice;
  int sellingPrice;
  int isBestSelling;
  Product product;
  List<String> imageUrlList;
  List<ProductVariant> productVariantList;
  @override
  int soldCount;
  bool _hasAddedToWishlist;

  @override
  String get cartTitle => name;

  @override
  double get cartPrice => sellingPrice.toDouble();

  @override
  String get cartImageUrl => imageUrl;

  @override
  String get orderTitle => name;

  @override
  double get orderPrice => sellingPrice.toDouble();

  @override
  String get orderImageUrl => imageUrl;

  ProductEntry({
    required this.id,
    required this.productId,
    required this.productEntryId,
    required this.sku,
    required this.sustension,
    required this.weight,
    required this.isViral,
    required this.isKitchen,
    required this.isHandycrafts,
    required this.isFashionable,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.isBestSelling,
    required this.product,
    required this.productVariantList,
    required this.imageUrlList,
    required this.soldCount,
    required bool hasAddedToWishlist,
  }) : _hasAddedToWishlist = hasAddedToWishlist;

  @override
  double? get discountPrice => product.discountPrice;

  @override
  String get imageUrl {
    if (imageUrlList.isEmpty) {
      return "";
    }
    return imageUrlList.first;
  }

  @override
  String get name => product.name;

  @override
  double get price => sellingPrice.toDouble();

  @override
  String get supportWishlistContentId => productEntryId;

  @override
  bool get hasAddedToWishlist => _hasAddedToWishlist;
}