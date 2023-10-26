import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../controller/deliveryreviewcontroller/deliveryreviewsubpagecontroller/history_delivery_review_sub_controller.dart';
import '../controller/deliveryreviewcontroller/deliveryreviewsubpagecontroller/waiting_to_be_reviewed_delivery_review_sub_controller.dart';
import '../controller/mainmenucontroller/mainmenusubpagecontroller/explore_nusantara_main_menu_sub_controller.dart';
import '../controller/mainmenucontroller/mainmenusubpagecontroller/feed_main_menu_sub_controller.dart';
import '../controller/mainmenucontroller/mainmenusubpagecontroller/home_main_menu_sub_controller.dart';
import '../controller/mainmenucontroller/mainmenusubpagecontroller/menu_main_menu_sub_controller.dart';
import '../controller/mainmenucontroller/mainmenusubpagecontroller/wishlist_main_menu_sub_controller.dart';
import '../data/datasource/addressdatasource/address_data_source.dart';
import '../data/datasource/addressdatasource/default_address_data_source.dart';
import '../data/datasource/bannerdatasource/banner_data_source.dart';
import '../data/datasource/bannerdatasource/default_banner_data_source.dart';
import '../data/datasource/cargodatasource/cargo_data_source.dart';
import '../data/datasource/cargodatasource/default_cargo_data_source.dart';
import '../data/datasource/cartdatasource/cart_data_source.dart';
import '../data/datasource/cartdatasource/default_cart_data_source.dart';
import '../data/datasource/chatdatasource/chat_data_source.dart';
import '../data/datasource/chatdatasource/default_chat_data_source.dart';
import '../data/datasource/coupondatasource/coupon_data_source.dart';
import '../data/datasource/coupondatasource/default_coupon_data_source.dart';
import '../data/datasource/faqdatasource/default_faq_data_source.dart';
import '../data/datasource/faqdatasource/faq_data_source.dart';
import '../data/datasource/feeddatasource/default_feed_data_source.dart';
import '../data/datasource/feeddatasource/feed_data_source.dart';
import '../data/datasource/mapdatasource/default_map_data_source.dart';
import '../data/datasource/mapdatasource/map_data_source.dart';
import '../data/datasource/notificationdatasource/default_notification_data_source.dart';
import '../data/datasource/notificationdatasource/notification_data_source.dart';
import '../data/datasource/orderdatasource/default_order_data_source.dart';
import '../data/datasource/orderdatasource/order_data_source.dart';
import '../data/datasource/productdatasource/default_product_data_source.dart';
import '../data/datasource/productdatasource/product_data_source.dart';
import '../data/datasource/productdiscussiondatasource/default_product_discussion_data_source.dart';
import '../data/datasource/productdiscussiondatasource/product_discussion_data_source.dart';
import '../data/datasource/userdatasource/default_user_data_source.dart';
import '../data/datasource/userdatasource/user_data_source.dart';
import '../data/repository/default_address_repository.dart';
import '../data/repository/default_banner_repository.dart';
import '../data/repository/default_cargo_repository.dart';
import '../data/repository/default_cart_repository.dart';
import '../data/repository/default_chat_repository.dart';
import '../data/repository/default_coupon_repository.dart';
import '../data/repository/default_faq_repository.dart';
import '../data/repository/default_feed_repository.dart';
import '../data/repository/default_map_repository.dart';
import '../data/repository/default_notification_repository.dart';
import '../data/repository/default_order_repository.dart';
import '../data/repository/default_product_discussion_repository.dart';
import '../data/repository/default_product_repository.dart';
import '../data/repository/default_user_repository.dart';
import '../domain/dummy/addressdummy/address_dummy.dart';
import '../domain/dummy/addressdummy/address_user_dummy.dart';
import '../domain/dummy/addressdummy/country_dummy.dart';
import '../domain/dummy/addressdummy/zone_dummy.dart';
import '../domain/dummy/cartdummy/cart_dummy.dart';
import '../domain/dummy/coupondummy/coupon_dummy.dart';
import '../domain/dummy/deliveryreviewdummy/delivery_review_dummy.dart';
import '../domain/dummy/newsdummy/news_dummy.dart';
import '../domain/dummy/productdummy/product_brand_dummy.dart';
import '../domain/dummy/productdummy/product_bundle_dummy.dart';
import '../domain/dummy/productdummy/product_category_dummy.dart';
import '../domain/dummy/productdummy/product_certification_dummy.dart';
import '../domain/dummy/productdummy/product_dummy.dart';
import '../domain/dummy/productdummy/product_entry_dummy.dart';
import '../domain/dummy/productdummy/product_variant_dummy.dart';
import '../domain/dummy/provincedummy/province_dummy.dart';
import '../domain/dummy/userdummy/user_dummy.dart';
import '../domain/repository/address_repository.dart';
import '../domain/repository/banner_repository.dart';
import '../domain/repository/cargo_repository.dart';
import '../domain/repository/cart_repository.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/coupon_repository.dart';
import '../domain/repository/faq_repository.dart';
import '../domain/repository/feed_repository.dart';
import '../domain/repository/map_repository.dart';
import '../domain/repository/notification_repository.dart';
import '../domain/repository/order_repository.dart';
import '../domain/repository/product_discussion_repository.dart';
import '../domain/repository/product_repository.dart';
import '../domain/repository/user_repository.dart';
import '../domain/usecase/add_additional_item_use_case.dart';
import '../domain/usecase/add_address_use_case.dart';
import '../domain/usecase/add_host_cart_use_case.dart';
import '../domain/usecase/add_to_cart_use_case.dart';
import '../domain/usecase/add_to_favorite_product_brand_use_case.dart';
import '../domain/usecase/add_wishlist_use_case.dart';
import '../domain/usecase/answer_help_conversation_use_case.dart';
import '../domain/usecase/answer_order_conversation_use_case.dart';
import '../domain/usecase/answer_product_conversation_use_case.dart';
import '../domain/usecase/change_additional_item_use_case.dart';
import '../domain/usecase/change_address_use_case.dart';
import '../domain/usecase/check_rates_for_various_countries_use_case.dart';
import '../domain/usecase/create_help_conversation_use_case.dart';
import '../domain/usecase/create_order_conversation_use_case.dart';
import '../domain/usecase/create_order_use_case.dart';
import '../domain/usecase/create_product_conversation_use_case.dart';
import '../domain/usecase/get_additional_item_use_case.dart';
import '../domain/usecase/get_address_based_id_use_case.dart';
import '../domain/usecase/get_address_list_use_case.dart';
import '../domain/usecase/get_address_paging_use_case.dart';
import '../domain/usecase/get_beauty_product_indonesia_list_use_case.dart';
import '../domain/usecase/get_bestseller_in_masterbagasi_list_use_case.dart';
import '../domain/usecase/get_cart_summary_use_case.dart';
import '../domain/usecase/get_check_your_contribution_delivery_review_detail_use_case.dart';
import '../domain/usecase/get_coffee_and_tea_origin_indonesia_list_use_case.dart';
import '../domain/usecase/get_country_delivery_review_use_case.dart';
import '../domain/usecase/get_country_list_use_case.dart';
import '../domain/usecase/get_country_paging_use_case.dart';
import '../domain/usecase/get_coupon_detail_use_case.dart';
import '../domain/usecase/get_coupon_list_use_case.dart';
import '../domain/usecase/get_coupon_paging_use_case.dart';
import '../domain/usecase/get_current_selected_address_use_case.dart';
import '../domain/usecase/get_delivery_review_use_case.dart';
import '../domain/usecase/get_faq_list_use_case.dart';
import '../domain/usecase/get_fashion_product_indonesia_list_use_case.dart';
import '../domain/usecase/get_favorite_product_brand_use_case.dart';
import '../domain/usecase/get_handycrafts_contents_banner_use_case.dart';
import '../domain/usecase/get_help_message_by_conversation_use_case.dart';
import '../domain/usecase/get_help_message_by_user_use_case.dart';
import '../domain/usecase/get_history_delivery_review_paging_use_case.dart';
import '../domain/usecase/get_homepage_contents_banner_use_case.dart';
import '../domain/usecase/get_kitchen_contents_banner_use_case.dart';
import '../domain/usecase/get_my_cart_use_case.dart';
import '../domain/usecase/get_news_use_case.dart';
import '../domain/usecase/get_notification_by_user_paging_use_case.dart';
import '../domain/usecase/get_order_based_id_use_case.dart';
import '../domain/usecase/get_order_message_by_conversation_use_case.dart';
import '../domain/usecase/get_order_message_by_user_use_case.dart';
import '../domain/usecase/get_order_paging_use_case.dart';
import '../domain/usecase/get_product_brand_detail_use_case.dart';
import '../domain/usecase/get_product_brand_paging_use_case.dart';
import '../domain/usecase/get_product_brand_use_case.dart';
import '../domain/usecase/get_product_bundle_detail_use_case.dart';
import '../domain/usecase/get_product_bundle_highlight_use_case.dart';
import '../domain/usecase/get_product_bundle_list_use_case.dart';
import '../domain/usecase/get_product_bundle_paging_use_case.dart';
import '../domain/usecase/get_product_category_detail_use_case.dart';
import '../domain/usecase/get_product_category_list_use_case.dart';
import '../domain/usecase/get_product_detail_from_your_search_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_chosen_for_you_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_from_this_brand_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_in_this_category_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_interested_product_brand_list_use_case.dart';
import '../domain/usecase/get_product_detail_use_case.dart';
import '../domain/usecase/get_product_discussion_dialog_paging_use_case.dart';
import '../domain/usecase/get_product_discussion_paging_use_case.dart';
import '../domain/usecase/get_product_entry_header_content_use_case.dart';
import '../domain/usecase/get_product_entry_with_condition_paging_use_case.dart';
import '../domain/usecase/get_product_list_use_case.dart';
import '../domain/usecase/get_product_message_by_conversation_use_case.dart';
import '../domain/usecase/get_product_message_by_product_use_case.dart';
import '../domain/usecase/get_product_message_by_user_use_case.dart';
import '../domain/usecase/get_product_viral_list_use_case.dart';
import '../domain/usecase/get_product_viral_paging_use_case.dart';
import '../domain/usecase/get_province_map_use_case.dart';
import '../domain/usecase/get_shipping_price_contents_banner_use_case.dart';
import '../domain/usecase/get_short_my_cart_use_case.dart';
import '../domain/usecase/get_short_video_use_case.dart';
import '../domain/usecase/get_snack_for_lying_around_list_use_case.dart';
import '../domain/usecase/get_transaction_notification_detail_use_case.dart';
import '../domain/usecase/get_trip_default_video_use_case.dart';
import '../domain/usecase/get_user_use_case.dart';
import '../domain/usecase/get_waiting_to_be_reviewed_delivery_review_paging_use_case.dart';
import '../domain/usecase/get_wishlist_paging_use_case.dart';
import '../domain/usecase/give_review_delivery_review_detail_use_case.dart';
import '../domain/usecase/login_use_case.dart';
import '../domain/usecase/login_with_google_use_case.dart';
import '../domain/usecase/logout_use_case.dart';
import '../domain/usecase/register_use_case.dart';
import '../domain/usecase/register_with_google_use_case.dart';
import '../domain/usecase/remove_additional_item_use_case.dart';
import '../domain/usecase/remove_address_use_case.dart';
import '../domain/usecase/remove_from_cart_use_case.dart';
import '../domain/usecase/remove_from_favorite_product_brand_use_case.dart';
import '../domain/usecase/remove_wishlist_based_product_use_case.dart';
import '../domain/usecase/remove_wishlist_use_case.dart';
import '../domain/usecase/take_friend_cart_use_case.dart';
import '../domain/usecase/update_current_selected_address_use_case.dart';
import '../domain/usecase/update_read_status_help_conversation_use_case.dart';
import '../domain/usecase/update_read_status_order_conversation_use_case.dart';
import '../domain/usecase/update_read_status_product_conversation_use_case.dart';
import 'additionalloadingindicatorchecker/cart_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/coupon_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/feed_sub_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/home_sub_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/menu_main_menu_sub_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/product_brand_detail_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/product_bundle_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/product_bundle_detail_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/product_category_detail_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/product_detail_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/take_friend_cart_additional_paging_result_parameter_checker.dart';
import 'additionalloadingindicatorchecker/wishlist_sub_additional_paging_result_parameter_checker.dart';
import 'controllercontentdelegate/product_brand_favorite_controller_content_delegate.dart';
import 'controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import 'defaultloaddataresultwidget/default_load_data_result_widget.dart';
import 'defaultloaddataresultwidget/main_default_load_data_result_widget.dart';
import 'entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import 'entityandlistitemcontrollerstatemediator/horizontal_entity_and_list_item_controller_state_mediator.dart';
import 'errorprovider/default_error_provider.dart';
import 'errorprovider/error_provider.dart';
import 'http_client.dart';
import 'on_observe_load_product_delegate.dart';
import 'shimmercarousellistitemgenerator/factory/cart_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/coupon_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/delivery_review_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/news_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_brand_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_bundle_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_category_shimmer_carousel_list_item_generator_factory.dart';
import 'shimmercarousellistitemgenerator/factory/product_shimmer_carousel_list_item_generator_factory.dart';

