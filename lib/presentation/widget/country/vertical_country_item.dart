import 'country_item.dart';

class VerticalCountryItem extends CountryItem {
  @override
  double? get itemWidth => null;

  const VerticalCountryItem({
    super.key,
    required super.country,
    required super.isSelected,
    super.onSelectCountry,
  });
}