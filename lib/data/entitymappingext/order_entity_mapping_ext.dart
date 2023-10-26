import 'package:masterbagasi/data/entitymappingext/additional_item_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/address_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/coupon_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/product_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/summary_value_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/user_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../domain/entity/order/combined_order.dart';
import '../../domain/entity/order/order.dart';
import '../../domain/entity/order/order_detail.dart';
import '../../domain/entity/order/order_product.dart';
import '../../domain/entity/order/order_product_detail.dart';
import '../../domain/entity/order/order_product_in_order_shipping.dart';
import '../../domain/entity/order/order_shipping.dart';
import '../../domain/entity/order/order_summary.dart';
import '../../domain/entity/order/support_order_product.dart';
import '../../misc/error/message_error.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension ProductEntityMappingExt on ResponseWrapper {
  List<CombinedOrder> mapFromResponseToCombinedOrderList() {
    return response.map<CombinedOrder>((combinedOrderResponse) => ResponseWrapper(combinedOrderResponse).mapFromResponseToCombinedOrder()).toList();
  }

  PagingDataResult<CombinedOrder> mapFromResponseToCombinedOrderPagingDataResult() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<CombinedOrder>(
        (combinedOrderResponse) => ResponseWrapper(combinedOrderResponse).mapFromResponseToCombinedOrder()
      ).toList()
    );
  }
}

extension OrderDetailEntityMappingExt on ResponseWrapper {
  Order mapFromResponseToOrder() {
    return Order(
      orderSummary: ResponseWrapper(response["detail"]).mapFromResponseToOrderSummary(),
      combinedOrder: ResponseWrapper(response["combined_order"]).mapFromResponseToCombinedOrder(),
    );
  }

  OrderSummary mapFromResponseToOrderSummary() {
    return OrderSummary(
      summaryValue: ResponseWrapper(response["summary"]).mapFromResponseToSummaryValueList(),
      finalSummaryValue: ResponseWrapper(response["final_summary"]).mapFromResponseToSummaryValueList(),
    );
  }

  CombinedOrder mapFromResponseToCombinedOrder() {
    return CombinedOrder(
      id: response["id"],
      userId: response["user_id"],
      orderProductId: response["order_product_id"],
      orderShippingId: response["order_shipping_id"],
      orderCode: response["order_code"],
      couponId: response["coupon_id"],
      picId: response["pic_id"],
      picTakeoverId: response["pic_takeover_id"],
      status: response["status"],
      takeoverAt: response["takeover_at"] != null ? ResponseWrapper(response["takeover_at"]).mapFromResponseToDateTime() : null,
      review: response["review"],
      coupon: response["coupon"] != null ? ResponseWrapper(response["coupon"]).mapFromResponseToCoupon() : null,
      user: ResponseWrapper(response["user"]).mapFromResponseToUser(),
      orderProduct: ResponseWrapper(response["order_product"]).mapFromResponseToOrderProduct(),
      orderShipping: response["order_shipping"] != null ? ResponseWrapper(response["order_shipping"]).mapFromResponseToOrderShipping() : null,
      createdAt: ResponseWrapper(response["created_at"]).mapFromResponseToDateTime()!
    );
  }

  OrderProduct mapFromResponseToOrderProduct() {
    return OrderProduct(
      id: response["id"],
      orderId: response["order_id"],
      userAddressId: response["user_address_id"],
      orderDetail: ResponseWrapper(response["order"]).mapFromResponseToOrderDetail(),
      userAddress: response["user_address"] != null ? ResponseWrapper(response["user_address"]).mapFromResponseToAddress() : null,
      orderProductDetailList: response["order_product_list"].map<OrderProductDetail>(
        (orderProductDetailResponse) => ResponseWrapper(orderProductDetailResponse).mapFromResponseToOrderProductDetail()
      ).toList(),
      additionalItemList: ResponseWrapper(response["order_send_to_warehouse_list"]).mapFromResponseToAdditionalItemList()
    );
  }

  OrderProductInOrderShipping mapFromResponseToOrderProductInOrderShipping() {
    return OrderProductInOrderShipping(
      id: response["id"],
      orderId: response["order_id"],
      userAddressId: response["user_address_id"],
      userAddress: response["user_address"] != null ? ResponseWrapper(response["user_address"]).mapFromResponseToAddress() : null,
      orderProductDetailList: response["order_product_list"].map<OrderProductDetail>(
        (orderProductDetailResponse) => ResponseWrapper(orderProductDetailResponse).mapFromResponseToOrderProductDetail()
      ).toList(),
      additionalItemList: ResponseWrapper(response["order_send_to_warehouse_list"]).mapFromResponseToAdditionalItemList()
    );
  }

  OrderShipping mapFromResponseToOrderShipping() {
    return OrderShipping(
      id: response["id"],
      orderId: response["order_id"],
      orderProductId: response["order_product_id"],
      trackingNumber: response["tracking_number"],
      status: response["status"],
      notes: response["notes"],
      orderDetail: ResponseWrapper(response["order"]).mapFromResponseToOrderDetail(),
      orderProductInOrderShipping: ResponseWrapper(response["order_product"]).mapFromResponseToOrderProductInOrderShipping()
    );
  }

  OrderDetail mapFromResponseToOrderDetail() {
    return OrderDetail(
      id: response["id"],
      status: response["status"],
      paymentType: response["payment_type"],
      totalPrice: response["total_price"],
      snapToken: (response["snap_token"] as String?).toEmptyStringNonNull,
      realTotalPrice: response["real_total_price"]
    );
  }

  OrderProductDetail mapFromResponseToOrderProductDetail() {
    return OrderProductDetail(
      id: response["id"],
      orderProductId: response["order_product_id"],
      quantity: response["quantity"],
      notes: response["notes"],
      supportOrderProduct: ResponseWrapper(response).mapFromResponseToSupportOrderProduct()
    );
  }

  SupportOrderProduct mapFromResponseToSupportOrderProduct() {
    dynamic productEntry = response["product_entry"];
    dynamic bundling = response["bundling"];
    if (productEntry != null) {
      return ResponseWrapper(productEntry).mapFromResponseToProductEntry();
    } else if (bundling != null) {
      return ResponseWrapper(bundling).mapFromResponseToProductBundle();
    } else {
      throw MessageError(message: "Support order product not suitable");
    }
  }
}