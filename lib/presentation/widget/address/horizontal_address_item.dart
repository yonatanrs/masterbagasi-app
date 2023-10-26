import 'address_item.dart';

class HorizontalAddressItem extends AddressItem {
  @override
  double? get itemWidth => 180;

  @override
  bool get hasSingleLines => true;

  const HorizontalAddressItem({
    super.key,
    required super.address,
    super.onSelectAddress,
    super.onRemoveAddress,
    super.canBeModified = false
  });
}