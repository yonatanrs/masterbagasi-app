import '../../../misc/load_data_result.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import 'product_paging_parameter.dart';
import 'productentry/product_entry.dart';

class ProductWithConditionPagingParameter extends ProductPagingParameter {
  Map<String, dynamic> withCondition;
  PagingDataResult<ProductEntry> Function(PagingDataResult<ProductEntry>)? onInterceptProductPagingDataResult;

  ProductWithConditionPagingParameter({
    required super.page,
    super.itemEachPageCount = 15,
    this.withCondition = const {},
    this.onInterceptProductPagingDataResult
  });
}