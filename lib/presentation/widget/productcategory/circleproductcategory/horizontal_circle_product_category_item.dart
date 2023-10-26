import 'circle_product_category_item.dart';

class HorizontalCircleProductCategoryItem extends CircleProductCategoryItem {
  @override
  double? get itemWidth => 180.0;

  const HorizontalCircleProductCategoryItem({
    super.key,
    required super.productCategory
  });
}