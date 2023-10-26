import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'type/shimmer_carousel_list_item_generator_type.dart';

abstract class ShimmerCarouselListItemGenerator<G extends ShimmerCarouselListItemGeneratorType> {
  G get shimmerCarouselListItemGeneratorType;
  ListItemControllerState onGenerateListItemValue();
}