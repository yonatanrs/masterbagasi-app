import '../productentry/product_entry.dart';
import 'product_bundle.dart';

class ProductBundleDetail extends ProductBundle {
  final List<ProductEntry> productEntryList;

  ProductBundleDetail({
    required String id,
    required String name,
    required String slug,
    required String description,
    required String imageUrl,
    required double price,
    required double rating,
    required this.productEntryList,
    required int soldOut
  }) : super(
    id: id,
    name: name,
    slug: slug,
    description: description,
    imageUrl: imageUrl,
    price: price,
    rating: rating,
    soldOut: soldOut
  );
}