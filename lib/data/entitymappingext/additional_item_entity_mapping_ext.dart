import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/additionalitem/add_additional_item_response.dart';
import '../../domain/entity/additionalitem/additional_item.dart';
import '../../domain/entity/additionalitem/change_additional_item_response.dart';
import '../../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension AdditionalItemEntityMappingExt on ResponseWrapper {
  List<AdditionalItem> mapFromResponseToAdditionalItemList() {
    return response.map<AdditionalItem>((additionalItemResponse) => ResponseWrapper(additionalItemResponse).mapFromResponseToAdditionalItem()).toList();
  }

  PagingDataResult<AdditionalItem> mapFromResponseToAdditionalItemPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<AdditionalItem>(
        (additionalItemResponse) => ResponseWrapper(additionalItemResponse).mapFromResponseToAdditionalItem()
      ).toList()
    );
  }
}

extension AdditionalItemDetailEntityMappingExt on ResponseWrapper {
  AdditionalItem mapFromResponseToAdditionalItem() {
    return AdditionalItem(
      id: response["id"],
      name: response["name"],
      estimationWeight: ResponseWrapper(response["weight"]).mapFromResponseToDouble()!,
      estimationPrice: ResponseWrapper(response["price"]).mapFromResponseToDouble()!,
      quantity: response["quantity"],
    );
  }
}

extension AddAdditionalItemResponseDetailEntityMappingExt on ResponseWrapper {
  AddAdditionalItemResponse mapFromResponseToAddAdditionalItemResponse() {
    return AddAdditionalItemResponse();
  }
}

extension ChangeAdditionalItemResponseDetailEntityMappingExt on ResponseWrapper {
  ChangeAdditionalItemResponse mapFromResponseToChangeAdditionalItemResponse() {
    return ChangeAdditionalItemResponse();
  }
}

extension RemoveAdditionalItemResponseDetailEntityMappingExt on ResponseWrapper {
  RemoveAdditionalItemResponse mapFromResponseToRemoveAdditionalItemResponse() {
    return RemoveAdditionalItemResponse();
  }
}