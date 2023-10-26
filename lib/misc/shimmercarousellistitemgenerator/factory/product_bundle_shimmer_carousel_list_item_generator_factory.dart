import '../../../domain/dummy/productdummy/product_bundle_dummy.dart';
import '../product_bundle_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/product_bundle_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class ProductBundleShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<ProductBundleShimmerCarouselListItemGeneratorType> {
  final ProductBundleDummy productBundleDummy;

  ProductBundleShimmerCarouselListItemGeneratorFactory({
    required this.productBundleDummy
  });

  @override
  ShimmerCarouselListItemGenerator<ProductBundleShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return ProductBundleShimmerCarouselListItemGenerator(
      productBundleDummy: productBundleDummy
    );
  }
}