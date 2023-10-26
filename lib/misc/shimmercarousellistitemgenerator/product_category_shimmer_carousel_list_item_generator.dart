import '../../domain/dummy/productdummy/product_category_dummy.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/horizontal_product_category_list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/product_category_shimmer_carousel_list_item_generator_type.dart';

class ProductCategoryShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<ProductCategoryShimmerCarouselListItemGeneratorType> {
  final ProductCategoryDummy productCategoryDummy;

  @override
  ProductCategoryShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => ProductCategoryShimmerCarouselListItemGeneratorType();

  ProductCategoryShimmerCarouselListItemGenerator({
    required this.productCategoryDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalProductCategoryListItemControllerState(
      productCategory: productCategoryDummy.generateShimmerDummy()
    );
  }
}