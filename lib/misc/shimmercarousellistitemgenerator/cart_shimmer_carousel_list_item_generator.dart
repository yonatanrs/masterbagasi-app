import '../../domain/dummy/cartdummy/cart_dummy.dart';
import '../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/shortcartlistitemcontrollerstate/horizontal_short_cart_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'shimmer_carousel_list_item_generator.dart';
import 'type/cart_shimmer_carousel_list_item_generator_type.dart';

class CartShimmerCarouselListItemGenerator extends ShimmerCarouselListItemGenerator<CartShimmerCarouselListItemGeneratorType> {
  final CartDummy cartDummy;

  @override
  CartShimmerCarouselListItemGeneratorType get shimmerCarouselListItemGeneratorType => CartShimmerCarouselListItemGeneratorType();

  CartShimmerCarouselListItemGenerator({
    required this.cartDummy,
  });

  @override
  ListItemControllerState onGenerateListItemValue() {
    return HorizontalShortCartListItemControllerState(
      cart: cartDummy.generateShimmerDummy()
    );
  }
}