import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../domain/entity/additionalitem/add_additional_item_parameter.dart';
import '../domain/entity/additionalitem/add_additional_item_response.dart';
import '../domain/entity/additionalitem/additional_item.dart';
import '../domain/entity/additionalitem/additional_item_list_parameter.dart';
import '../domain/entity/additionalitem/change_additional_item_parameter.dart';
import '../domain/entity/additionalitem/change_additional_item_response.dart';
import '../domain/entity/additionalitem/remove_additional_item_parameter.dart';
import '../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../domain/entity/address/address.dart';
import '../domain/entity/address/current_selected_address_parameter.dart';
import '../domain/entity/address/current_selected_address_response.dart';
import '../domain/entity/cart/cart.dart';
import '../domain/entity/cart/cart_paging_parameter.dart';
import '../domain/entity/cart/cart_summary.dart';
import '../domain/entity/cart/cart_summary_parameter.dart';
import '../domain/entity/coupon/coupon.dart';
import '../domain/entity/coupon/coupon_detail_parameter.dart';
import '../domain/entity/order/create_order_parameter.dart';
import '../domain/entity/order/order.dart';
import '../domain/usecase/add_additional_item_use_case.dart';
import '../domain/usecase/change_additional_item_use_case.dart';
import '../domain/usecase/create_order_use_case.dart';
import '../domain/usecase/get_additional_item_use_case.dart';
import '../domain/usecase/get_cart_summary_use_case.dart';
import '../domain/usecase/get_coupon_detail_use_case.dart';
import '../domain/usecase/get_current_selected_address_use_case.dart';
import '../domain/usecase/get_my_cart_use_case.dart';
import '../domain/usecase/remove_additional_item_use_case.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import '../misc/typedef.dart';
import 'base_getx_controller.dart';

typedef _OnDeliveryBack = void Function();
typedef _OnGetCouponId = String? Function();
typedef _OnGetCoupon = Coupon? Function();
typedef _OnGetCartList = List<Cart> Function();
typedef _OnGetAdditionalList = List<AdditionalItem> Function();
typedef _OnShowDeliveryRequestProcessLoadingCallback = Future<void> Function();
typedef _OnDeliveryRequestProcessSuccessCallback = Future<void> Function(Order);
typedef _OnShowDeliveryRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef _OnShowCartSummaryProcessCallback = Future<void> Function(LoadDataResult<CartSummary>);

class DeliveryController extends BaseGetxController {
  final GetMyCartUseCase getMyCartUseCase;
  final GetCartSummaryUseCase getCartSummaryUseCase;
  final GetAdditionalItemUseCase getAdditionalItemUseCase;
  final AddAdditionalItemUseCase addAdditionalItemUseCase;
  final ChangeAdditionalItemUseCase changeAdditionalItemUseCase;
  final RemoveAdditionalItemUseCase removeAdditionalItemUseCase;
  final GetCurrentSelectedAddressUseCase getCurrentSelectedAddressUseCase;
  final GetCouponDetailUseCase getCouponDetailUseCase;
  final CreateOrderUseCase createOrderUseCase;
  bool _hasGetCartSummary = false;

  DeliveryDelegate? _deliveryDelegate;

  DeliveryController(
    super.controllerManager,
    this.getMyCartUseCase,
    this.getCurrentSelectedAddressUseCase,
    this.getCartSummaryUseCase,
    this.getAdditionalItemUseCase,
    this.addAdditionalItemUseCase,
    this.changeAdditionalItemUseCase,
    this.removeAdditionalItemUseCase,
    this.getCouponDetailUseCase,
    this.createOrderUseCase
  );

  Future<LoadDataResult<List<AdditionalItem>>> getAdditionalItem(AdditionalItemListParameter additionalItemListParameter) {
    return getAdditionalItemUseCase.execute(additionalItemListParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("get-additional-item").value
    );
  }

  Future<LoadDataResult<AddAdditionalItemResponse>> addAdditionalItem(AddAdditionalItemParameter addAdditionalItemParameter) {
    return addAdditionalItemUseCase.execute(addAdditionalItemParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("add-additional-item").value
    );
  }

  Future<LoadDataResult<ChangeAdditionalItemResponse>> changeAdditionalItem(ChangeAdditionalItemParameter changeAdditionalItemParameter) {
    return changeAdditionalItemUseCase.execute(changeAdditionalItemParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("change-additional-item").value
    );
  }
  Future<LoadDataResult<RemoveAdditionalItemResponse>> removeAdditionalItem(RemoveAdditionalItemParameter removeAdditionalItemParameter) {
    return removeAdditionalItemUseCase.execute(removeAdditionalItemParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("remove-additional-item").value
    );
  }

  Future<LoadDataResult<PagingDataResult<Cart>>> getDeliveryCartPaging(CartPagingParameter cartPagingParameter) {
    return getMyCartUseCase.execute(cartPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("cart-paging").value
    );
  }

