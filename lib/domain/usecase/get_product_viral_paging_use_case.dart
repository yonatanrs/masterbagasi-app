import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productentry/product_entry.dart';
import '../entity/product/product_with_condition_paging_parameter.dart';
import '../repository/product_repository.dart';

class GetProductViralPagingUseCase {
  final ProductRepository productRepository;

  const GetProductViralPagingUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<ProductEntry>>> execute(ProductWithConditionPagingParameter productWithConditionPagingParameter) {
    return productRepository.productWithConditionPaging(
      ProductWithConditionPagingParameter(
        page: productWithConditionPagingParameter.page,
        itemEachPageCount: productWithConditionPagingParameter.itemEachPageCount,
        withCondition: {
          'type': 'viral'
        }
      )
    );
  }
}