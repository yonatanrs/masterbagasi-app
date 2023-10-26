import 'address_item.dart';

class VerticalAddressItem extends AddressItem {
  @override
  double? get itemWidth => null;

  const VerticalAddressItem({
    super.key,
    required super.address,
    super.onSelectAddress,
    super.onRemoveAddress,
    super.canBeModified = true
  });
}