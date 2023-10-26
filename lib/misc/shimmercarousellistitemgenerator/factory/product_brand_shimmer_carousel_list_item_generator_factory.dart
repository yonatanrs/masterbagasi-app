import '../../../domain/dummy/productdummy/product_brand_dummy.dart';
import '../product_brand_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/product_brand_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class ProductBrandShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<ProductBrandShimmerCarouselListItemGeneratorType> {
  final ProductBrandDummy productBrandDummy;

  ProductBrandShimmerCarouselListItemGeneratorFactory({
    required this.productBrandDummy
  });

  @override
  ShimmerCarouselListItemGenerator<ProductBrandShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return ProductBrandShimmerCarouselListItemGenerator(
      productBrandDummy: productBrandDummy
    );
  }
}