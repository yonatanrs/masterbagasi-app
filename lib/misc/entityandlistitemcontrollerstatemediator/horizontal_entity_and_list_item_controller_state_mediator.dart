import 'package:masterbagasi/presentation/widget/product/product_item.dart';

import '../../domain/entity/address/address.dart';
import '../../domain/entity/cart/cart.dart';
import '../../domain/entity/delivery/delivery_review.dart';
import '../../domain/entity/news/news.dart';
import '../../domain/entity/product/product_appearance_data.dart';
import '../../domain/entity/product/productbrand/product_brand.dart';
import '../../domain/entity/product/productbundle/product_bundle.dart';
import '../../domain/entity/product/productcategory/product_category.dart';
import '../../presentation/widget/address/address_item.dart';
import '../../presentation/widget/productbundle/product_bundle_item.dart';
import '../controllerstate/listitemcontrollerstate/addresslistitemcontrollerstate/horizontal_address_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/shortcartlistitemcontrollerstate/horizontal_short_cart_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/horizontal_delivery_review_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/newslistitemcontrollerstate/horizontal_news_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/circleproductbrandlistitemcontrollerstate/horizontal_circle_product_brand_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/horizontal_product_bundle_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productcategorylistitemcontrollerstate/circleproductcategorylistitemcontrollerstate/horizontal_circle_product_category_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/horizontal_product_list_item_controller_state.dart';
import '../error/message_error.dart';
import '../on_observe_load_product_delegate.dart';
import '../parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/address_delegate_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/cart_delegate_parameterized_entity_and_list_item_controllere_state_mediator_parameter.dart';
import '../parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/compound_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/wishlist_delegate_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'parameterized_entity_and_list_item_controller_state_mediator.dart';

class HorizontalParameterizedEntityAndListItemControllerStateMediator extends ParameterizedEntityAndListItemControllerStateMediator {
  @override
  ListItemControllerState mapWithParameter(entity, {parameter}) {
    if (entity is DeliveryReview) {
      return HorizontalDeliveryReviewListItemControllerState(deliveryReview: entity);
    } else if (entity is News) {
      return HorizontalNewsListItemControllerState(news: entity);
    } else if (entity is ProductAppearanceData) {
      return _checkingForProduct(entity, parameter: parameter);
    } else if (entity is ProductCategory) {
      return HorizontalCircleProductCategoryListItemControllerState(productCategory: entity);
    } else if (entity is ProductBrand) {
      return HorizontalCircleProductBrandListItemControllerState(productBrand: entity);
    } else if (entity is ProductBundle) {
      return _checkingForProductBundle(entity, parameter: parameter);
    } else if (entity is Cart) {
      return HorizontalShortCartListItemControllerState(cart: entity);
    } else if (entity is AddressCarouselCompoundParameterized) {
      return _checkingForAddress(entity, parameter: parameter);
    } else {
      return NoContentListItemControllerState();
    }
  }

  void _separateWishlistAndCartDelegateParameter(
    void Function(
      SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter separatedParameter,
    ) afterSeparateParameter,
    {parameter}
  ) {
    List<ParameterizedEntityAndListItemControllerStateMediatorParameter> parameterList = [];
    if (parameter is CompoundParameterizedEntityAndListItemControllerStateMediatorParameter) {
      parameterList = parameter.parameterizedEntityAndListItemControllerStateMediatorParameterList;
    } else if (
      parameter is WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter
      || parameter is CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter
    ) {
      parameterList.add(parameter);
    }
    if (parameterList.isNotEmpty) {
      WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? wishlistDelegateParameter;
      CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? cartDelegateParameter;
      AddressDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? addressDelegateParameter;
      for (var iteratedParameter in parameterList) {
        if (iteratedParameter is WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter) {
          wishlistDelegateParameter = iteratedParameter;
        } else if (iteratedParameter is CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter) {
          cartDelegateParameter = iteratedParameter;
        } else if (iteratedParameter is AddressDelegateParameterizedEntityAndListItemControllerStateMediatorParameter) {
          addressDelegateParameter = iteratedParameter;
        }
      }
      afterSeparateParameter(
        SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter(
          wishlistDelegateParameter: wishlistDelegateParameter,
          cartDelegateParameter: cartDelegateParameter,
          addressDelegateParameter: addressDelegateParameter
        )
      );
    } else {
      throw MessageError(title: "Wishlist and cart delegate is required.");
    }
  }

