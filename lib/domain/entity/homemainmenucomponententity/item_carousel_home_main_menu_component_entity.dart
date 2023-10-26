import '../../../misc/multi_language_string.dart';
import '../componententity/i_item_carousel_component_entity.dart';
import 'home_main_menu_component_entity.dart';

class ItemCarouselHomeMainMenuComponentEntity<T> extends HomeMainMenuComponentEntity implements IItemCarouselComponentEntity<T> {
  MultiLanguageString? _title;
  MultiLanguageString? _description;
  List<T> _item;

  ItemCarouselHomeMainMenuComponentEntity({
    MultiLanguageString? title,
    MultiLanguageString? description,
    required List<T> item,
  }) : _title = title, _description = description, _item = item;

  @override
  MultiLanguageString? get description => _description;

  @override
  List<T> get item => _item;

  @override
  MultiLanguageString? get title => _title;

  @override
  set description(MultiLanguageString? value) => _description = value;

  @override
  set item(List<T> value) => _item = value;

  @override
  set title(MultiLanguageString? value) => _title = value;
}