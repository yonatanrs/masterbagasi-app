import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/additional_item_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/cart_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/dummy/cartdummy/cart_dummy.dart';
import '../../../domain/entity/additionalitem/add_additional_item_parameter.dart';
import '../../../domain/entity/additionalitem/add_additional_item_response.dart';
import '../../../domain/entity/additionalitem/additional_item.dart';
import '../../../domain/entity/additionalitem/additional_item_list_parameter.dart';
import '../../../domain/entity/additionalitem/change_additional_item.dart';
import '../../../domain/entity/additionalitem/change_additional_item_parameter.dart';
import '../../../domain/entity/additionalitem/change_additional_item_response.dart';
import '../../../domain/entity/additionalitem/remove_additional_item_parameter.dart';
import '../../../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../../../domain/entity/cart/add_host_cart_parameter.dart';
import '../../../domain/entity/cart/add_host_cart_response.dart';
import '../../../domain/entity/cart/add_to_cart_parameter.dart';
import '../../../domain/entity/cart/add_to_cart_response.dart';
import '../../../domain/entity/cart/cart_list_parameter.dart';
import '../../../domain/entity/cart/cart_summary.dart';
import '../../../domain/entity/cart/cart_summary_parameter.dart';
import '../../../domain/entity/cart/remove_from_cart_parameter.dart';
import '../../../domain/entity/cart/remove_from_cart_response.dart';
import '../../../domain/entity/cart/shared_cart_paging_parameter.dart';
import '../../../domain/entity/cart/support_cart.dart';
import '../../../domain/entity/cart/take_friend_cart_parameter.dart';
import '../../../domain/entity/cart/take_friend_cart_response.dart';
import '../../../domain/entity/product/product_appearance_data.dart';
import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../domain/entity/product/productentry/product_entry.dart';
import '../../../domain/entity/summaryvalue/summary_value.dart';
import '../../../misc/option_builder.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/dummy_future_processing.dart';
import 'cart_data_source.dart';

import '../../../domain/entity/cart/cart.dart';
import '../../../domain/entity/cart/cart_paging_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

class DefaultCartDataSource implements CartDataSource {
  final Dio dio;
  final CartDummy cartDummy;

  const DefaultCartDataSource({
    required this.dio,
    required this.cartDummy
  });

