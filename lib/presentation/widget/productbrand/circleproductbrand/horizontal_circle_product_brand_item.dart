import 'circle_product_brand_item.dart';

class HorizontalCircleProductBrandItem extends CircleProductBrandItem {
  @override
  double? get itemWidth => 100.0;

  const HorizontalCircleProductBrandItem({
    super.key,
    required super.productBrand
  });
}