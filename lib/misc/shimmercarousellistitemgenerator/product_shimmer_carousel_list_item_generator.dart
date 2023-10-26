import '../../domain/dummy/productdummy/product_dummy.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/horizontal_product_list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/product_shimmer_carousel_list_item_generator_type.dart';

class ProductShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<ProductShimmerCarouselListItemGeneratorType> {
  final ProductDummy productDummy;

  @override
  ProductShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => ProductShimmerCarouselListItemGeneratorType();

  ProductShimmerCarouselListItemGenerator({
    required this.productDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalProductListItemControllerState(
      productAppearanceData: productDummy.generateShimmerDummy()
    );
  }
}