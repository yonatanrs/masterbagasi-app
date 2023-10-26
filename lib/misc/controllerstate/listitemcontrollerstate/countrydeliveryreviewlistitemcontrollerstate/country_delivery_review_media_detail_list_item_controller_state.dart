import 'package:flutter/material.dart';

import '../../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../list_item_controller_state.dart';
import '../support_vertical_grid_list_item_controller_state.dart';

class CountryDeliveryReviewMediaDetailListItemControllerState extends ListItemControllerState with SupportVerticalGridListItemControllerStateMixin {
  @override
  int get maxRow => 2;

  CountryDeliveryReviewMedia countryDeliveryReviewMedia;
  BuildContext Function()? contextForOpeningMediaView;

  CountryDeliveryReviewMediaDetailListItemControllerState({
    required this.countryDeliveryReviewMedia,
    required this.contextForOpeningMediaView
  });
}