  @override
  FutureProcessing<PagingDataResult<Cart>> cartPaging(CartPagingParameter cartPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${cartPagingParameter.itemEachPageCount}&page=${cartPagingParameter.page}";
      return dio.get("/user/cart$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<Cart>>(onMap: (value) => value.wrapResponse().mapFromResponseToCartPaging());
    });
  }

  @override
  FutureProcessing<List<Cart>> cartList(CartListParameter cartListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/user/cart", cancelToken: cancelToken)
        .map<List<Cart>>(onMap: (value) => value.wrapResponse().mapFromResponseToCartList());
    });
  }

  @override
  FutureProcessing<PagingDataResult<Cart>> sharedCartPaging(SharedCartPagingParameter sharedCartPagingParameter) {
    return DummyFutureProcessing((parameter) async {
      await Future.delayed(const Duration(seconds: 1));
      return PagingDataResult<Cart>(
        itemList: [
          cartDummy.generateDefaultDummy(),
          cartDummy.generateDefaultDummy(),
          cartDummy.generateDefaultDummy(),
          cartDummy.generateDefaultDummy(),
          cartDummy.generateDefaultDummy(),
          cartDummy.generateDefaultDummy()
        ],
        totalItem: 1,
        totalPage: 1,
        page: 1
      );
    });
  }

  @override
  FutureProcessing<AddToCartResponse> addToCart(AddToCartParameter addToCartParameter) {
    return DioHttpClientProcessing((cancelToken) async {
      SupportCart supportCart = addToCartParameter.supportCart;
      FormData formData = FormData.fromMap(
        <String, dynamic> {
          if (supportCart is ProductEntryAppearanceData) "product_entry_id": (supportCart as ProductEntryAppearanceData).productEntryId,
          if (supportCart is ProductBundle) "bundling_id": supportCart.id,
          "quantity": addToCartParameter.quantity
        }
      );
      return dio.post("/user/cart", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<AddToCartResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAddToCartResponse());
    });
  }

  @override
  FutureProcessing<RemoveFromCartResponse> removeFromCart(RemoveFromCartParameter removeFromCartParameter) {
    return DioHttpClientProcessing((cancelToken) async {
      return dio.delete("/user/cart/${removeFromCartParameter.cart.id}", cancelToken: cancelToken)
        .map<RemoveFromCartResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToRemoveFromCartResponse());
    });
  }

  @override
  FutureProcessing<AddHostCartResponse> addHostCart(AddHostCartParameter addHostCartParameter) {
    return DummyFutureProcessing((parameter) async {
      await Future.delayed(const Duration(seconds: 1));
      return AddHostCartResponse();
    });
  }

  @override
  FutureProcessing<TakeFriendCartResponse> takeFriendCart(TakeFriendCartParameter takeFriendCartParameter) {
    return DummyFutureProcessing((parameter) async {
      await Future.delayed(const Duration(seconds: 1));
      return TakeFriendCartResponse();
    });
  }

  @override
  FutureProcessing<CartSummary> cartSummary(CartSummaryParameter cartSummaryParameter) {
    List<Cart> cartList = cartSummaryParameter.cartList;
    List<AdditionalItem> additionalItemList = cartSummaryParameter.additionalItemList;
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
      if (cartSummaryParameter.address != null) "user_address_id": cartSummaryParameter.address!.id,
      if (cartSummaryParameter.couponId.isNotEmptyString) "coupon_id": cartSummaryParameter.couponId!,
      "order_list": orderList,
      "order_send_to_warehouse_list": sendToWarehouseList
    };
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/user/order/summary", data: data, cancelToken: cancelToken)
        .map<CartSummary>(onMap: (value) => value.wrapResponse().mapFromResponseToCartSummary());
    });
  }

  @override
  FutureProcessing<List<AdditionalItem>> additionalItemList(AdditionalItemListParameter additionalItemListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("user/send-wh", cancelToken: cancelToken)
        .map<List<AdditionalItem>>(onMap: (value) => value.wrapResponse().mapFromResponseToAdditionalItemList());
    });
  }

  @override
  FutureProcessing<AddAdditionalItemResponse> addAdditionalItem(AddAdditionalItemParameter addAdditionalItemParameter) {
    return DioHttpClientProcessing((cancelToken) {
      AdditionalItem additionalItem = addAdditionalItemParameter.additionalItem;
      dynamic data = {
        "send_to_warehouse_list": [
          {
            "name" : additionalItem.name,
            "price": additionalItem.estimationPrice,
            "weight": additionalItem.estimationWeight,
            "quantity": additionalItem.quantity
          }
        ]
      };
      return dio.post("user/send-wh", data: data, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<AddAdditionalItemResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAddAdditionalItemResponse());
    });
  }

  @override
  FutureProcessing<ChangeAdditionalItemResponse> changeAdditionalItem(ChangeAdditionalItemParameter changeAdditionalItemParameter) {
    return DioHttpClientProcessing((cancelToken) {
      ChangeAdditionalItem changeAdditionalItem = changeAdditionalItemParameter.changeAdditionalItem;
      FormData data = FormData.fromMap({
        if (changeAdditionalItem.quantity != null) "quantity": changeAdditionalItem.quantity,
        if (changeAdditionalItem.name.isNotEmptyString) "name": changeAdditionalItem.name,
        if (changeAdditionalItem.estimationPrice != null) "price": changeAdditionalItem.estimationPrice,
        if (changeAdditionalItem.estimationWeight != null) "weight": changeAdditionalItem.estimationWeight,
      });
      return dio.put("user/send-wh/${changeAdditionalItemParameter.changeAdditionalItem.id}", data: data, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<ChangeAdditionalItemResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToChangeAdditionalItemResponse());
    });
  }

  @override
  FutureProcessing<RemoveAdditionalItemResponse> removeAdditionalItem(RemoveAdditionalItemParameter removeAdditionalItemParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.delete("user/send-wh/${removeAdditionalItemParameter.additionalItemId}", cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<RemoveAdditionalItemResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToRemoveAdditionalItemResponse());
    });
  }
}