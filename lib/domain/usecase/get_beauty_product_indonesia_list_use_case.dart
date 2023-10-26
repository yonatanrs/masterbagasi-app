import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/product_with_condition_paging_parameter.dart';
import '../entity/product/productentry/product_entry.dart';
import '../repository/product_repository.dart';

class GetBeautyProductIndonesiaListUseCase {
  final ProductRepository productRepository;

  const GetBeautyProductIndonesiaListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductEntry>>> execute() {
    return productRepository.productWithConditionPaging(
      ProductWithConditionPagingParameter(
        page: 1,
        itemEachPageCount: 10,
        withCondition: {
          'category': 'produk-kecantikan-indonesia',
        }
      )
    ).map(
      onMap: (productEntryPagingDataResultLoadDataResult) {
        return productEntryPagingDataResultLoadDataResult.map<List<ProductEntry>>((productEntryPagingDataResult) {
          return productEntryPagingDataResult.itemList;
        });
      }
    );
  }
}