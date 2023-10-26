import 'list_item_controller_state.dart';

class ExpandableDescriptionListItemControllerState extends ListItemControllerState {
  ExpandableDescriptionListValueWrapper expandableDescriptionListValueWrapper;

  ExpandableDescriptionListItemControllerState({
    required this.expandableDescriptionListValueWrapper
  });
}

class ExpandableDescriptionListValueWrapper {
  String? shortDescription;
  String? description;
  bool expand;
  void Function()? onUpdateListItemControllerState;

  ExpandableDescriptionListValueWrapper({
    this.shortDescription,
    this.description,
    required this.expand,
    this.onUpdateListItemControllerState
  });
}