  ListItemControllerState _checkingForProduct(ProductAppearanceData productAppearanceData, {parameter}) {
    late SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter separatedParameter;
    _separateWishlistAndCartDelegateParameter(
      (separatedParameterOutput) => separatedParameter = separatedParameterOutput,
      parameter: parameter
    );
    OnAddWishlistWithProductAppearanceData? onAddToWishlist;
    OnRemoveWishlistWithProductAppearanceData? onRemoveFromWishlist;
    OnAddCartWithProductAppearanceData? onAddCart;
    OnRemoveCartWithProductAppearanceData? onRemoveCart;
    if (separatedParameter.wishlistDelegateParameter != null) {
      if (separatedParameter.wishlistDelegateParameter!.onAddToWishlist != null) {
        onAddToWishlist = (productAppearanceData) => separatedParameter.wishlistDelegateParameter!.onAddToWishlist!(productAppearanceData);
      }
      if (separatedParameter.wishlistDelegateParameter!.onRemoveFromWishlist != null) {
        onRemoveFromWishlist = (productAppearanceData) => separatedParameter.wishlistDelegateParameter!.onRemoveFromWishlist!(productAppearanceData);
      }
    }
    if (separatedParameter.cartDelegateParameter != null) {
      if (separatedParameter.cartDelegateParameter!.onAddCart != null) {
        onAddCart = (productAppearanceData) => separatedParameter.cartDelegateParameter!.onAddCart!(productAppearanceData);
      }
      if (separatedParameter.cartDelegateParameter!.onRemoveCart != null) {
        onRemoveCart = (productAppearanceData) => separatedParameter.cartDelegateParameter!.onRemoveCart!(productAppearanceData);
      }
    }
    return HorizontalProductListItemControllerState(
      productAppearanceData: productAppearanceData,
      onAddWishlist: onAddToWishlist,
      onRemoveWishlist: onRemoveFromWishlist,
      onAddCart: onAddCart,
      onRemoveCart: onRemoveCart
    );
  }

  ListItemControllerState _checkingForProductBundle(ProductBundle productBundle, {parameter}) {
    late SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter separatedParameter;
    _separateWishlistAndCartDelegateParameter(
      (separatedParameterOutput) => separatedParameter = separatedParameterOutput,
      parameter: parameter
    );
    OnAddWishlistWithProductBundle? onAddToWishlist;
    OnRemoveWishlistWithProductBundle? onRemoveFromWishlist;
    OnAddCartWithProductBundle? onAddCart;
    OnRemoveCartWithProductBundle? onRemoveCart;
    if (separatedParameter.wishlistDelegateParameter != null) {
      if (separatedParameter.wishlistDelegateParameter!.onAddToWishlist != null) {
        onAddToWishlist = (productBundle) => separatedParameter.wishlistDelegateParameter!.onAddToWishlist!(productBundle);
      }
      if (separatedParameter.wishlistDelegateParameter!.onRemoveFromWishlist != null) {
        onRemoveFromWishlist = (productBundle) => separatedParameter.wishlistDelegateParameter!.onRemoveFromWishlist!(productBundle);
      }
    }
    if (separatedParameter.cartDelegateParameter != null) {
      if (separatedParameter.cartDelegateParameter!.onAddCart != null) {
        onAddCart = (productBundle) => separatedParameter.cartDelegateParameter!.onAddCart!(productBundle);
      }
      if (separatedParameter.cartDelegateParameter!.onRemoveCart != null) {
        onRemoveCart = (productBundle) => separatedParameter.cartDelegateParameter!.onRemoveCart!(productBundle);
      }
    }
    return HorizontalProductBundleListItemControllerState(
      productBundle: productBundle,
      onAddWishlist: onAddToWishlist,
      onRemoveWishlist: onRemoveFromWishlist,
      onAddCart: onAddCart,
      onRemoveCart: onRemoveCart
    );
  }

  ListItemControllerState _checkingForAddress(AddressCarouselCompoundParameterized addressCarouselCompoundParameterized, {parameter}) {
    late SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter separatedParameter;
    _separateWishlistAndCartDelegateParameter(
      (separatedParameterOutput) => separatedParameter = separatedParameterOutput,
      parameter: parameter
    );
    void Function(Address)? onSelectAddress;
    if (separatedParameter.addressDelegateParameter != null) {
      if (separatedParameter.addressDelegateParameter!.onSelectAddressFromDelegate != null) {
        onSelectAddress = (addressOutput) {
          separatedParameter.addressDelegateParameter!.onSelectAddressFromDelegate!(
            addressOutput, () {
              List<Address> addressList = addressCarouselCompoundParameterized.onObserveSuccessLoadAddressCarouselParameter.addressList;
              for (Address iteratedAddress in addressList) {
                iteratedAddress.isPrimary = 0;
              }
              addressOutput.isPrimary = 1;
            }
          );
        };
      }
    }
    return HorizontalAddressListItemControllerState(
      address: addressCarouselCompoundParameterized.address,
      onSelectAddress: onSelectAddress,
    );
  }
}

class SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter {
  WishlistDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? wishlistDelegateParameter;
  CartDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? cartDelegateParameter;
  AddressDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? addressDelegateParameter;

  SeparatedParameterizedEntityAndListItemControllerStateMediatorParameter({
    required this.wishlistDelegateParameter,
    required this.cartDelegateParameter,
    required this.addressDelegateParameter
  });
}