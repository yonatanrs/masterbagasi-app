import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../domain/entity/cart/add_to_cart_parameter.dart';
import '../domain/entity/cart/add_to_cart_response.dart';
import '../domain/entity/cart/support_cart.dart';
import '../domain/entity/componententity/dynamic_item_carousel_component_entity.dart';
import '../domain/entity/componententity/i_dynamic_item_carousel_component_entity.dart';
import '../domain/entity/product/product.dart';
import '../domain/entity/product/product_detail.dart';
import '../domain/entity/product/product_detail_from_your_search_product_entry_list_parameter.dart';
import '../domain/entity/product/product_detail_get_other_chosen_for_you_parameter.dart';
import '../domain/entity/product/product_detail_get_other_from_this_brand_parameter.dart';
import '../domain/entity/product/product_detail_get_other_in_this_category_parameter.dart';
import '../domain/entity/product/product_detail_other_chosen_for_you_product_entry_list_parameter.dart';
import '../domain/entity/product/product_detail_other_from_this_brand_product_entry_list_parameter.dart';
import '../domain/entity/product/product_detail_other_in_this_category_product_entry_list_parameter.dart';
import '../domain/entity/product/product_detail_other_interested_product_brand_list_parameter.dart';
import '../domain/entity/product/product_detail_parameter.dart';
import '../domain/entity/product/productbrand/product_brand.dart';
import '../domain/entity/product/productcategory/product_category.dart';
import '../domain/entity/product/productentry/product_entry.dart';
import '../domain/usecase/add_to_cart_use_case.dart';
import '../domain/usecase/get_my_cart_use_case.dart';
import '../domain/usecase/get_product_category_list_use_case.dart';
import '../domain/usecase/get_product_detail_from_your_search_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_chosen_for_you_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_from_this_brand_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_in_this_category_product_entry_list_use_case.dart';
import '../domain/usecase/get_product_detail_other_interested_product_brand_list_use_case.dart';
import '../domain/usecase/get_product_detail_use_case.dart';
import '../misc/constant.dart';
import '../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../misc/error/message_error.dart';
import '../misc/load_data_result.dart';
import '../misc/multi_language_string.dart';
import '../misc/on_observe_load_product_delegate.dart';
import '../misc/typedef.dart';
import 'base_getx_controller.dart';

typedef _OnGetSupportCart = SupportCart? Function();
typedef _OnShowAddToCartRequestProcessLoadingCallback = Future<void> Function();
typedef _OnAddToCartRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowAddToCartRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef _OnShowBuyDirectlyRequestProcessLoadingCallback = Future<void> Function();
typedef _OnBuyDirectlyRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowBuyDirectlyRequestProcessFailedCallback = Future<void> Function(dynamic e);

class ProductDetailController extends BaseGetxController {
  final GetProductDetailUseCase getProductDetailUseCase;
  final GetProductCategoryListUseCase getProductCategoryListUseCase;
  final GetProductDetailOtherChosenForYouProductEntryListUseCase getProductDetailOtherChosenForYouProductEntryListUseCase;
  final GetProductDetailOtherFromThisBrandProductEntryListUseCase getProductDetailOtherFromThisBrandProductEntryListUseCase;
  final GetProductDetailOtherInThisCategoryProductEntryListUseCase getProductDetailOtherInThisCategoryProductEntryListUseCase;
  final GetProductDetailFromYourSearchProductEntryListUseCase getProductDetailFromYourSearchProductEntryListUseCase;
  final GetProductDetailOtherInterestedProductBrandListUseCase getProductDetailOtherInterestedProductBrandListUseCase;
  final AddToCartUseCase addToCartUseCase;
  final WishlistAndCartControllerContentDelegate wishlistAndCartControllerContentDelegate;
  ProductDetailMainMenuDelegate? _productDetailMainMenuDelegate;

  ProductDetailController(
    super.controllerManager,
    this.getProductDetailUseCase,
    this.getProductCategoryListUseCase,
    this.getProductDetailOtherChosenForYouProductEntryListUseCase,
    this.getProductDetailOtherFromThisBrandProductEntryListUseCase,
    this.getProductDetailOtherInThisCategoryProductEntryListUseCase,
    this.getProductDetailFromYourSearchProductEntryListUseCase,
    this.getProductDetailOtherInterestedProductBrandListUseCase,
    this.addToCartUseCase,
    this.wishlistAndCartControllerContentDelegate
  ) {
    wishlistAndCartControllerContentDelegate.setApiRequestManager(() => apiRequestManager);
  }

