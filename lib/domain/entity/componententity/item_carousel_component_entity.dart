import '../../../misc/multi_language_string.dart';
import 'i_item_carousel_component_entity.dart';

class ItemCarouselComponentEntity<T> implements IItemCarouselComponentEntity<T> {
  MultiLanguageString? _title;
  MultiLanguageString? _description;
  List<T> _item;

  ItemCarouselComponentEntity({
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