  Future<LoadDataResult<Address>> getCurrentSelectedAddress(CurrentSelectedAddressParameter currentSelectedAddressParameter) {
    return getCurrentSelectedAddressUseCase.execute(currentSelectedAddressParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("current-selected-address").value
    ).map<Address>((currentSelectedAddressResponse) {
      return currentSelectedAddressResponse.address;
    });
  }

  Future<LoadDataResult<Coupon>> getCouponDetail(CouponDetailParameter couponDetailParameter) {
    return getCouponDetailUseCase.execute(couponDetailParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("coupon-detail").value
    );
  }

  DeliveryController setDeliveryDelegate(DeliveryDelegate deliveryDelegate) {
    _deliveryDelegate = deliveryDelegate;
    return this;
  }

  void createOrder() async {
    if (_deliveryDelegate != null) {
      _deliveryDelegate!.onUnfocusAllWidget();
      _deliveryDelegate!.onShowDeliveryRequestProcessLoadingCallback();
      LoadDataResult<CurrentSelectedAddressResponse> currentAddressLoadDataResult = await getCurrentSelectedAddressUseCase.execute(
        CurrentSelectedAddressParameter()
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart("address").value
      );
      if (currentAddressLoadDataResult.isSuccess) {
        LoadDataResult<Order> createOrderLoadDataResult = await createOrderUseCase.execute(
          CreateOrderParameter(
            cartList: _deliveryDelegate!.onGetCartList(),
            additionalItemList: _deliveryDelegate!.onGetAdditionalList(),
            couponId: _deliveryDelegate!.onGetCouponId(),
            address: currentAddressLoadDataResult.resultIfSuccess!.address
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('order').value
        );
        _deliveryDelegate!.onDeliveryBack();
        if (createOrderLoadDataResult.isSuccess) {
          _deliveryDelegate!.onDeliveryRequestProcessSuccessCallback(createOrderLoadDataResult.resultIfSuccess!);
        } else {
          _deliveryDelegate!.onShowDeliveryRequestProcessFailedCallback(createOrderLoadDataResult.resultIfFailed);
        }
      } else {
        _deliveryDelegate!.onShowDeliveryRequestProcessFailedCallback(currentAddressLoadDataResult.resultIfFailed);
      }
    }
  }

  void getCartSummary() async {
    if (_deliveryDelegate != null) {
      _deliveryDelegate!.onShowCartSummaryProcessCallback(IsLoadingLoadDataResult<CartSummary>());
      LoadDataResult<CurrentSelectedAddressResponse> currentAddressLoadDataResult = await getCurrentSelectedAddressUseCase.execute(
        CurrentSelectedAddressParameter()
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart("address-for-cart-summary").value
      );
      if (currentAddressLoadDataResult.isFailedBecauseCancellation) {
        return;
      }
      if (currentAddressLoadDataResult.isSuccess) {
        LoadDataResult<CartSummary> cartSummaryLoadDataResult = await getCartSummaryUseCase.execute(
          CartSummaryParameter(
            cartList: _deliveryDelegate!.onGetCartList(),
            additionalItemList: _deliveryDelegate!.onGetAdditionalList(),
            couponId: _deliveryDelegate!.onGetCouponId(),
            address: currentAddressLoadDataResult.resultIfSuccess!.address
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("cart-summary").value
        );
        _deliveryDelegate!.onShowCartSummaryProcessCallback(cartSummaryLoadDataResult);
      } else {
        _deliveryDelegate!.onShowCartSummaryProcessCallback(
          currentAddressLoadDataResult.map<CartSummary>((test) => throw UnimplementedError())
        );
      }
    }
  }
}

class DeliveryDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnDeliveryBack onDeliveryBack;
  _OnShowDeliveryRequestProcessLoadingCallback onShowDeliveryRequestProcessLoadingCallback;
  _OnDeliveryRequestProcessSuccessCallback onDeliveryRequestProcessSuccessCallback;
  _OnShowDeliveryRequestProcessFailedCallback onShowDeliveryRequestProcessFailedCallback;
  _OnShowCartSummaryProcessCallback onShowCartSummaryProcessCallback;
  _OnGetCouponId onGetCouponId;
  _OnGetCartList onGetCartList;
  _OnGetAdditionalList onGetAdditionalList;

  DeliveryDelegate({
    required this.onUnfocusAllWidget,
    required this.onDeliveryBack,
    required this.onShowDeliveryRequestProcessLoadingCallback,
    required this.onDeliveryRequestProcessSuccessCallback,
    required this.onShowDeliveryRequestProcessFailedCallback,
    required this.onShowCartSummaryProcessCallback,
    required this.onGetCouponId,
    required this.onGetCartList,
    required this.onGetAdditionalList
  });
}