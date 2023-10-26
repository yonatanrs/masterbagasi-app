import '../../domain/dummy/productdummy/product_brand_dummy.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/horizontal_product_brand_list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/product_brand_shimmer_carousel_list_item_generator_type.dart';

class ProductBrandShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<ProductBrandShimmerCarouselListItemGeneratorType> {
  final ProductBrandDummy productBrandDummy;

  @override
  ProductBrandShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => ProductBrandShimmerCarouselListItemGeneratorType();

  ProductBrandShimmerCarouselListItemGenerator({
    required this.productBrandDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalProductBrandListItemControllerState(
      productBrand: productBrandDummy.generateShimmerDummy()
    );
  }
}