import '../../domain/dummy/productdummy/product_bundle_dummy.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/horizontal_product_bundle_list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/product_bundle_shimmer_carousel_list_item_generator_type.dart';

class ProductBundleShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<ProductBundleShimmerCarouselListItemGeneratorType> {
  final ProductBundleDummy productBundleDummy;

  @override
  ProductBundleShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => ProductBundleShimmerCarouselListItemGeneratorType();

  ProductBundleShimmerCarouselListItemGenerator({
    required this.productBundleDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalProductBundleListItemControllerState(
      productBundle: productBundleDummy.generateShimmerDummy()
    );
  }
}