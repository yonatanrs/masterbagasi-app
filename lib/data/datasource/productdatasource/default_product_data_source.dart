import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/product_entity_mapping_ext.dart';
import 'package:masterbagasi/domain/dummy/productdummy/product_bundle_dummy.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/option_builder.dart';

import '../../../domain/dummy/productdummy/product_brand_dummy.dart';
import '../../../domain/dummy/productdummy/product_entry_dummy.dart';
import '../../../domain/entity/product/product.dart';
import '../../../domain/entity/product/product_appearance_data.dart';
import '../../../domain/entity/product/product_detail.dart';
import '../../../domain/entity/product/product_detail_from_your_search_product_entry_list_parameter.dart';
import '../../../domain/entity/product/product_detail_other_chosen_for_you_product_entry_list_parameter.dart';
import '../../../domain/entity/product/product_detail_other_from_this_brand_product_entry_list_parameter.dart';
import '../../../domain/entity/product/product_detail_other_in_this_category_product_entry_list_parameter.dart';
import '../../../domain/entity/product/product_detail_other_interested_product_brand_list_parameter.dart';
import '../../../domain/entity/product/productbrand/add_to_favorite_product_brand_parameter.dart';
import '../../../domain/entity/product/productbrand/add_to_favorite_product_brand_response.dart';
import '../../../domain/entity/product/productbrand/favorite_product_brand_paging_parameter.dart';
import '../../../domain/entity/product/productbrand/product_brand.dart';
import '../../../domain/entity/product/productbrand/product_brand_detail.dart';
import '../../../domain/entity/product/productbrand/product_brand_detail_parameter.dart';
import '../../../domain/entity/product/productbrand/product_brand_list_parameter.dart';
import '../../../domain/entity/product/productbrand/product_brand_paging_parameter.dart';
import '../../../domain/entity/product/productbrand/remove_from_favorite_product_brand_parameter.dart';
import '../../../domain/entity/product/productbrand/remove_from_favorite_product_brand_response.dart';
import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../domain/entity/product/productbundle/product_bundle_detail.dart';
import '../../../domain/entity/product/productbundle/product_bundle_detail_parameter.dart';
import '../../../domain/entity/product/productbundle/product_bundle_highlight_parameter.dart';
import '../../../domain/entity/product/productbundle/product_bundle_list_parameter.dart';
import '../../../domain/entity/product/productbundle/product_bundle_paging_parameter.dart';
import '../../../domain/entity/product/productcategory/product_category.dart';
import '../../../domain/entity/product/productcategory/product_category_detail.dart';
import '../../../domain/entity/product/productcategory/product_category_detail_parameter.dart';
import '../../../domain/entity/product/productcategory/product_category_list_parameter.dart';
import '../../../domain/entity/product/product_detail_parameter.dart';
import '../../../domain/entity/product/productcategory/product_category_paging_parameter.dart';
import '../../../domain/entity/product/productentry/product_entry.dart';
import '../../../domain/entity/product/product_list_parameter.dart';
import '../../../domain/entity/product/product_paging_parameter.dart';
import '../../../domain/entity/product/product_with_condition_list_parameter.dart';
import '../../../domain/entity/product/product_with_condition_paging_parameter.dart';
import '../../../domain/entity/wishlist/add_wishlist_parameter.dart';
import '../../../domain/entity/wishlist/add_wishlist_response.dart';
import '../../../domain/entity/wishlist/remove_wishlist_based_product_parameter.dart';
import '../../../domain/entity/wishlist/remove_wishlist_parameter.dart';
import '../../../domain/entity/wishlist/remove_wishlist_response.dart';
import '../../../domain/entity/wishlist/support_wishlist.dart';
import '../../../domain/entity/wishlist/wishlist.dart';
import '../../../domain/entity/wishlist/wishlist_paging_parameter.dart';
import '../../../misc/error/not_found_error.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/dummy_future_processing.dart';
import '../../../misc/processing/future_processing.dart';
import '../../../misc/response_wrapper.dart';
import 'product_data_source.dart';