  Future<LoadDataResult<ProductDetail>> getProductDetail(ProductDetailParameter productDetailParameter) {
    return getProductDetailUseCase.execute(productDetailParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("product-detail").value
    );
  }

  IDynamicItemCarouselComponentEntity getOtherFromThisBrand(ProductDetailGetOtherFromThisBrandParameter productDetailGetOtherFromThisBrandParameter) {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "Other From This Brand",
        Constant.textInIdLanguageKey: "Lainnya Dari Brand Ini"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<ProductEntry>>());
        LoadDataResult<List<ProductEntry>> productEntryPagingDataResult = await getProductDetailOtherFromThisBrandProductEntryListUseCase.execute(
          ProductDetailOtherFromThisBrandProductEntryListParameter(
            brandSlug: productDetailGetOtherFromThisBrandParameter.brandSlug
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("other-from-this-brand-product-entry-list").value
        );
        if (productEntryPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, productEntryPagingDataResult.map<List<ProductEntry>>(
          (productEntryList) => productEntryList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadProductEntryCarousel(
            OnObserveLoadingLoadProductEntryCarouselParameter()
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<ProductEntry> productEntryList = loadDataResult.resultIfSuccess!;
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadProductEntryCarousel(
            OnObserveSuccessLoadProductEntryCarouselParameter(
              title: title,
              description: description,
              productEntryList: productEntryList
            )
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
    );
  }

  IDynamicItemCarouselComponentEntity getOtherChosenForYou() {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "Other Choosen For You",
        Constant.textInIdLanguageKey: "Pilihan Lainnya Untukmu"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<ProductEntry>>());
        LoadDataResult<List<ProductEntry>> productEntryPagingDataResult = await getProductDetailOtherChosenForYouProductEntryListUseCase.execute(
          ProductDetailOtherChosenForYouProductEntryListParameter()
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("other-choosen-for-you-product-entry-list").value
        );
        if (productEntryPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, productEntryPagingDataResult.map<List<ProductEntry>>(
          (productEntryList) => productEntryList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadProductEntryCarousel(
            OnObserveLoadingLoadProductEntryCarouselParameter()
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<ProductEntry> productEntryList = loadDataResult.resultIfSuccess!;
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadProductEntryCarousel(
            OnObserveSuccessLoadProductEntryCarouselParameter(
              title: title,
              description: description,
              productEntryList: productEntryList
            )
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
    );
  }

  IDynamicItemCarouselComponentEntity getOtherInThisCategory(ProductDetailGetOtherInThisCategoryParameter productDetailGetOtherInThisCategoryParameter) {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "Other In This Category",
        Constant.textInIdLanguageKey: "Lainnya Di Kategory Ini"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<ProductEntry>>());
        LoadDataResult<List<ProductEntry>> productEntryPagingDataResult = await getProductDetailOtherInThisCategoryProductEntryListUseCase.execute(
          ProductDetailOtherInThisCategoryProductEntryListParameter(
            categorySlug: productDetailGetOtherInThisCategoryParameter.categorySlug
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("other-in-this-category-product-entry-list").value
        );
        if (productEntryPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, productEntryPagingDataResult.map<List<ProductEntry>>(
          (productEntryList) => productEntryList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadProductEntryCarousel(
            OnObserveLoadingLoadProductEntryCarouselParameter()
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<ProductEntry> productEntryList = loadDataResult.resultIfSuccess!;
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadProductEntryCarousel(
            OnObserveSuccessLoadProductEntryCarouselParameter(
              title: title,
              description: description,
              productEntryList: productEntryList
            )
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
    );
  }

  IDynamicItemCarouselComponentEntity getOtherFromYourSearch() {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "From Your Search",
        Constant.textInIdLanguageKey: "Dari Pencarianmu"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<ProductEntry>>());
        LoadDataResult<List<ProductEntry>> productEntryPagingDataResult = await getProductDetailFromYourSearchProductEntryListUseCase.execute(
          ProductDetailFromYourSearchProductEntryListParameter()
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("other-from-your-search-product-entry-list").value
        );
        if (productEntryPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, productEntryPagingDataResult.map<List<ProductEntry>>(
          (productEntryList) => productEntryList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadProductEntryCarousel(
            OnObserveLoadingLoadProductEntryCarouselParameter()
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<ProductEntry> productEntryList = loadDataResult.resultIfSuccess!;
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadProductEntryCarousel(
            OnObserveSuccessLoadProductEntryCarouselParameter(
              title: title,
              description: description,
              productEntryList: productEntryList
            )
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
    );
  }

  IDynamicItemCarouselComponentEntity getOtherInterestedProductBrand() {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "Other Interested Brand",
        Constant.textInIdLanguageKey: "Brand Menarik Lainnya"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<ProductBrand>>());
        LoadDataResult<List<ProductBrand>> productEntryPagingDataResult = await getProductDetailOtherInterestedProductBrandListUseCase.execute(
          ProductDetailOtherInterestedProductBrandListParameter()
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("other-interested-product-brand-list").value
        );
        if (productEntryPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, productEntryPagingDataResult.map<List<ProductBrand>>(
          (productBrandList) => productBrandList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadProductBrandCarousel(
            OnObserveLoadingLoadProductBrandCarouselParameter()
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<ProductBrand> productBrandList = loadDataResult.resultIfSuccess!;
        if (_productDetailMainMenuDelegate != null) {
          return _productDetailMainMenuDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadProductBrandCarousel(
            OnObserveSuccessLoadProductBrandCarouselParameter(
              title: title,
              description: description,
              productBrandList: productBrandList
            )
          );
        }
        throw MessageError(title: "Product detail delegate must be initialized");
      },
    );
  }

  void setProductDetailMainMenuDelegate(ProductDetailMainMenuDelegate productDetailMainMenuDelegate) {
    _productDetailMainMenuDelegate = productDetailMainMenuDelegate;
  }

  void addToCart() async {
    if (_productDetailMainMenuDelegate != null) {
      SupportCart? supportCart = _productDetailMainMenuDelegate!.onGetSupportCart();
      if (supportCart != null) {
        _productDetailMainMenuDelegate!.onUnfocusAllWidget();
        _productDetailMainMenuDelegate!.onShowAddToCartRequestProcessLoadingCallback();
        LoadDataResult<AddToCartResponse> addToCartLoadDataResult = await addToCartUseCase.execute(
          AddToCartParameter(
            supportCart: supportCart,
            quantity: 1
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("add-to-cart").value
        );
        if (addToCartLoadDataResult.isSuccess) {
          _productDetailMainMenuDelegate!.onAddToCartRequestProcessSuccessCallback();
        } else {
          _productDetailMainMenuDelegate!.onShowAddToCartRequestProcessFailedCallback(addToCartLoadDataResult.resultIfFailed);
        }
      }
    }
  }

  void buyDirectly() async {
    if (_productDetailMainMenuDelegate != null) {
      SupportCart? supportCart = _productDetailMainMenuDelegate!.onGetSupportCart();
      if (supportCart != null) {
        _productDetailMainMenuDelegate!.onUnfocusAllWidget();
        _productDetailMainMenuDelegate!.onShowAddToCartRequestProcessLoadingCallback();
        LoadDataResult<AddToCartResponse> addToCartLoadDataResult = await addToCartUseCase.execute(
          AddToCartParameter(
            supportCart: supportCart,
            quantity: 1
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("add-to-cart").value
        );
        if (addToCartLoadDataResult.isSuccess) {
          _productDetailMainMenuDelegate!.onAddToCartRequestProcessSuccessCallback();
        } else {
          _productDetailMainMenuDelegate!.onShowAddToCartRequestProcessFailedCallback(addToCartLoadDataResult.resultIfFailed);
        }
      }
    }
  }

  void chatProduct() async {

  }
}

class ProductDetailMainMenuDelegate {
  OnObserveLoadProductDelegate onObserveLoadProductDelegate;
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnGetSupportCart onGetSupportCart;
  _OnShowAddToCartRequestProcessLoadingCallback onShowAddToCartRequestProcessLoadingCallback;
  _OnAddToCartRequestProcessSuccessCallback onAddToCartRequestProcessSuccessCallback;
  _OnShowAddToCartRequestProcessFailedCallback onShowAddToCartRequestProcessFailedCallback;
  _OnShowBuyDirectlyRequestProcessLoadingCallback onShowBuyDirectlyRequestProcessLoadingCallback;
  _OnBuyDirectlyRequestProcessSuccessCallback onBuyDirectlyRequestProcessSuccessCallback;
  _OnShowBuyDirectlyRequestProcessFailedCallback onShowBuyDirectlyRequestProcessFailedCallback;

  ProductDetailMainMenuDelegate({
    required this.onObserveLoadProductDelegate,
    required this.onUnfocusAllWidget,
    required this.onGetSupportCart,
    required this.onShowAddToCartRequestProcessLoadingCallback,
    required this.onAddToCartRequestProcessSuccessCallback,
    required this.onShowAddToCartRequestProcessFailedCallback,
    required this.onShowBuyDirectlyRequestProcessLoadingCallback,
    required this.onBuyDirectlyRequestProcessSuccessCallback,
    required this.onShowBuyDirectlyRequestProcessFailedCallback
  });
}