import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_with_condition_paging_parameter.dart';
import '../entity/product/productentry/product_entry.dart';
import '../repository/product_repository.dart';

class GetProductEntryWithConditionPagingUseCase {
  final ProductRepository productRepository;

  const GetProductEntryWithConditionPagingUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ProductEntry>>> execute(ProductWithConditionPagingParameter productWithConditionPagingParameter) {
    return productRepository.productWithConditionPaging(productWithConditionPagingParameter);
  }
}