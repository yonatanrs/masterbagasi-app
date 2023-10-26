import '../../../misc/multi_language_string.dart';
import '../homemainmenucomponententity/dynamic_item_carousel_home_main_menu_component_entity.dart';
import 'dynamicitemcarouseladditionalparameter/dynamic_item_carousel_additional_parameter.dart';
import 'i_component_entity.dart';

abstract class IDynamicItemCarouselComponentEntity<T> implements IComponentEntity {
  MultiLanguageString? get title;
  set title(MultiLanguageString? value);
  MultiLanguageString? get description;
  set description(MultiLanguageString? value);
  Future<void> Function(MultiLanguageString? title, MultiLanguageString? description, DynamicItemAction dynamicItemAction) get onDynamicItemAction;
  set onDynamicItemAction(Function(MultiLanguageString? title, MultiLanguageString? description, DynamicItemAction dynamicItemAction) value);
  ObserveDynamicItemAction? get onObserveLoadingDynamicItemActionState;
  set onObserveLoadingDynamicItemActionState(ObserveDynamicItemAction? value);
  ObserveDynamicItemAction get onObserveSuccessDynamicItemActionState;
  set onObserveSuccessDynamicItemActionState(ObserveDynamicItemAction value);
  DynamicItemCarouselAdditionalParameter? get dynamicItemCarouselAdditionalParameter;
  set dynamicItemCarouselAdditionalParameter(DynamicItemCarouselAdditionalParameter? value);
}