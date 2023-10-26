import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productentry/product_entry_header_content_parameter.dart';
import '../entity/product/productentry/product_entry_header_content_response.dart';
import '../repository/product_repository.dart';

class GetProductEntryHeaderContentUseCase {
  final ProductRepository productRepository;

  const GetProductEntryHeaderContentUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<ProductEntryHeaderContentResponse>> execute(ProductEntryHeaderContentParameter productEntryHeaderContentParameter) {
    return productRepository.productEntryHeaderContent(productEntryHeaderContentParameter);
  }
}