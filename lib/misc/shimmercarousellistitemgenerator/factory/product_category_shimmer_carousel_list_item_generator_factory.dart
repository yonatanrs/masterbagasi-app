import '../../../domain/dummy/productdummy/product_category_dummy.dart';
import '../product_category_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/product_category_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class ProductCategoryShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<ProductCategoryShimmerCarouselListItemGeneratorType> {
  final ProductCategoryDummy productCategoryDummy;

  ProductCategoryShimmerCarouselListItemGeneratorFactory({
    required this.productCategoryDummy
  });

  @override
  ShimmerCarouselListItemGenerator<ProductCategoryShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return ProductCategoryShimmerCarouselListItemGenerator(
      productCategoryDummy: productCategoryDummy
    );
  }
}