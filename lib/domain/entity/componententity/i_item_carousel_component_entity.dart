import '../../../misc/multi_language_string.dart';
import 'i_component_entity.dart';

abstract class IItemCarouselComponentEntity<T> implements IComponentEntity {
  MultiLanguageString? get title;
  set title(MultiLanguageString? value);
  MultiLanguageString? get description;
  set description(MultiLanguageString? value);
  List<T> get item;
  set item(List<T> value);
}