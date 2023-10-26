import 'package:flutter/material.dart';

import '../typedef.dart';
import 'parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';

class CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter extends ParameterizedEntityAndListItemControllerStateMediatorParameter {
  OnAddCart? onAddCart;
  OnRemoveCart? onRemoveCart;

  CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter({
    this.onAddCart,
    this.onRemoveCart
  });
}