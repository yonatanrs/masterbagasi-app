import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../domain/entity/address/address.dart';
import '../domain/entity/cart/cart.dart';
import '../domain/entity/coupon/coupon.dart';
import '../domain/entity/delivery/delivery_review.dart';
import '../domain/entity/news/news.dart';
import '../domain/entity/product/productbrand/product_brand.dart';
import '../domain/entity/product/productbundle/product_bundle.dart';
import '../domain/entity/product/productcategory/product_category.dart';
import '../domain/entity/product/productentry/product_entry.dart';
import '../domain/entity/wishlist/add_wishlist_response.dart';
import '../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import 'carouselbackground/carousel_background.dart';
import 'constant.dart';
import 'controllerstate/listitemcontrollerstate/carousel_list_item_controller_state.dart';
import 'controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import 'entityandlistitemcontrollerstatemediator/horizontal_entity_and_list_item_controller_state_mediator.dart';
import 'injector.dart';
import 'load_data_result.dart';
import 'multi_language_string.dart';
import 'parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/carousel_background_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/cart_delegate_parameterized_entity_and_list_item_controllere_state_mediator_parameter.dart';
import 'parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/cart_refresh_delegate_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/compound_parameterized_entity_and_list_item_controller_state_mediator.dart';
import 'parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/wishlist_delegate_parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';
import 'shimmercarousellistitemgenerator/factory/cart_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/coupon_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/delivery_review_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/news_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_brand_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_bundle_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_category_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/type/cart_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/coupon_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/delivery_review_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/news_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/product_brand_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/product_bundle_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/product_category_shimmer_carousel_list_item_generator_type.dart';
import 'shimmercarousellistitemgenerator/type/product_shimmer_carousel_list_item_generator_type.dart';
import 'typedef.dart';

class OnObserveLoadProductDelegateFactory {
  CarouselParameterizedEntityAndListItemControllerStateMediatorParameter Function(dynamic data)? onInjectCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadProductBrandCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadProductCategoryCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadProductEntryCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadProductBundleCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadDeliveryReviewCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadNewsCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadCouponCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadCartCarouselParameterizedEntity;
  ParameterizedEntityAndListItemControllerStateMediatorParameter Function()? onInjectLoadAddressCarouselParameterizedEntity;

