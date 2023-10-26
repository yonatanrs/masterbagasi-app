import '../../../domain/dummy/productdummy/product_dummy.dart';
import '../product_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/product_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class ProductShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<ProductShimmerCarouselListItemGeneratorType> {
  final ProductDummy productDummy;

  ProductShimmerCarouselListItemGeneratorFactory({
    required this.productDummy
  });

  @override
  ShimmerCarouselListItemGenerator<ProductShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return ProductShimmerCarouselListItemGenerator(
      productDummy: productDummy
    );
  }
}