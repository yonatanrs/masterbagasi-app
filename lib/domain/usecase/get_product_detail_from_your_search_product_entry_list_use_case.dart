import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_detail_from_your_search_product_entry_list_parameter.dart';
import '../entity/product/productentry/product_entry.dart';
import '../repository/product_repository.dart';

class GetProductDetailFromYourSearchProductEntryListUseCase {
  final ProductRepository productRepository;

  const GetProductDetailFromYourSearchProductEntryListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductEntry>>> execute(ProductDetailFromYourSearchProductEntryListParameter productDetailFromYourSearchProductEntryListParameter) {
    return productRepository.productDetailFromYourSearchProductEntryList(productDetailFromYourSearchProductEntryListParameter);
  }
}