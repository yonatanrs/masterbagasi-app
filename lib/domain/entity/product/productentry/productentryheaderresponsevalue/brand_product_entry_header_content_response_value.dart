import '../../productbrand/product_brand.dart';
import 'product_entry_header_content_response_value.dart';

class BrandProductEntryHeaderContentResponseValue extends ProductEntryHeaderContentResponseValue {
  ProductBrand productBrand;

  BrandProductEntryHeaderContentResponseValue({
    required this.productBrand
  });
}