  OnObserveLoadProductDelegate generateOnObserveLoadProductDelegate() {
    return OnObserveLoadProductDelegate(
      onObserveSuccessLoadProductBrandCarousel: (onObserveSuccessLoadProductBrandCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductBrandCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductBrandCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadProductBrandCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadProductBrandCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadProductBrandCarouselParameter.productBrandList.map<ListItemControllerState>(
            (productBrand) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                productBrand, parameter: onInjectLoadProductBrandCarouselParameterizedEntity != null ? onInjectLoadProductBrandCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadProductBrandCarousel: (onObserveLoadingLoadProductBrandCarouselParameter) {
        return ShimmerCarouselListItemControllerState<ProductBrandShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<ProductBrandShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadProductCategoryCarousel: (onObserveSuccessLoadProductCategoryCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductCategoryCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductCategoryCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadProductCategoryCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadProductCategoryCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadProductCategoryCarouselParameter.productCategoryList.map<ListItemControllerState>(
            (productCategory) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                productCategory, parameter: onInjectLoadProductCategoryCarouselParameterizedEntity != null ? onInjectLoadProductCategoryCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadProductCategoryCarousel: (onObserveLoadingLoadProductCategoryCarouselParameter) {
        return ShimmerCarouselListItemControllerState<ProductCategoryShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<ProductCategoryShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadProductEntryCarousel: (onObserveSuccessLoadProductEntryCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductEntryCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductEntryCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadProductEntryCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadProductEntryCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadProductEntryCarouselParameter.productEntryList.map<ListItemControllerState>(
            (productEntry) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                productEntry, parameter: onInjectLoadProductEntryCarouselParameterizedEntity != null ? onInjectLoadProductEntryCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadProductEntryCarousel: (onObserveLoadingLoadProductEntryCarouselParameter) {
        return ShimmerCarouselListItemControllerState<ProductShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<ProductShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadProductBundleCarousel: (onObserveSuccessLoadProductBundleCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductBundleCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadProductBundleCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadProductBundleCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadProductBundleCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadProductBundleCarouselParameter.productBundleList.map<ListItemControllerState>(
            (productBundle) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                productBundle, parameter: onInjectLoadProductBundleCarouselParameterizedEntity != null ? onInjectLoadProductBundleCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadProductBundleCarousel: (onObserveLoadingLoadProductBundleCarouselParameter) {
        return ShimmerCarouselListItemControllerState<ProductBundleShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<ProductBundleShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadDeliveryReviewCarousel: (onObserveSuccessLoadDeliveryReviewCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadDeliveryReviewCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadDeliveryReviewCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadDeliveryReviewCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadDeliveryReviewCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadDeliveryReviewCarouselParameter.deliveryReviewList.map<ListItemControllerState>(
            (deliveryReview) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                deliveryReview, parameter: onInjectLoadDeliveryReviewCarouselParameterizedEntity != null ? onInjectLoadDeliveryReviewCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadDeliveryReviewCarousel: (onObserveLoadingLoadDeliveryReviewCarouselParameter) {
        return ShimmerCarouselListItemControllerState<DeliveryReviewShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<DeliveryReviewShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadNewsCarousel: (onObserveSuccessLoadNewsCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadNewsCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadNewsCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadNewsCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadNewsCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadNewsCarouselParameter.newsList.map<ListItemControllerState>(
            (news) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                news, parameter: onInjectLoadNewsCarouselParameterizedEntity != null ? onInjectLoadNewsCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadNewsCarousel: (onObserveLoadingLoadNewsCarouselParameter) {
        return ShimmerCarouselListItemControllerState<NewsShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<NewsShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadCouponCarousel: (onObserveSuccessLoadCouponCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadCouponCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadCouponCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadCouponCarouselParameter.title.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          description: onObserveSuccessLoadCouponCarouselParameter.description.toEmptyStringNonNull,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadCouponCarouselParameter.couponList.map<ListItemControllerState>(
            (coupon) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                coupon, parameter: onInjectLoadCouponCarouselParameterizedEntity != null ? onInjectLoadCouponCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadCouponCarousel: (onObserveLoadingLoadCouponCarouselParameter) {
        return ShimmerCarouselListItemControllerState<CouponShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<CouponShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadCartCarousel: (onObserveSuccessLoadCartCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadCartCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadCartCarouselParameter.data).carouselBackground;
        }
        var parameter = onInjectLoadCartCarouselParameterizedEntity != null ? onInjectLoadCartCarouselParameterizedEntity!() : null;
        List<ParameterizedEntityAndListItemControllerStateMediatorParameter> parameterList = [];
        if (parameter is CompoundParameterizedEntityAndListItemControllerStateMediatorParameter) {
          parameterList = parameter.parameterizedEntityAndListItemControllerStateMediatorParameterList;
        } else if (parameter != null) {
          parameterList.add(parameter);
        }
        CartRefreshDelegateParameterizedEntityAndListItemControllerStateMediatorParameter? cartRefreshDelegate;
        for (var iteratedParameter in parameterList) {
          if (iteratedParameter is CartRefreshDelegateParameterizedEntityAndListItemControllerStateMediatorParameter) {
            cartRefreshDelegate = iteratedParameter;
          }
        }
        if (cartRefreshDelegate != null) {
          RepeatableDynamicItemCarouselAdditionalParameter? repeatableDynamicItemCarouselAdditionalParameter = onObserveSuccessLoadCartCarouselParameter.repeatableDynamicItemCarouselAdditionalParameter;
          if (repeatableDynamicItemCarouselAdditionalParameter != null) {
            cartRefreshDelegate.onGetRepeatableDynamicItemCarouselAdditionalParameter(repeatableDynamicItemCarouselAdditionalParameter);
          }
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadCartCarouselParameter.title.toEmptyStringNonNull,
          description: onObserveSuccessLoadCartCarouselParameter.description.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadCartCarouselParameter.cartList.map<ListItemControllerState>(
            (cart) {
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                cart, parameter: onInjectLoadCartCarouselParameterizedEntity != null ? onInjectLoadCartCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadCartCarousel: (onObserveLoadingLoadCartCarouselParameter) {
        return ShimmerCarouselListItemControllerState<CartShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<CartShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
      onObserveSuccessLoadAddressCarousel: (onObserveSuccessLoadAddressCarouselParameter) {
        TitleInterceptor? titleInterceptor;
        CarouselBackground? carouselBackground;
        if (onInjectCarouselParameterizedEntity != null) {
          titleInterceptor = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadAddressCarouselParameter.data).titleInterceptor;
          carouselBackground = onInjectCarouselParameterizedEntity!(onObserveSuccessLoadAddressCarouselParameter.data).carouselBackground;
        }
        return CarouselListItemControllerState(
          title: onObserveSuccessLoadAddressCarouselParameter.title.toEmptyStringNonNull,
          description: onObserveSuccessLoadAddressCarouselParameter.description.toEmptyStringNonNull,
          titleInterceptor: titleInterceptor,
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          itemListItemControllerState: onObserveSuccessLoadAddressCarouselParameter.addressList.map<ListItemControllerState>(
            (address) {
              AddressCarouselCompoundParameterized addressCarouselCompoundParameterized = AddressCarouselCompoundParameterized(
                onObserveSuccessLoadAddressCarouselParameter: onObserveSuccessLoadAddressCarouselParameter,
                address: address
              );
              return Injector.locator<HorizontalParameterizedEntityAndListItemControllerStateMediator>().mapWithParameter(
                addressCarouselCompoundParameterized, parameter: onInjectLoadAddressCarouselParameterizedEntity != null ? onInjectLoadAddressCarouselParameterizedEntity!() : null
              );
            }
          ).toList(),
          carouselBackground: carouselBackground
        );
      },
      onObserveLoadingLoadAddressCarousel: (onObserveLoadingLoadAddressCarouselParameter) {
        return ShimmerCarouselListItemControllerState<CartShimmerCarouselListItemGeneratorType>(
          padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem),
          showTitleShimmer: true,
          showDescriptionShimmer: false,
          showItemShimmer: true,
          shimmerCarouselListItemGenerator: Injector.locator<CartShimmerCarouselListItemGeneratorFactory>().getShimmerCarouselListItemGeneratorType()
        );
      },
    );
  }
}

class OnObserveLoadProductDelegate {
  ListItemControllerState Function(OnObserveSuccessLoadProductBrandCarouselParameter) onObserveSuccessLoadProductBrandCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadProductBrandCarouselParameter) onObserveLoadingLoadProductBrandCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadProductCategoryCarouselParameter) onObserveSuccessLoadProductCategoryCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadProductCategoryCarouselParameter) onObserveLoadingLoadProductCategoryCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadProductEntryCarouselParameter) onObserveSuccessLoadProductEntryCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadProductEntryCarouselParameter) onObserveLoadingLoadProductEntryCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadProductBundleCarouselParameter) onObserveSuccessLoadProductBundleCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadProductBundleCarouselParameter) onObserveLoadingLoadProductBundleCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadDeliveryReviewCarouselParameter) onObserveSuccessLoadDeliveryReviewCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadDeliveryReviewCarouselParameter) onObserveLoadingLoadDeliveryReviewCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadNewsCarouselParameter) onObserveSuccessLoadNewsCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadNewsCarouselParameter) onObserveLoadingLoadNewsCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadCouponCarouselParameter) onObserveSuccessLoadCouponCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadCouponCarouselParameter) onObserveLoadingLoadCouponCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadCartCarouselParameter) onObserveSuccessLoadCartCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadCartCarouselParameter) onObserveLoadingLoadCartCarousel;
  ListItemControllerState Function(OnObserveSuccessLoadAddressCarouselParameter) onObserveSuccessLoadAddressCarousel;
  ListItemControllerState Function(OnObserveLoadingLoadAddressCarouselParameter) onObserveLoadingLoadAddressCarousel;

  OnObserveLoadProductDelegate({
    required this.onObserveSuccessLoadProductBrandCarousel,
    required this.onObserveLoadingLoadProductBrandCarousel,
    required this.onObserveSuccessLoadProductCategoryCarousel,
    required this.onObserveLoadingLoadProductCategoryCarousel,
    required this.onObserveSuccessLoadProductEntryCarousel,
    required this.onObserveLoadingLoadProductEntryCarousel,
    required this.onObserveSuccessLoadProductBundleCarousel,
    required this.onObserveLoadingLoadProductBundleCarousel,
    required this.onObserveSuccessLoadDeliveryReviewCarousel,
    required this.onObserveLoadingLoadDeliveryReviewCarousel,
    required this.onObserveSuccessLoadNewsCarousel,
    required this.onObserveLoadingLoadNewsCarousel,
    required this.onObserveSuccessLoadCouponCarousel,
    required this.onObserveLoadingLoadCouponCarousel,
    required this.onObserveSuccessLoadCartCarousel,
    required this.onObserveLoadingLoadCartCarousel,
    required this.onObserveSuccessLoadAddressCarousel,
    required this.onObserveLoadingLoadAddressCarousel
  });
}

class OnObserveSuccessLoadProductBundleCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<ProductBundle> productBundleList;
  dynamic data;

  OnObserveSuccessLoadProductBundleCarouselParameter({
    required this.title,
    required this.description,
    required this.productBundleList,
    this.data
  });
}

class OnObserveLoadingLoadProductBundleCarouselParameter {}

class OnObserveSuccessLoadProductBrandCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<ProductBrand> productBrandList;
  dynamic data;

  OnObserveSuccessLoadProductBrandCarouselParameter({
    required this.title,
    required this.description,
    required this.productBrandList,
    this.data
  });
}

class OnObserveLoadingLoadProductBrandCarouselParameter {}

class OnObserveSuccessLoadProductCategoryCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<ProductCategory> productCategoryList;
  dynamic data;

  OnObserveSuccessLoadProductCategoryCarouselParameter({
    required this.title,
    required this.description,
    required this.productCategoryList,
    this.data
  });
}

class OnObserveLoadingLoadProductCategoryCarouselParameter {}

class OnObserveSuccessLoadProductEntryCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<ProductEntry> productEntryList;
  dynamic data;

  OnObserveSuccessLoadProductEntryCarouselParameter({
    required this.title,
    required this.description,
    required this.productEntryList,
    this.data
  });
}

class OnObserveLoadingLoadProductEntryCarouselParameter {}

class OnObserveSuccessLoadDeliveryReviewCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<DeliveryReview> deliveryReviewList;
  dynamic data;

  OnObserveSuccessLoadDeliveryReviewCarouselParameter({
    required this.title,
    required this.description,
    required this.deliveryReviewList,
    this.data
  });
}

class OnObserveLoadingLoadDeliveryReviewCarouselParameter {}

class OnObserveSuccessLoadNewsCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<News> newsList;
  dynamic data;

  OnObserveSuccessLoadNewsCarouselParameter({
    required this.title,
    required this.description,
    required this.newsList,
    this.data
  });
}

class OnObserveLoadingLoadNewsCarouselParameter {}

class OnObserveSuccessLoadCouponCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<Coupon> couponList;
  dynamic data;

