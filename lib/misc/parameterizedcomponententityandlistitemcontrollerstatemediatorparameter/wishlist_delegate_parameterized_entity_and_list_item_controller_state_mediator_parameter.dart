import 'package:flutter/material.dart';

import '../typedef.dart';
import 'parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';

class WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter extends ParameterizedEntityAndListItemControllerStateMediatorParameter {
  OnAddToWishlist? onAddToWishlist;
  OnRemoveFromWishlist? onRemoveFromWishlist;

  WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter({
    this.onAddToWishlist,
    this.onRemoveFromWishlist,
  });
}