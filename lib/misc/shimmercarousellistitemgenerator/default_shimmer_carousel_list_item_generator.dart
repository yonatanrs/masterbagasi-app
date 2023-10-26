import '../../domain/dummy/productdummy/product_brand_dummy.dart';
import '../../domain/dummy/productdummy/product_bundle_dummy.dart';
import '../../domain/dummy/productdummy/product_category_dummy.dart';
import '../../domain/dummy/productdummy/product_dummy.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/horizontal_product_brand_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/horizontal_product_bundle_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/horizontal_product_category_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/horizontal_product_list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/product_brand_shimmer_carousel_list_item_generator_type.dart';
import 'type/product_bundle_shimmer_carousel_list_item_generator_type.dart';
import 'type/product_category_shimmer_carousel_list_item_generator_type.dart';
import 'type/shimmer_carousel_list_item_generator_type.dart';
import 'type/product_shimmer_carousel_list_item_generator_type.dart';

class DefaultShimmerCarouselListItemGenerator<G extends ShimmerCarouselListItemGeneratorType> extends ShimmerCarouselListItemGenerator<G> {
  final G _shimmerCarouselListItemGeneratorType;
  final ProductDummy productDummy;
  final ProductCategoryDummy productCategoryDummy;
  final ProductBundleDummy productBundleDummy;
  final ProductBrandDummy productBrandDummy;

  @override
  G get shimmerCarouselListItemGeneratorType => _shimmerCarouselListItemGeneratorType;

  DefaultShimmerCarouselListItemGenerator({
    required G shimmerCarouselListItemGeneratorType,
    required this.productDummy,
    required this.productCategoryDummy,
    required this.productBundleDummy,
    required this.productBrandDummy
  }) : _shimmerCarouselListItemGeneratorType = shimmerCarouselListItemGeneratorType;

  @override
  ListItemControllerState onGenerateListItemValue() {
    if (_shimmerCarouselListItemGeneratorType is ProductShimmerCarouselListItemGeneratorType) {
      return HorizontalProductListItemControllerState(
        productAppearanceData: productDummy.generateShimmerDummy()
      );
    } else if (_shimmerCarouselListItemGeneratorType is ProductCategoryShimmerCarouselListItemGeneratorType) {
      return HorizontalProductCategoryListItemControllerState(
        productCategory: productCategoryDummy.generateShimmerDummy()
      );
    } else if (_shimmerCarouselListItemGeneratorType is ProductBrandShimmerCarouselListItemGeneratorType) {
      return HorizontalProductBundleListItemControllerState(
        productBundle: productBundleDummy.generateShimmerDummy()
      );
    } else if (_shimmerCarouselListItemGeneratorType is ProductBundleShimmerCarouselListItemGeneratorType) {
      return HorizontalProductBrandListItemControllerState(
        productBrand: productBrandDummy.generateShimmerDummy()
      );
    } else if (_shimmerCarouselListItemGeneratorType is ProductBundleShimmerCarouselListItemGeneratorType) {
      return HorizontalProductBrandListItemControllerState(
        productBrand: productBrandDummy.generateShimmerDummy()
      );
    } else {
      throw Exception("No item desired in generating shimmer carousel list item.");
    }
  }
}