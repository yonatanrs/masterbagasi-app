import '../../../domain/entity/additionalitem/add_additional_item_parameter.dart';
import '../../../domain/entity/additionalitem/add_additional_item_response.dart';
import '../../../domain/entity/additionalitem/additional_item.dart';
import '../../../domain/entity/additionalitem/additional_item_list_parameter.dart';
import '../../../domain/entity/additionalitem/change_additional_item_parameter.dart';
import '../../../domain/entity/additionalitem/change_additional_item_response.dart';
import '../../../domain/entity/additionalitem/remove_additional_item_parameter.dart';
import '../../../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../../../domain/entity/cart/add_host_cart_parameter.dart';
import '../../../domain/entity/cart/add_host_cart_response.dart';
import '../../../domain/entity/cart/add_to_cart_parameter.dart';
import '../../../domain/entity/cart/add_to_cart_response.dart';
import '../../../domain/entity/cart/cart.dart';
import '../../../domain/entity/cart/cart_list_parameter.dart';
import '../../../domain/entity/cart/cart_paging_parameter.dart';
import '../../../domain/entity/cart/cart_summary.dart';
import '../../../domain/entity/cart/cart_summary_parameter.dart';
import '../../../domain/entity/cart/remove_from_cart_parameter.dart';
import '../../../domain/entity/cart/remove_from_cart_response.dart';
import '../../../domain/entity/cart/shared_cart_paging_parameter.dart';
import '../../../domain/entity/cart/take_friend_cart_parameter.dart';
import '../../../domain/entity/cart/take_friend_cart_response.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class CartDataSource {
  FutureProcessing<PagingDataResult<Cart>> cartPaging(CartPagingParameter cartPagingParameter);
  FutureProcessing<List<Cart>> cartList(CartListParameter cartListParameter);
  FutureProcessing<PagingDataResult<Cart>> sharedCartPaging(SharedCartPagingParameter sharedCartPagingParameter);
  FutureProcessing<AddToCartResponse> addToCart(AddToCartParameter addToCartParameter);
  FutureProcessing<RemoveFromCartResponse> removeFromCart(RemoveFromCartParameter removeFromCartParameter);
  FutureProcessing<AddHostCartResponse> addHostCart(AddHostCartParameter addHostCartParameter);
  FutureProcessing<TakeFriendCartResponse> takeFriendCart(TakeFriendCartParameter takeFriendCartParameter);
  FutureProcessing<CartSummary> cartSummary(CartSummaryParameter cartSummaryParameter);
  FutureProcessing<List<AdditionalItem>> additionalItemList(AdditionalItemListParameter additionalItemListParameter);
  FutureProcessing<AddAdditionalItemResponse> addAdditionalItem(AddAdditionalItemParameter addAdditionalItemParameter);
  FutureProcessing<ChangeAdditionalItemResponse> changeAdditionalItem(ChangeAdditionalItemParameter changeAdditionalItemParameter);
  FutureProcessing<RemoveAdditionalItemResponse> removeAdditionalItem(RemoveAdditionalItemParameter removeAdditionalItemParameter);
}