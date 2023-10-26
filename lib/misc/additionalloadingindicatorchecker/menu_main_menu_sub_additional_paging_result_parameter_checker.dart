import 'package:masterbagasi/misc/paging/pagingresult/paging_result_with_parameter.dart';

import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'additional_paging_result_parameter_checker.dart';

class MenuMainMenuSubAdditionalPagingResultParameterChecker extends AdditionalPagingResultParameterChecker<int, ListItemControllerState> {
  @override
  PagingResultParameter<ListItemControllerState>? getAdditionalPagingResultParameter(AdditionalPagingResultCheckerParameter<int, ListItemControllerState> additionalPagingResultCheckerParameter) {
    return null;
  }
}