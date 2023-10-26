import '../../productcategory/product_category.dart';
import 'product_entry_header_content_response_value.dart';

class CategoryProductEntryHeaderContentResponseValue extends ProductEntryHeaderContentResponseValue {
  ProductCategory productCategory;

  CategoryProductEntryHeaderContentResponseValue({
    required this.productCategory
  });
}