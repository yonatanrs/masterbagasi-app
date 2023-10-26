import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/entityandlistitemcontrollerstatemediator/parameterized_entity_and_list_item_controller_state_mediator.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../domain/entity/componententity/dynamicitemcarouseladditionalparameter/dynamic_item_carousel_additional_parameter.dart';
import '../../domain/entity/componententity/i_dynamic_item_carousel_component_entity.dart';
import '../../domain/entity/componententity/i_dynamic_item_carousel_directly_component_entity.dart';
import '../../domain/entity/componententity/i_item_carousel_component_entity.dart';
import '../constant.dart';
import '../controllerstate/listitemcontrollerstate/carousel_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import '../error/message_error.dart';
import '../errorprovider/error_provider.dart';
import '../load_data_result.dart';
import '../parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/horizontal_dynamic_item_carousel_parametered_component_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'horizontal_entity_and_list_item_controller_state_mediator.dart';

class HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator extends ParameterizedEntityAndListItemControllerStateMediator {
  HorizontalParameterizedEntityAndListItemControllerStateMediator horizontalEntityAndListItemControllerStateMediator;
  ErrorProvider errorProvider;

  HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator({
    required this.horizontalEntityAndListItemControllerStateMediator,
    required this.errorProvider
  });

  @override
  ListItemControllerState mapWithParameter(entity, {parameter}) {
    if (entity is IItemCarouselComponentEntity) {
      return CarouselListItemControllerState(
        title: entity.title.toEmptyStringNonNull,
        description: entity.description.toEmptyStringNonNull,
        padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
        itemListItemControllerState: entity.item.map<ListItemControllerState>(
          (entityParameter) => horizontalEntityAndListItemControllerStateMediator.mapWithParameter(
            entityParameter,
            parameter: parameter
          )
        ).toList()
      );
    } else if (entity is IDynamicItemCarouselComponentEntity) {
      if (parameter is HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter) {
        LoadDataResultDynamicListItemControllerState dynamicList = LoadDataResultDynamicListItemControllerState(
          loadDataResult: IsLoadingLoadDataResult(),
          errorProvider: errorProvider,
          isLoadingListItemControllerState: (listItemControllerState) {
            if (entity.onObserveLoadingDynamicItemActionState != null) {
              return entity.onObserveLoadingDynamicItemActionState!(
                entity.title, entity.description, IsLoadingLoadDataResult()
              );
            }
            throw MessageError(title: "onObserveLoadingDynamicItemActionState must not be null");
          },
          successListItemControllerState: (data) {
            return entity.onObserveSuccessDynamicItemActionState(
              entity.title, entity.description, SuccessLoadDataResult(value: data)
            );
          }
        );
        parameter.dynamicItemLoadDataResultDynamicListItemControllerStateList.add(dynamicList);
        void dynamicItemAction() {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            entity.onDynamicItemAction(
              entity.title,
              entity.description,
              (title, description, itemLoadDataResult) {
                dynamicList.loadDataResult = itemLoadDataResult;
                parameter.onSetState();
              }
            );
          });
        }
        dynamicItemAction();
        if (entity.dynamicItemCarouselAdditionalParameter is RepeatableDynamicItemCarouselAdditionalParameter) {
          RepeatableDynamicItemCarouselAdditionalParameter repeatableDynamicItemCarouselAdditionalParameter = entity.dynamicItemCarouselAdditionalParameter as RepeatableDynamicItemCarouselAdditionalParameter;
          repeatableDynamicItemCarouselAdditionalParameter._onRepeatLoading = dynamicItemAction;
        }
        return parameter.dynamicItemLoadDataResultDynamicListItemControllerStateList.last;
      } else {
        return NoContentListItemControllerState();
      }
    } else if (entity is IDynamicItemCarouselDirectlyComponentEntity) {
      if (parameter is HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter) {
        LoadDataResultDirectlyDynamicListItemControllerState dynamicList = LoadDataResultDirectlyDynamicListItemControllerState(
          loadDataResult: IsLoadingLoadDataResult(),
          errorProvider: errorProvider,
          onImplementLoadDataResultDirectlyListItemControllerState: (loadDataResult, errorProvider) {
            if (entity.onObserveDynamicItemActionStateDirectly != null) {
              return entity.onObserveDynamicItemActionStateDirectly!(
                entity.title, entity.description, loadDataResult, errorProvider
              );
            }
            throw MessageError(title: "onObserveDynamicItemActionStateDirectly must not be null");
          }
        );
        parameter.dynamicItemLoadDataResultDynamicListItemControllerStateList.add(dynamicList);
        void dynamicItemAction() {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            entity.onDynamicItemAction(
              entity.title,
              entity.description,
              (title, description, itemLoadDataResult) {
                dynamicList.loadDataResult = itemLoadDataResult;
                parameter.onSetState();
              }
            );
          });
        }
        dynamicItemAction();
        if (entity.dynamicItemCarouselAdditionalParameter is RepeatableDynamicItemCarouselAdditionalParameter) {
          RepeatableDynamicItemCarouselAdditionalParameter repeatableDynamicItemCarouselAdditionalParameter = entity.dynamicItemCarouselAdditionalParameter as RepeatableDynamicItemCarouselAdditionalParameter;
          repeatableDynamicItemCarouselAdditionalParameter._onRepeatLoading = dynamicItemAction;
        }
        return parameter.dynamicItemLoadDataResultDynamicListItemControllerStateList.last;
      } else {
        return NoContentListItemControllerState();
      }
    } else {
      return NoContentListItemControllerState();
    }
  }
}

class RepeatableDynamicItemCarouselAdditionalParameter extends DynamicItemCarouselAdditionalParameter {
  void Function()? _onRepeatLoading;

  void Function() get onRepeatLoading => _onRepeatLoading ?? (throw UnimplementedError());
}