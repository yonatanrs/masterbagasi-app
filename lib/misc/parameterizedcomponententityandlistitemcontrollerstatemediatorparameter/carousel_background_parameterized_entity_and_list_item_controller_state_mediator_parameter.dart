import '../../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import '../carouselbackground/carousel_background.dart';
import 'parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';

class CarouselParameterizedEntityAndListItemControllerStateMediatorParameter extends ParameterizedEntityAndListItemControllerStateMediatorParameter {
  CarouselBackground carouselBackground;
  TitleInterceptor? titleInterceptor;

  CarouselParameterizedEntityAndListItemControllerStateMediatorParameter({
    required this.carouselBackground,
    this.titleInterceptor
  });
}