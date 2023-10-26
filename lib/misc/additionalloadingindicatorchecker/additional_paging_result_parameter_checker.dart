import '../paging/pagingresult/paging_result_with_parameter.dart';

abstract class AdditionalPagingResultParameterChecker<PageKeyType, ItemType> {
  PagingResultParameter<ItemType>? getAdditionalPagingResultParameter(
    AdditionalPagingResultCheckerParameter<PageKeyType, ItemType> additionalPagingResultCheckerParameter
  );
}

class AdditionalPagingResultCheckerParameter<PageKeyType, ItemType> {
  PageKeyType? page;

  AdditionalPagingResultCheckerParameter({
    required this.page
  });
}