import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/address/address.dart';
import '../../domain/entity/order/combined_order.dart';
import '../../domain/entity/order/order.dart';
import '../../domain/entity/order/order_product_detail.dart';
import '../../presentation/widget/address/horizontal_address_item.dart';
import '../../presentation/widget/address/vertical_address_item.dart';
import '../../presentation/widget/colorful_chip.dart';
import '../../presentation/widget/order/order_product_detail_item.dart';
import '../../presentation/widget/summary_widget.dart';
import '../constant.dart';
import '../controllerstate/listitemcontrollerstate/builder_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/cart_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/orderlistitemcontrollerstate/order_detail_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/spacing_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/widget_substitution_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../multi_language_string.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class OrderDetailItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  OrderDetailItemTypeListSubInterceptor({
    required this.padding,
    required this.itemSpacing,
    required this.listItemControllerStateItemTypeInterceptorChecker
  });

  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is OrderDetailContainerListItemControllerState) {
      List<ListItemControllerState> newListItemControllerState = [];
      newListItemControllerState.add(SpacingListItemControllerState());
      _interceptForBasicOrderInformation(i, oldItemType, oldItemTypeList, newListItemControllerState);
      newListItemControllerState.add(SpacingListItemControllerState());
      _interceptForTransactionOrderInformation(i, oldItemType, oldItemTypeList, newListItemControllerState);
      newListItemControllerState.add(SpacingListItemControllerState());
      _interceptForTransactionOrderSummaryInformation(i, oldItemType, oldItemTypeList, newListItemControllerState);
      newItemTypeList.addAll(newListItemControllerState);
      return true;
    }
    return false;
  }

  void _interceptForBasicOrderInformation(
    int i,
    OrderDetailContainerListItemControllerState orderDetailContainerListItemControllerState,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newListItemControllerState
  ) {
    Order order = orderDetailContainerListItemControllerState.order;
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
    ListItemControllerState transactionStatusListItemControllerState = TitleAndDescriptionListItemControllerState(
      title: "Transaction Status".tr,
      description: "test",
      titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
        titleAndDescriptionWidgetList[titleAndDescriptionWidgetList.length - 2] = const SizedBox(height: 5);
        titleAndDescriptionWidgetList[titleAndDescriptionWidgetList.length - 1] = ColorfulChip(
          text: order.combinedOrder.status,
          color: Colors.grey.shade300
        );
        return titleAndDescriptionWidget;
      },
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem)
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(transactionStatusListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(VirtualSpacingListItemControllerState(height: 20));
    ListItemControllerState orderCodeListItemControllerState = TitleAndDescriptionListItemControllerState(
      title: "Order Code".tr,
      description: order.combinedOrder.orderCode,
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
      verticalSpace: 5
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(orderCodeListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(VirtualSpacingListItemControllerState(height: 20));
    ListItemControllerState paymentTypeListItemControllerState = TitleAndDescriptionListItemControllerState(
      title: "Address".tr,
      description: order.combinedOrder.orderProduct.userAddress?.address,
      titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
        Address? userAddress = order.combinedOrder.orderProduct.userAddress;
        titleAndDescriptionWidgetList[titleAndDescriptionWidgetList.length - 2] = const SizedBox(height: 5);
        titleAndDescriptionWidgetList[titleAndDescriptionWidgetList.length - 1] = userAddress != null ? SizedBox(
          width: double.infinity,
          child: VerticalAddressItem(
            address: userAddress,
            canBeModified: false,
          ),
        ) : Text("No address".tr);
        return titleAndDescriptionWidget;
      },
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
      verticalSpace: 5
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(paymentTypeListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
  }

  void _interceptForTransactionOrderInformation(
    int i,
    OrderDetailContainerListItemControllerState orderDetailContainerListItemControllerState,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newListItemControllerState
  ) {
    CombinedOrder order = orderDetailContainerListItemControllerState.order.combinedOrder;
    List<OrderProductDetail> orderProductDetailList = order.orderProduct.orderProductDetailList;
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
    ListItemControllerState paymentTypeListItemControllerState = TitleAndDescriptionListItemControllerState(
      title: "Order List".tr,
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem)
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(paymentTypeListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );

    ListItemControllerState orderListItemControllerState = PaddingContainerListItemControllerState(
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
      paddingChildListItemControllerState: BuilderListItemControllerState(
        buildListItemControllerState: () {
          if (orderProductDetailList.isEmpty) {
            return WidgetSubstitutionListItemControllerState(
              widgetSubstitution: (context, index) => Text(
                MultiLanguageString({
                  Constant.textEnUsLanguageKey: "No product.",
                  Constant.textInIdLanguageKey: "Tidak ada produk.",
                }).toEmptyStringNonNull
              )
            );
          }
          return CompoundListItemControllerState(
            listItemControllerState: orderProductDetailList.mapIndexed<ListItemControllerState>(
              (index, orderProductDetail) => CompoundListItemControllerState(
                listItemControllerState: [
                  if (index > 0) VirtualSpacingListItemControllerState(height: 10),
                  WidgetSubstitutionListItemControllerState(
                    widgetSubstitution: (context, index) => OrderProductDetailItem(
                      orderProductDetail: orderProductDetail
                    )
                  )
                ]
              )
            ).toList()
          );
        }
      )
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(orderListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
  }

  void _interceptForTransactionOrderSummaryInformation(
    int i,
    OrderDetailContainerListItemControllerState orderDetailContainerListItemControllerState,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newListItemControllerState
  ) {
    Order order = orderDetailContainerListItemControllerState.order;
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
    ListItemControllerState paymentTypeListItemControllerState = TitleAndDescriptionListItemControllerState(
      title: "Order Summary".tr,
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem)
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(paymentTypeListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
    ListItemControllerState orderSummaryDetailTypeListItemControllerState = PaddingContainerListItemControllerState(
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
      paddingChildListItemControllerState: WidgetSubstitutionListItemControllerState(
        widgetSubstitution: (BuildContext context, int index) => SummaryWidget(baseSummary: order.orderSummary)
      )
    );
    listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
      i, ListItemControllerStateWrapper(orderSummaryDetailTypeListItemControllerState), oldItemTypeList, newListItemControllerState
    );
    newListItemControllerState.add(
      VirtualSpacingListItemControllerState(height: padding())
    );
  }
}