import 'package:flutter/material.dart';

import '../../../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import '../../carouselbackground/carousel_background.dart';
import '../../shimmercarousellistitemgenerator/shimmer_carousel_list_item_generator.dart';
import '../../shimmercarousellistitemgenerator/type/shimmer_carousel_list_item_generator_type.dart';
import 'list_item_controller_state.dart';

class CarouselListItemControllerState extends ListItemControllerState {
  EdgeInsetsGeometry? padding;
  double? betweenTitleDescriptionAndCarouselItemVerticalSpace;
  List<ListItemControllerState> itemListItemControllerState;
  String title;
  TitleInterceptor? titleInterceptor;
  String description;
  DescriptionInterceptor? descriptionInterceptor;
  CarouselBackground? carouselBackground;

  CarouselListItemControllerState({
    this.padding,
    this.betweenTitleDescriptionAndCarouselItemVerticalSpace,
    this.itemListItemControllerState = const [],
    this.title = "",
    this.titleInterceptor,
    this.description = "",
    this.descriptionInterceptor,
    this.carouselBackground
  });
}

class ShimmerCarouselListItemControllerState<G extends ShimmerCarouselListItemGeneratorType> extends ListItemControllerState {
  EdgeInsetsGeometry? padding;
  double? betweenTitleDescriptionAndCarouselItemVerticalSpace;
  bool showTitleShimmer;
  bool showDescriptionShimmer;
  bool showItemShimmer;
  ShimmerCarouselListItemGenerator<G> shimmerCarouselListItemGenerator;

  ShimmerCarouselListItemControllerState({
    this.padding,
    this.betweenTitleDescriptionAndCarouselItemVerticalSpace,
    this.showTitleShimmer = true,
    this.showDescriptionShimmer = true,
    this.showItemShimmer = true,
    required this.shimmerCarouselListItemGenerator
  });
}