class _Injector {
  final GetIt locator = GetIt.instance;

  void init() {
    // Controller Injection Factory
    locator.registerLazySingleton<HomeMainMenuSubControllerInjectionFactory>(
      () => HomeMainMenuSubControllerInjectionFactory(
        getProductViralListUseCase: locator(),
        getProductCategoryListUseCase: locator(),
        getProductBrandListUseCase: locator(),
        getProductBundleListUseCase: locator(),
        getProductBundleHighlightUseCase: locator(),
        getSnackForLyingAroundListUseCase: locator(),
        getBestsellerInMasterbagasiListUseCase: locator(),
        getCoffeeAndTeaOriginIndonesiaListUseCase: locator(),
        getBeautyProductIndonesiaListUseCase: locator(),
        getFashionProductIndonesiaListUseCase: locator(),
        getHandycraftsContentsBannerUseCase: locator(),
        getKitchenContentsBannerUseCase: locator(),
        addWishlistUseCase: locator(),
        getCurrentSelectedAddressUseCase: locator(),
        getHomepageContentsBannerUseCase: locator(),
        getShippingPriceContentsBannerUseCase: locator(),
        wishlistAndCartControllerContentDelegate: locator()
      )
    );
    locator.registerLazySingleton<FeedMainMenuSubControllerInjectionFactory>(
      () => FeedMainMenuSubControllerInjectionFactory(
        getShortVideoUseCase: locator(),
        getDeliveryReviewUseCase: locator(),
        getNewsUseCase: locator(),
        getTripDefaultVideoUseCase: locator()
      )
    );
    locator.registerLazySingleton<ExploreNusantaraMainMenuSubControllerInjectionFactory>(
      () => ExploreNusantaraMainMenuSubControllerInjectionFactory(
        getProvinceMapUseCase: locator()
      )
    );
    locator.registerLazySingleton<WishlistMainMenuSubControllerInjectionFactory>(
      () => WishlistMainMenuSubControllerInjectionFactory(
        getWishlistPagingUseCase: locator(),
        addToCartUseCase: locator(),
        removeWishlistUseCase: locator(),
        wishlistAndCartControllerContentDelegate: locator()
      )
    );
    locator.registerLazySingleton<MenuMainMenuSubControllerInjectionFactory>(
      () => MenuMainMenuSubControllerInjectionFactory(
        getUserUseCase: locator(),
        getShortMyCartUseCase: locator(),
        logoutUseCase: locator()
      )
    );
    locator.registerLazySingleton<WaitingToBeReviewedDeliveryReviewSubControllerInjectionFactory>(
      () => WaitingToBeReviewedDeliveryReviewSubControllerInjectionFactory(
        getWaitingToBeReviewedDeliveryReviewPagingUseCase: locator(),
        getUserUseCase: locator()
      )
    );
    locator.registerLazySingleton<HistoryDeliveryReviewSubControllerInjectionFactory>(
      () => HistoryDeliveryReviewSubControllerInjectionFactory(
        getHistoryDeliveryReviewPagingUseCase: locator()
      )
    );

    // Error Provider
    locator.registerLazySingleton<ErrorProvider>(() => DefaultErrorProvider());

    // Entity And List Item Controller State Mediator
    locator.registerLazySingleton<HorizontalParameterizedEntityAndListItemControllerStateMediator>(() => HorizontalParameterizedEntityAndListItemControllerStateMediator());
    locator.registerLazySingleton<HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator>(
      () => HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator(
        horizontalEntityAndListItemControllerStateMediator: locator(),
        errorProvider: locator()
      )
    );

    // On Observe Load Product Delegate Factory
    locator.registerFactory<OnObserveLoadProductDelegateFactory>(
      () => OnObserveLoadProductDelegateFactory()
    );

    // Dummy
    locator.registerLazySingleton<ProductDummy>(
      () => ProductDummy(
        productBrandDummy: locator(),
        productCategoryDummy: locator(),
        productCertificationDummy: locator(),
        provinceDummy: locator(),
      )
    );
    locator.registerLazySingleton<ProductEntryDummy>(() => ProductEntryDummy(productDummy: locator()));
    locator.registerLazySingleton<ProvinceDummy>(() => ProvinceDummy());
    locator.registerLazySingleton<ProductBrandDummy>(() => ProductBrandDummy());
    locator.registerLazySingleton<ProductCategoryDummy>(() => ProductCategoryDummy());
    locator.registerLazySingleton<ProductCertificationDummy>(() => ProductCertificationDummy());
    locator.registerLazySingleton<ProductVariantDummy>(() => ProductVariantDummy());
    locator.registerLazySingleton<ProductBundleDummy>(() => ProductBundleDummy());
    locator.registerLazySingleton<DeliveryReviewDummy>(() => DeliveryReviewDummy());
    locator.registerLazySingleton<NewsDummy>(() => NewsDummy());
    locator.registerLazySingleton<CouponDummy>(() => CouponDummy());
    locator.registerLazySingleton<CartDummy>(() => CartDummy(productEntryDummy: locator()));
    locator.registerLazySingleton<AddressDummy>(
      () => AddressDummy(
        countryDummy: locator(),
        addressUserDummy: locator(),
      )
    );
    locator.registerLazySingleton<AddressUserDummy>(() => AddressUserDummy());
    locator.registerLazySingleton<CountryDummy>(() => CountryDummy(zoneDummy: locator()));
    locator.registerLazySingleton<ZoneDummy>(() => ZoneDummy());
    locator.registerLazySingleton<UserDummy>(() => UserDummy());

    // Shimmer Carousel List Item Generator
    locator.registerFactory<ProductShimmerCarouselListItemGeneratorFactory>(
      () => ProductShimmerCarouselListItemGeneratorFactory(
        productDummy: locator()
      )
    );
    locator.registerFactory<ProductCategoryShimmerCarouselListItemGeneratorFactory>(
      () => ProductCategoryShimmerCarouselListItemGeneratorFactory(
        productCategoryDummy: locator()
      )
    );
    locator.registerFactory<ProductBundleShimmerCarouselListItemGeneratorFactory>(
      () => ProductBundleShimmerCarouselListItemGeneratorFactory(
        productBundleDummy: locator()
      )
    );
    locator.registerFactory<ProductBrandShimmerCarouselListItemGeneratorFactory>(
      () => ProductBrandShimmerCarouselListItemGeneratorFactory(
        productBrandDummy: locator()
      )
    );
    locator.registerFactory<DeliveryReviewShimmerCarouselListItemGeneratorFactory>(
      () => DeliveryReviewShimmerCarouselListItemGeneratorFactory(
        deliveryReviewDummy: locator()
      )
    );
    locator.registerFactory<NewsShimmerCarouselListItemGeneratorFactory>(
      () => NewsShimmerCarouselListItemGeneratorFactory(
        newsDummy: locator()
      )
    );
    locator.registerFactory<CouponShimmerCarouselListItemGeneratorFactory>(
      () => CouponShimmerCarouselListItemGeneratorFactory(
        couponDummy: locator()
      )
    );
    locator.registerFactory<CartShimmerCarouselListItemGeneratorFactory>(
      () => CartShimmerCarouselListItemGeneratorFactory(
        cartDummy: locator()
      )
    );

    // Additional Paging Result Parameter
    locator.registerFactory<HomeSubAdditionalPagingResultParameterChecker>(
      () => HomeSubAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<ProductDetailAdditionalPagingResultParameterChecker>(
      () => ProductDetailAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<ProductBrandDetailAdditionalPagingResultParameterChecker>(
      () => ProductBrandDetailAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<ProductCategoryDetailAdditionalPagingResultParameterChecker>(
      () => ProductCategoryDetailAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<ProductBundleAdditionalPagingResultParameterChecker>(
      () => ProductBundleAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<ProductBundleDetailAdditionalPagingResultParameterChecker>(
      () => ProductBundleDetailAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<WishlistSubAdditionalPagingResultParameterChecker>(
      () => WishlistSubAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<FeedSubAdditionalPagingResultParameterChecker>(
      () => FeedSubAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<CouponAdditionalPagingResultParameterChecker>(
      () => CouponAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<MenuMainMenuSubAdditionalPagingResultParameterChecker>(
      () => MenuMainMenuSubAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<CartAdditionalPagingResultParameterChecker>(
      () => CartAdditionalPagingResultParameterChecker()
    );
    locator.registerFactory<TakeFriendCartAdditionalPagingResultParameterChecker>(
      () => TakeFriendCartAdditionalPagingResultParameterChecker()
    );

    // Controller Content Delegate
    locator.registerFactory<WishlistAndCartControllerContentDelegate>(
      () => WishlistAndCartControllerContentDelegate(
        addWishlistUseCase: locator(),
        removeWishlistUseCase: locator(),
        addToCartUseCase: locator(),
        removeWishlistBasedProductUseCase: locator()
      )
    );
    locator.registerFactory<ProductBrandFavoriteControllerContentDelegate>(
      () => ProductBrandFavoriteControllerContentDelegate(
        addToFavoriteProductBrandUseCase: locator(),
        removeFromFavoriteProductBrandUseCase: locator()
      )
    );

    // Controller Delegate Factory
    locator.registerLazySingleton<WishlistAndCartDelegateFactory>(
      () => WishlistAndCartDelegateFactory()
    );
    locator.registerLazySingleton<ProductBrandFavoriteDelegateFactory>(
      () => ProductBrandFavoriteDelegateFactory()
    );

    // Default Load Data Result Widget
    locator.registerLazySingleton<DefaultLoadDataResultWidget>(() => MainDefaultLoadDataResultWidget());

    // Use Case
    locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(userRepository: locator()));
    locator.registerLazySingleton<LoginWithGoogleUseCase>(() => LoginWithGoogleUseCase(userRepository: locator()));
    locator.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(userRepository: locator()));
    locator.registerLazySingleton<RegisterWithGoogleUseCase>(() => RegisterWithGoogleUseCase(userRepository: locator()));
    locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(userRepository: locator()));
    locator.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(userRepository: locator()));
    locator.registerLazySingleton<GetProductBrandListUseCase>(() => GetProductBrandListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductBrandPagingUseCase>(() => GetProductBrandPagingUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetFavoriteProductBrandPagingUseCase>(() => GetFavoriteProductBrandPagingUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductBrandDetailUseCase>(() => GetProductBrandDetailUseCase(productRepository: locator()));
    locator.registerLazySingleton<AddToFavoriteProductBrandUseCase>(() => AddToFavoriteProductBrandUseCase(productRepository: locator()));
    locator.registerLazySingleton<RemoveFromFavoriteProductBrandUseCase>(() => RemoveFromFavoriteProductBrandUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductListUseCase>(() => GetProductListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductViralListUseCase>(() => GetProductViralListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductViralPagingUseCase>(() => GetProductViralPagingUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductEntryWithConditionPagingUseCase>(() => GetProductEntryWithConditionPagingUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductEntryHeaderContentUseCase>(() => GetProductEntryHeaderContentUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDetailUseCase>(() => GetProductDetailUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDetailOtherChosenForYouProductEntryListUseCase>(() => GetProductDetailOtherChosenForYouProductEntryListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDetailOtherFromThisBrandProductEntryListUseCase>(() => GetProductDetailOtherFromThisBrandProductEntryListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDetailOtherInThisCategoryProductEntryListUseCase>(() => GetProductDetailOtherInThisCategoryProductEntryListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDetailFromYourSearchProductEntryListUseCase>(() => GetProductDetailFromYourSearchProductEntryListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDetailOtherInterestedProductBrandListUseCase>(() => GetProductDetailOtherInterestedProductBrandListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductCategoryListUseCase>(() => GetProductCategoryListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductCategoryDetailUseCase>(() => GetProductCategoryDetailUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductBundleListUseCase>(() => GetProductBundleListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductBundlePagingUseCase>(() => GetProductBundlePagingUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductBundleHighlightUseCase>(() => GetProductBundleHighlightUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductBundleDetailUseCase>(() => GetProductBundleDetailUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetProductDiscussionPagingUseCase>(() => GetProductDiscussionPagingUseCase(productDiscussionRepository: locator()));
    locator.registerLazySingleton<GetProductDiscussionDialogPagingUseCase>(() => GetProductDiscussionDialogPagingUseCase(productDiscussionRepository: locator()));
    locator.registerLazySingleton<GetWishlistPagingUseCase>(() => GetWishlistPagingUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetSnackForLyingAroundListUseCase>(() => GetSnackForLyingAroundListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetBestsellerInMasterbagasiListUseCase>(() => GetBestsellerInMasterbagasiListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetCoffeeAndTeaOriginIndonesiaListUseCase>(() => GetCoffeeAndTeaOriginIndonesiaListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetBeautyProductIndonesiaListUseCase>(() => GetBeautyProductIndonesiaListUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetFashionProductIndonesiaListUseCase>(() => GetFashionProductIndonesiaListUseCase(productRepository: locator()));
    locator.registerLazySingleton<AddWishlistUseCase>(() => AddWishlistUseCase(productRepository: locator()));
    locator.registerLazySingleton<RemoveWishlistUseCase>(() => RemoveWishlistUseCase(productRepository: locator()));
    locator.registerLazySingleton<RemoveWishlistBasedProductUseCase>(() => RemoveWishlistBasedProductUseCase(productRepository: locator()));
    locator.registerLazySingleton<GetShortVideoUseCase>(() => GetShortVideoUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetDeliveryReviewUseCase>(() => GetDeliveryReviewUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetWaitingToBeReviewedDeliveryReviewPagingUseCase>(() => GetWaitingToBeReviewedDeliveryReviewPagingUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetHistoryDeliveryReviewPagingUseCase>(() => GetHistoryDeliveryReviewPagingUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetCheckYourContributionDeliveryReviewDetailUseCase>(() => GetCheckYourContributionDeliveryReviewDetailUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GiveReviewDeliveryReviewDetailUseCase>(() => GiveReviewDeliveryReviewDetailUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetCountryDeliveryReviewUseCase>(() => GetCountryDeliveryReviewUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetTripDefaultVideoUseCase>(() => GetTripDefaultVideoUseCase(feedRepository: locator()));
    locator.registerLazySingleton<GetKitchenContentsBannerUseCase>(() => GetKitchenContentsBannerUseCase(bannerRepository: locator()));
    locator.registerLazySingleton<GetHandycraftsContentsBannerUseCase>(() => GetHandycraftsContentsBannerUseCase(bannerRepository: locator()));
    locator.registerLazySingleton<GetHomepageContentsBannerUseCase>(() => GetHomepageContentsBannerUseCase(bannerRepository: locator()));
    locator.registerLazySingleton<GetShippingPriceContentsBannerUseCase>(() => GetShippingPriceContentsBannerUseCase(bannerRepository: locator()));
    locator.registerLazySingleton<GetCouponPagingUseCase>(() => GetCouponPagingUseCase(couponRepository: locator()));
    locator.registerLazySingleton<GetCouponListUseCase>(() => GetCouponListUseCase(couponRepository: locator()));
    locator.registerLazySingleton<GetCouponDetailUseCase>(() => GetCouponDetailUseCase(couponRepository: locator()));
    locator.registerLazySingleton<GetShortMyCartUseCase>(() => GetShortMyCartUseCase(cartRepository: locator()));
    locator.registerLazySingleton<GetMyCartUseCase>(() => GetMyCartUseCase(cartRepository: locator()));
    locator.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase(cartRepository: locator()));
    locator.registerLazySingleton<RemoveFromCartUseCase>(() => RemoveFromCartUseCase(cartRepository: locator()));
    locator.registerLazySingleton<AddHostCartUseCase>(() => AddHostCartUseCase(cartRepository: locator()));
    locator.registerLazySingleton<TakeFriendCartUseCase>(() => TakeFriendCartUseCase(cartRepository: locator()));
    locator.registerLazySingleton<GetCurrentSelectedAddressUseCase>(() => GetCurrentSelectedAddressUseCase(addressRepository: locator()));
    locator.registerLazySingleton<GetAddressBasedIdUseCase>(() => GetAddressBasedIdUseCase(addressRepository: locator()));
    locator.registerLazySingleton<GetAddressListUseCase>(() => GetAddressListUseCase(addressRepository: locator()));
    locator.registerLazySingleton<GetAddressPagingUseCase>(() => GetAddressPagingUseCase(addressRepository: locator()));
    locator.registerLazySingleton<UpdateCurrentSelectedAddressUseCase>(() => UpdateCurrentSelectedAddressUseCase(addressRepository: locator()));
    locator.registerLazySingleton<AddAddressUseCase>(() => AddAddressUseCase(addressRepository: locator()));
    locator.registerLazySingleton<ChangeAddressUseCase>(() => ChangeAddressUseCase(addressRepository: locator()));
    locator.registerLazySingleton<RemoveAddressUseCase>(() => RemoveAddressUseCase(addressRepository: locator()));
    locator.registerLazySingleton<GetCartSummaryUseCase>(() => GetCartSummaryUseCase(cartRepository: locator()));
    locator.registerLazySingleton<GetAdditionalItemUseCase>(() => GetAdditionalItemUseCase(cartRepository: locator()));
    locator.registerLazySingleton<AddAdditionalItemUseCase>(() => AddAdditionalItemUseCase(cartRepository: locator()));
    locator.registerLazySingleton<ChangeAdditionalItemUseCase>(() => ChangeAdditionalItemUseCase(cartRepository: locator()));
    locator.registerLazySingleton<RemoveAdditionalItemUseCase>(() => RemoveAdditionalItemUseCase(cartRepository: locator()));
    locator.registerLazySingleton<GetProvinceMapUseCase>(() => GetProvinceMapUseCase(mapRepository: locator()));
    locator.registerLazySingleton<CreateOrderUseCase>(() => CreateOrderUseCase(orderRepository: locator()));
    locator.registerLazySingleton<GetOrderPagingUseCase>(() => GetOrderPagingUseCase(orderRepository: locator()));
    locator.registerLazySingleton<GetOrderBasedIdUseCase>(() => GetOrderBasedIdUseCase(orderRepository: locator()));
    locator.registerLazySingleton<CheckRatesForVariousCountriesUseCase>(() => CheckRatesForVariousCountriesUseCase(cargoRepository: locator()));
    locator.registerLazySingleton<GetCountryListUseCase>(() => GetCountryListUseCase(addressRepository: locator()));
    locator.registerLazySingleton<GetCountryPagingUseCase>(() => GetCountryPagingUseCase(addressRepository: locator()));
    locator.registerLazySingleton<GetFaqListUseCase>(() => GetFaqListUseCase(faqRepository: locator()));
    locator.registerLazySingleton<AnswerHelpConversationUseCase>(() => AnswerHelpConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<CreateHelpConversationUseCase>(() => CreateHelpConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<UpdateReadStatusHelpConversationUseCase>(() => UpdateReadStatusHelpConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetHelpMessageByUserUseCase>(() => GetHelpMessageByUserUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetHelpMessageByConversationUseCase>(() => GetHelpMessageByConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<AnswerOrderConversationUseCase>(() => AnswerOrderConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<CreateOrderConversationUseCase>(() => CreateOrderConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<UpdateReadStatusOrderConversationUseCase>(() => UpdateReadStatusOrderConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetOrderMessageByUserUseCase>(() => GetOrderMessageByUserUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetOrderMessageByConversationUseCase>(() => GetOrderMessageByConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<AnswerProductConversationUseCase>(() => AnswerProductConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<CreateProductConversationUseCase>(() => CreateProductConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<UpdateReadStatusProductConversationUseCase>(() => UpdateReadStatusProductConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetProductMessageByUserUseCase>(() => GetProductMessageByUserUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetProductMessageByConversationUseCase>(() => GetProductMessageByConversationUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetProductMessageByProductUseCase>(() => GetProductMessageByProductUseCase(chatRepository: locator()));
    locator.registerLazySingleton<GetNotificationByUserPagingUseCase>(() => GetNotificationByUserPagingUseCase(notificationRepository: locator()));
    locator.registerLazySingleton<GetTransactionNotificationDetailUseCase>(() => GetTransactionNotificationDetailUseCase(notificationRepository: locator()));

    // Repository
    locator.registerLazySingleton<UserRepository>(() => DefaultUserRepository(userDataSource: locator()));
    locator.registerLazySingleton<FeedRepository>(() => DefaultFeedRepository(feedDataSource: locator()));
    locator.registerLazySingleton<BannerRepository>(() => DefaultBannerRepository(bannerDataSource: locator()));
    locator.registerLazySingleton<ProductRepository>(
      () => DefaultProductRepository(
        productDataSource: locator(),
        mapDataSource: locator()
      )
    );
    locator.registerLazySingleton<ProductDiscussionRepository>(
      () => DefaultProductDiscussionRepository(
        productDiscussionDataSource: locator()
      )
    );
    locator.registerLazySingleton<CouponRepository>(() => DefaultCouponRepository(couponDataSource: locator()));
    locator.registerLazySingleton<CartRepository>(() => DefaultCartRepository(cartDataSource: locator()));
    locator.registerLazySingleton<AddressRepository>(() => DefaultAddressRepository(addressDataSource: locator()));
    locator.registerLazySingleton<MapRepository>(() => DefaultMapRepository(mapDataSource: locator()));
    locator.registerLazySingleton<OrderRepository>(() => DefaultOrderRepository(orderDataSource: locator()));
    locator.registerLazySingleton<CargoRepository>(() => DefaultCargoRepository(cargoDataSource: locator()));
    locator.registerLazySingleton<FaqRepository>(() => DefaultFaqRepository(faqDataSource: locator()));
    locator.registerLazySingleton<ChatRepository>(() => DefaultChatRepository(chatDataSource: locator()));
    locator.registerLazySingleton<NotificationRepository>(() => DefaultNotificationRepository(notificationDataSource: locator()));

    // Data Sources
    locator.registerLazySingleton<UserDataSource>(() => DefaultUserDataSource(dio: locator()));
    locator.registerLazySingleton<BannerDataSource>(() => DefaultBannerDataSource(dio: locator()));
    locator.registerLazySingleton<FeedDataSource>(() => DefaultFeedDataSource(dio: locator()));
    locator.registerLazySingleton<ProductDataSource>(
      () => DefaultProductDataSource(
        dio: locator(),
        productBundleDummy: locator(),
        productEntryDummy: locator(),
        productBrandDummy: locator()
      )
    );
    locator.registerLazySingleton<ProductDiscussionDataSource>(
      () => DefaultProductDiscussionDataSource(
        dio: locator(),
        userDummy: locator()
      )
    );
    locator.registerLazySingleton<CouponDataSource>(() => DefaultCouponDataSource(dio: locator()));
    locator.registerLazySingleton<CartDataSource>(() => DefaultCartDataSource(dio: locator(), cartDummy: locator()));
    locator.registerLazySingleton<AddressDataSource>(() => DefaultAddressDataSource(dio: locator(), addressDummy: locator()));
    locator.registerLazySingleton<MapDataSource>(() => DefaultMapDataSource(dio: locator()));
    locator.registerLazySingleton<OrderDataSource>(() => DefaultOrderDataSource(dio: locator()));
    locator.registerLazySingleton<CargoDataSource>(() => DefaultCargoDataSource(dio: locator()));
    locator.registerLazySingleton<FaqDataSource>(() => DefaultFaqDataSource(dio: locator()));
    locator.registerLazySingleton<ChatDataSource>(() => DefaultChatDataSource(dio: locator()));
    locator.registerLazySingleton<NotificationDataSource>(() => DefaultNotificationDataSource(dio: locator()));

    // Dio
    locator.registerLazySingleton<Dio>(() => DioHttpClient.of());
  }
}

// ignore: non_constant_identifier_names
final Injector = _Injector();