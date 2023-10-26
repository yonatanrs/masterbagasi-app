import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbundle/product_bundle.dart';
import '../entity/product/productbundle/product_bundle_paging_parameter.dart';
import '../repository/product_repository.dart';

class GetProductBundlePagingUseCase {
  final ProductRepository productRepository;

  const GetProductBundlePagingUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ProductBundle>>> execute(ProductBundlePagingParameter productBundlePagingParameter) {
    return productRepository.productBundlePaging(productBundlePagingParameter);
  }
}