class DefaultProductDataSource implements ProductDataSource {
  final Dio dio;
  final ProductBundleDummy productBundleDummy;
  final ProductEntryDummy productEntryDummy;
  final ProductBrandDummy productBrandDummy;

  const DefaultProductDataSource({
    required this.dio,
    required this.productBundleDummy,
    required this.productEntryDummy,
    required this.productBrandDummy
  });

  @override
  FutureProcessing<List<ProductBundle>> productBundleList(ProductBundleListParameter productBundleListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/bundle", cancelToken: cancelToken)
        .map<List<ProductBundle>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductBundleList());
    });
  }

  @override
  FutureProcessing<List<ProductBrand>> productBrandList(ProductBrandListParameter productBrandListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/brand", cancelToken: cancelToken)
        .map<List<ProductBrand>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductBrandList());
    });
  }

  @override
  FutureProcessing<List<ProductCategory>> productCategoryList(ProductCategoryListParameter productCategoryListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/category", cancelToken: cancelToken)
        .map<List<ProductCategory>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductCategoryList());
    });
  }

  @override
  FutureProcessing<List<Product>> productList(ProductListParameter productListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product", cancelToken: cancelToken)
        .map<List<Product>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductList());
    });
  }

  @override
  FutureProcessing<List<ProductEntry>> productWithConditionList(ProductWithConditionListParameter productWithConditionListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String withConditionParameterPath = productWithConditionListParameter.withCondition.isNotEmptyString ? "/${productWithConditionListParameter.withCondition}" : "";
      return dio.get("/product$withConditionParameterPath", cancelToken: cancelToken)
        .map<List<ProductEntry>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductEntryList());
    });
  }

  @override
  FutureProcessing<PagingDataResult<Product>> productPaging(ProductPagingParameter productPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${productPagingParameter.itemEachPageCount}&page=${productPagingParameter.page}";
      return dio.get("/product$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<Product>>(onMap: (value) => value.wrapResponse().mapFromResponseToPagingDataResult(
          (dataResponse) => dataResponse.map<Product>(
            (productResponse) => ResponseWrapper(productResponse).mapFromResponseToProduct()
          ).toList()
        ));
    });
  }

  @override
  FutureProcessing<PagingDataResult<ProductBrand>> productBrandPaging(ProductBrandPagingParameter productBrandPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${productBrandPagingParameter.itemEachPageCount}&page=${productBrandPagingParameter.page}";
      return dio.get("/product/brand$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<ProductBrand>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductBrandPaging());
    });
  }

  @override
  FutureProcessing<PagingDataResult<ProductCategory>> productCategoryPaging(ProductCategoryPagingParameter productCategoryPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${productCategoryPagingParameter.itemEachPageCount}&page=${productCategoryPagingParameter.page}";
      return dio.get("/product/category$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<ProductCategory>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductCategoryPaging());
    });
  }

  @override
  FutureProcessing<PagingDataResult<ProductBundle>> productBundlePaging(ProductBundlePagingParameter productBundlePagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${productBundlePagingParameter.itemEachPageCount}&page=${productBundlePagingParameter.page}";
      return dio.get("/bundling$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<ProductBundle>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductBundlePaging());
    });
  }

  @override
  FutureProcessing<ProductBundle> productBundleHighlight(ProductBundleHighlightParameter productBundleHighlightParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=1&page=1";
      return dio.get("/bundling$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<ProductBundle>>(onMap: (value) => value.wrapResponse().mapFromResponseToProductBundlePaging())
        .map<ProductBundle>(onMap: (value) {
          if (value.itemList.isEmpty) {
            throw NotFoundError();
          }
          return value.itemList.first;
        });
    });
  }

  @override
  FutureProcessing<PagingDataResult<ProductEntry>> productWithConditionPaging(ProductWithConditionPagingParameter productWithConditionPagingParameter) {
    Map<String, dynamic> queryParameters = {
      "page": productWithConditionPagingParameter.page,
      "pageNumber": productWithConditionPagingParameter.itemEachPageCount,
      ...productWithConditionPagingParameter.withCondition
    };
    return DioHttpClientProcessing((cancelToken) async {
      var productEntryResultPagingDataResult = await dio.get("/product/entry", queryParameters: queryParameters, cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductEntryPaging());
      if (productWithConditionPagingParameter.onInterceptProductPagingDataResult != null) {{
        return productWithConditionPagingParameter.onInterceptProductPagingDataResult!(productEntryResultPagingDataResult);
      }}
      return productEntryResultPagingDataResult;
    });
  }

  @override
  FutureProcessing<ProductDetail> productDetail(ProductDetailParameter productDetailParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/${productDetailParameter.productId}", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductDetail());
    });
  }

  @override
  FutureProcessing<ProductBrandDetail> productBrandDetail(ProductBrandDetailParameter productBrandDetailParameter) {
    return DioHttpClientProcessing((cancelToken) {
      late String lastPathEndpoint;
      if (productBrandDetailParameter.productBrandDetailParameterType == ProductCategoryDetailParameterType.slug) {
        lastPathEndpoint = "slug/${productBrandDetailParameter.productBrandId}";
      } else {
        lastPathEndpoint = productBrandDetailParameter.productBrandId;
      }
      return dio.get("/product/brand/$lastPathEndpoint", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductBrandDetail());
    });
  }

  @override
  FutureProcessing<ProductCategoryDetail> productCategoryDetail(ProductCategoryDetailParameter productCategoryDetailParameter) {
    return DioHttpClientProcessing((cancelToken) {
      late String lastPathEndpoint;
      if (productCategoryDetailParameter.productCategoryDetailParameterType == ProductCategoryDetailParameterType.slug) {
        lastPathEndpoint = "slug/${productCategoryDetailParameter.productCategoryDetailId}";
      } else {
        lastPathEndpoint = productCategoryDetailParameter.productCategoryDetailId;
      }
      return dio.get("/product/category/$lastPathEndpoint", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductCategoryDetail());
    });
  }

  @override
  FutureProcessing<ProductBundleDetail> productBundleDetail(ProductBundleDetailParameter productBundleDetailParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/bundling/${productBundleDetailParameter.productBundleId}", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductBundleDetail());
    });
  }

  @override
  FutureProcessing<List<ProductEntry>> productDetailFromYourSearchProductEntryList(ProductDetailFromYourSearchProductEntryListParameter productDetailFromYourSearchProductEntryListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/entry", queryParameters: {"fyp": true, "page": 1, "pageNumber": 10}, cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductEntryPaging().itemList);
    });
  }

  @override
  FutureProcessing<List<ProductEntry>> productDetailOtherChosenForYouProductEntryList(ProductDetailOtherChosenForYouProductEntryListParameter productDetailOtherChosenForYouProductEntryListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/entry", queryParameters: {"fyp": true, "page": 1, "pageNumber": 10}, cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductEntryPaging().itemList);
    });
  }

  @override
  FutureProcessing<List<ProductEntry>> productDetailOtherFromThisBrandProductEntryList(ProductDetailOtherFromThisBrandProductEntryListParameter productDetailOtherFromThisBrandProductEntryListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/entry", queryParameters: {"brand": productDetailOtherFromThisBrandProductEntryListParameter.brandSlug, "page": 1, "pageNumber": 10}, cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductEntryPaging().itemList);
    });
  }

  @override
  FutureProcessing<List<ProductEntry>> productDetailOtherInThisCategoryProductEntryList(ProductDetailOtherInThisCategoryProductEntryListParameter productDetailOtherInThisCategoryProductEntryListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/entry", queryParameters: {"category": productDetailOtherInThisCategoryProductEntryListParameter.categorySlug, "page": 1, "pageNumber": 10}, cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductEntryPaging().itemList);
    });
  }

  @override
  FutureProcessing<List<ProductBrand>> productDetailOtherInterestedProductBrandListParameter(ProductDetailOtherInterestedProductBrandListParameter productDetailOtherInterestedProductBrandListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/product/brand", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToProductBrandList());
    });
  }

  @override
  FutureProcessing<PagingDataResult<Wishlist>> wishlistPaging(WishlistPagingParameter wishlistPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${wishlistPagingParameter.itemEachPageCount}&page=${wishlistPagingParameter.page}";
      return dio.get("/user/wishlist$pageParameterPath", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToWishlistPaging());
    });
  }

  @override
  FutureProcessing<AddWishlistResponse> addWishlist(AddWishlistParameter addWishlistParameter) {
    return DioHttpClientProcessing((cancelToken) async {
      SupportWishlist supportWishlist = addWishlistParameter.supportWishlist;
      FormData formData = FormData.fromMap(
        <String, dynamic> {
          if (supportWishlist is ProductEntryAppearanceData) "product_entry_id": (supportWishlist as ProductEntryAppearanceData).productEntryId,
          if (supportWishlist is ProductBundle) "bundling_id": supportWishlist.id,
        }
      );
      return dio.post("/user/wishlist", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<AddWishlistResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAddWishlistResponse());
    });
  }

  @override
  FutureProcessing<RemoveWishlistResponse> removeWishlist(RemoveWishlistParameter removeWishlistParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.delete("/user/wishlist/${removeWishlistParameter.wishlistId}", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToRemoveWishlistResponse());
    });
  }

  @override
  FutureProcessing<RemoveWishlistResponse> removeWishlistBasedProduct(RemoveWishlistBasedProductParameter removeWishlistBasedProductParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.delete("/user/wishlist/product/${removeWishlistBasedProductParameter.productEntryOrProductBundleId}", cancelToken: cancelToken)
        .map(onMap: (value) => value.wrapResponse().mapFromResponseToRemoveWishlistResponse());
    });
  }

  @override
  FutureProcessing<PagingDataResult<ProductBrand>> favoriteProductBrandPaging(FavoriteProductBrandPagingParameter favoriteProductBrandPagingParameter) {
    return DummyFutureProcessing((parameter) async {
      String pageParameterPath = "/?pageNumber=${favoriteProductBrandPagingParameter.itemEachPageCount}&page=${favoriteProductBrandPagingParameter.page}";
      return dio.get("/user/brand-fav$pageParameterPath", cancelToken: parameter)
        .map<PagingDataResult<ProductBrand>>(onMap: (value) => value.wrapResponse().mapFromResponseToFavoriteProductBrandPaging());
    });
  }

  @override
  FutureProcessing<AddToFavoriteProductBrandResponse> addToFavoriteProductBrand(AddToFavoriteProductBrandParameter addToFavoriteProductBrandParameter) {
    return DummyFutureProcessing((parameter) async {
      FormData formData = FormData.fromMap(
        <String, dynamic> {
          "product_brand_id": addToFavoriteProductBrandParameter.productBrand.id
        }
      );
      return dio.post("/user/brand-fav", data: formData, cancelToken: parameter, options: OptionsBuilder.multipartData().build())
        .map<AddToFavoriteProductBrandResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAddToFavoriteProductBrandResponse());
    });
  }

  @override
  FutureProcessing<RemoveFromFavoriteProductBrandResponse> removeFromFavoriteProductBrand(RemoveFromFavoriteProductBrandParameter removeFromFavoriteProductBrandParameter) {
    return DummyFutureProcessing((parameter) async {
      return dio.delete("/user/brand-fav/${removeFromFavoriteProductBrandParameter.productBrand.id}", cancelToken: parameter)
        .map<RemoveFromFavoriteProductBrandResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToRemoveFromFavoriteProductBrandResponse());
    });
  }
}