import '../../../domain/dummy/cartdummy/cart_dummy.dart';
import '../cart_shimmer_carousel_list_item_generator.dart';
import '../shimmer_carousel_list_item_generator.dart';
import '../type/cart_shimmer_carousel_list_item_generator_type.dart';
import 'shimmer_carousel_list_item_generator_factory.dart';

class CartShimmerCarouselListItemGeneratorFactory extends ShimmerCarouselListItemGeneratorFactory<CartShimmerCarouselListItemGeneratorType> {
  final CartDummy cartDummy;

  CartShimmerCarouselListItemGeneratorFactory({
    required this.cartDummy
  });

  @override
  ShimmerCarouselListItemGenerator<CartShimmerCarouselListItemGeneratorType> getShimmerCarouselListItemGeneratorType() {
    return CartShimmerCarouselListItemGenerator(
      cartDummy: cartDummy
    );
  }
}