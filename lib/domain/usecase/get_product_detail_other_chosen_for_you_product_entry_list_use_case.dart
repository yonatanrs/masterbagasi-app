import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_detail_other_chosen_for_you_product_entry_list_parameter.dart';
import '../entity/product/productentry/product_entry.dart';
import '../repository/product_repository.dart';

class GetProductDetailOtherChosenForYouProductEntryListUseCase {
  final ProductRepository productRepository;

  const GetProductDetailOtherChosenForYouProductEntryListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductEntry>>> execute(ProductDetailOtherChosenForYouProductEntryListParameter productDetailOtherChosenForYouProductEntryListParameter) {
    return productRepository.productDetailOtherChosenForYouProductEntryList(productDetailOtherChosenForYouProductEntryListParameter);
  }
}