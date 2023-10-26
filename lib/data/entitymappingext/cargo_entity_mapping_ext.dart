import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/cargo/cargo.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension CartEntityMappingExt on ResponseWrapper {
  List<Cargo> mapFromResponseToCargoList() {
    return response.map<Cargo>((cartResponse) => ResponseWrapper(cartResponse).mapFromResponseToCargo()).toList();
  }

  PagingDataResult<Cargo> mapFromResponseToCargoPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<Cargo>(
        (cargoResponse) => ResponseWrapper(cargoResponse).mapFromResponseToCargo()
      ).toList()
    );
  }
}

extension CartDetailEntityMappingExt on ResponseWrapper {
  Cargo mapFromResponseToCargo() {
    return Cargo(
      id: response["id"],
      zoneId: response["zone_id"],
      minWeight: ResponseWrapper(response["min_weight"]).mapFromResponseToDouble()!,
      maxWeight: ResponseWrapper(response["max_weight"]).mapFromResponseToDouble()!,
      price: response["price"],
      priceTogether: response["price_together"],
    );
  }
}