  OnObserveSuccessLoadCouponCarouselParameter({
    required this.title,
    required this.description,
    required this.couponList,
    this.data
  });
}

class OnObserveLoadingLoadCouponCarouselParameter {}

class OnObserveSuccessLoadCartCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<Cart> cartList;
  dynamic data;
  RepeatableDynamicItemCarouselAdditionalParameter? repeatableDynamicItemCarouselAdditionalParameter;

  OnObserveSuccessLoadCartCarouselParameter({
    required this.title,
    required this.description,
    required this.cartList,
    this.data,
    this.repeatableDynamicItemCarouselAdditionalParameter
  });
}

class OnObserveLoadingLoadCartCarouselParameter {}

class OnObserveSuccessLoadAddressCarouselParameter {
  MultiLanguageString? title;
  MultiLanguageString? description;
  List<Address> addressList;
  dynamic data;

  OnObserveSuccessLoadAddressCarouselParameter({
    required this.title,
    required this.description,
    required this.addressList,
    this.data
  });
}

class OnObserveLoadingLoadAddressCarouselParameter {}

class AddressCarouselCompoundParameterized {
  OnObserveSuccessLoadAddressCarouselParameter onObserveSuccessLoadAddressCarouselParameter;
  Address address;

  AddressCarouselCompoundParameterized({
    required this.onObserveSuccessLoadAddressCarouselParameter,
    required this.address
  });
}