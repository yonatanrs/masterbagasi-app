import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/product/productbrand/product_brand.dart';
import '../entity/product/productbrand/product_brand_paging_parameter.dart';
import '../repository/product_repository.dart';

class GetProductBrandListUseCase {
  final ProductRepository productRepository;

  const GetProductBrandListUseCase({
    required this.productRepository
  });

  FutureProcessing<LoadDataResult<List<ProductBrand>>> execute() {
    return productRepository.productBrandPaging(
      ProductBrandPagingParameter(page: 1, itemEachPageCount: 10)
    ).map<LoadDataResult<List<ProductBrand>>>(
      onMap: (productBrandPagingDataResult) {
        return productBrandPagingDataResult.map<List<ProductBrand>>(
          (productBrandPaging) => productBrandPaging.itemList
        );
      }
    );
  }
}