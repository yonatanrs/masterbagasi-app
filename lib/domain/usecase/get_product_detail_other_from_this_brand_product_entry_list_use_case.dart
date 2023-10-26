import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_detail_other_from_this_brand_product_entry_list_parameter.dart';
import '../entity/product/productentry/product_entry.dart';
import '../repository/product_repository.dart';

class GetProductDetailOtherFromThisBrandProductEntryListUseCase {
  final ProductRepository productRepository;

  const GetProductDetailOtherFromThisBrandProductEntryListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductEntry>>> execute(ProductDetailOtherFromThisBrandProductEntryListParameter productDetailOtherFromThisBrandProductEntryListParameter) {
    return productRepository.productDetailOtherFromThisBrandProductEntryList(productDetailOtherFromThisBrandProductEntryListParameter);
  }
}