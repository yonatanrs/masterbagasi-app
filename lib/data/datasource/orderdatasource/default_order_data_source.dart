import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/order_entity_mapping_ext.dart';
import 'package:masterbagasi/domain/entity/product/product_appearance_data.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/additionalitem/additional_item.dart';
import '../../../domain/entity/cart/cart.dart';
import '../../../domain/entity/cart/support_cart.dart';
import '../../../domain/entity/order/combined_order.dart';
import '../../../domain/entity/order/create_order_parameter.dart';
import '../../../domain/entity/order/order.dart';
import '../../../domain/entity/order/order_based_id_parameter.dart';
import '../../../domain/entity/order/order_paging_parameter.dart';
import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/option_builder.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'order_data_source.dart';

class DefaultOrderDataSource implements OrderDataSource {
  final Dio dio;

  const DefaultOrderDataSource({
    required this.dio
  });

  @override
  FutureProcessing<Order> createOrder(CreateOrderParameter createOrderParameter) {
    return DioHttpClientProcessing((cancelToken) {
      List<Cart> cartList = createOrderParameter.cartList;
      List<AdditionalItem> additionalItemList = createOrderParameter.additionalItemList;
      List<dynamic> orderList = cartList.map(
        (cart) {
          SupportCart supportCart = cart.supportCart;
          String? productEntryId;
          String? bundlingId;
          if (supportCart is ProductEntryAppearanceData) {
            productEntryId = (supportCart as ProductEntryAppearanceData).productEntryId;
          } else if (supportCart is ProductBundle) {
            bundlingId = supportCart.id;
          }
          return {
            "id": cart.id,
            if (productEntryId.isNotEmptyString) "product_entry_id": productEntryId,
            if (bundlingId.isNotEmptyString) "bundling_id": bundlingId,
            "quantity": cart.quantity,
            "notes": cart.notes.isNotEmptyString ? cart.notes : null
          };
        }
      ).toList();
      List<dynamic> sendToWarehouseList = additionalItemList.map(
        (additionalItem) => {
          "id": additionalItem.id,
          "name" : additionalItem.name,
          "price": additionalItem.estimationPrice,
          "weight": additionalItem.estimationWeight,
          "quantity": additionalItem.quantity
        }
      ).toList();
      dynamic data = {
        if (createOrderParameter.address != null) "user_address_id": createOrderParameter.address!.id,
        if (createOrderParameter.couponId.isNotEmptyString) "coupon_id": createOrderParameter.couponId!,
        "order_list": orderList,
        "order_send_to_warehouse_list": sendToWarehouseList
      };
      return dio.post("/user/order", data: data, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<Order>(onMap: (value) => value.wrapResponse().mapFromResponseToOrder());
    });
  }

  @override
  FutureProcessing<PagingDataResult<CombinedOrder>> orderPaging(OrderPagingParameter orderPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${orderPagingParameter.itemEachPageCount}&page=${orderPagingParameter.page}";
      return dio.get("/user/order$pageParameterPath", queryParameters: orderPagingParameter.status.isEmpty ? {} : {"status": orderPagingParameter.status}, cancelToken: cancelToken)
        .map<PagingDataResult<CombinedOrder>>(onMap: (value) => value.wrapResponse().mapFromResponseToCombinedOrderPagingDataResult());
    });
  }

  @override
  FutureProcessing<Order> orderBasedId(OrderBasedIdParameter orderBasedIdParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/user/order/${orderBasedIdParameter.orderId}", cancelToken: cancelToken)
        .map<Order>(onMap: (value) => value.wrapResponse().mapFromResponseToOrder());
    });
  }
}