import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_detail_other_in_this_category_product_entry_list_parameter.dart';
import '../entity/product/productentry/product_entry.dart';
import '../repository/product_repository.dart';

class GetProductDetailOtherInThisCategoryProductEntryListUseCase {
  final ProductRepository productRepository;

  const GetProductDetailOtherInThisCategoryProductEntryListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductEntry>>> execute(ProductDetailOtherInThisCategoryProductEntryListParameter productDetailOtherInThisCategoryProductEntryListParameter) {
    return productRepository.productDetailOtherInThisCategoryProductEntryList(productDetailOtherInThisCategoryProductEntryListParameter);
  }
}