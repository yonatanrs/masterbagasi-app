import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../domain/entity/product/product.dart';
import '../../domain/entity/product/product_detail.dart';
import '../../domain/entity/product/product_detail_from_your_search_product_entry_list_parameter.dart';
import '../../domain/entity/product/product_detail_other_chosen_for_you_product_entry_list_parameter.dart';
import '../../domain/entity/product/product_detail_other_from_this_brand_product_entry_list_parameter.dart';
import '../../domain/entity/product/product_detail_other_in_this_category_product_entry_list_parameter.dart';
import '../../domain/entity/product/product_detail_other_interested_product_brand_list_parameter.dart';
import '../../domain/entity/product/productbrand/add_to_favorite_product_brand_parameter.dart';
import '../../domain/entity/product/productbrand/add_to_favorite_product_brand_response.dart';
import '../../domain/entity/product/productbrand/favorite_product_brand_paging_parameter.dart';
import '../../domain/entity/product/productbrand/product_brand.dart';
import '../../domain/entity/product/productbrand/product_brand_detail.dart';
import '../../domain/entity/product/productbrand/product_brand_detail_parameter.dart';
import '../../domain/entity/product/productbrand/product_brand_list_parameter.dart';
import '../../domain/entity/product/productbrand/product_brand_paging_parameter.dart';
import '../../domain/entity/product/productbrand/remove_from_favorite_product_brand_parameter.dart';
import '../../domain/entity/product/productbrand/remove_from_favorite_product_brand_response.dart';
import '../../domain/entity/product/productbundle/product_bundle.dart';
import '../../domain/entity/product/productbundle/product_bundle_detail.dart';
import '../../domain/entity/product/productbundle/product_bundle_detail_parameter.dart';
import '../../domain/entity/product/productbundle/product_bundle_highlight_parameter.dart';
import '../../domain/entity/product/productbundle/product_bundle_list_parameter.dart';
import '../../domain/entity/product/productbundle/product_bundle_paging_parameter.dart';
import '../../domain/entity/product/productcategory/product_category.dart';
import '../../domain/entity/product/productcategory/product_category_detail.dart';
import '../../domain/entity/product/productcategory/product_category_detail_parameter.dart';
import '../../domain/entity/product/productcategory/product_category_list_parameter.dart';
import '../../domain/entity/product/product_detail_parameter.dart';
import '../../domain/entity/product/productcategory/product_category_paging_parameter.dart';
import '../../domain/entity/product/productentry/product_entry.dart';
import '../../domain/entity/product/product_list_parameter.dart';
import '../../domain/entity/product/product_paging_parameter.dart';
import '../../domain/entity/product/product_with_condition_list_parameter.dart';
import '../../domain/entity/product/product_with_condition_paging_parameter.dart';
import '../../domain/entity/product/productentry/product_entry_header_content_parameter.dart';
import '../../domain/entity/product/productentry/product_entry_header_content_response.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/brand_product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/category_product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/province_map_product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/static_product_entry_header_content_response_value.dart';
import '../../domain/entity/province/province_map.dart';
import '../../domain/entity/province/province_map_detail_parameter.dart';
import '../../domain/entity/wishlist/add_wishlist_parameter.dart';
import '../../domain/entity/wishlist/add_wishlist_response.dart';
import '../../domain/entity/wishlist/remove_wishlist_based_product_parameter.dart';
import '../../domain/entity/wishlist/remove_wishlist_parameter.dart';
import '../../domain/entity/wishlist/remove_wishlist_response.dart';
import '../../domain/entity/wishlist/wishlist.dart';
import '../../domain/entity/wishlist/wishlist_paging_parameter.dart';
import '../../domain/repository/product_repository.dart';
import '../../misc/constant.dart';
import '../../misc/load_data_result.dart';
import '../../misc/multi_language_string.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/dio_http_client_processing.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/mapdatasource/map_data_source.dart';
import '../datasource/productdatasource/product_data_source.dart';

class DefaultProductRepository implements ProductRepository {
  final ProductDataSource productDataSource;
  final MapDataSource mapDataSource;

  const DefaultProductRepository({
    required this.productDataSource,
    required this.mapDataSource
  });

  @override
  FutureProcessing<LoadDataResult<List<ProductBundle>>> productBundleList(ProductBundleListParameter productBundleListParameter) {
    return productDataSource.productBundleList(productBundleListParameter).mapToLoadDataResult<List<ProductBundle>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductBrand>>> productBrandList(ProductBrandListParameter productBrandListParameter) {
    return productDataSource.productBrandList(productBrandListParameter).mapToLoadDataResult<List<ProductBrand>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductCategory>>> productCategoryList(ProductCategoryListParameter productCategoryListParameter) {
    return productDataSource.productCategoryList(productCategoryListParameter).mapToLoadDataResult<List<ProductCategory>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<Product>>> productList(ProductListParameter productListParameter) {
    return productDataSource.productList(productListParameter).mapToLoadDataResult<List<Product>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductEntry>>> productWithConditionList(ProductWithConditionListParameter productWithConditionListParameter) {
    return productDataSource.productWithConditionList(productWithConditionListParameter).mapToLoadDataResult<List<ProductEntry>>();
  }

  @override
  FutureProcessing<LoadDataResult<ProductEntryHeaderContentResponse>> productEntryHeaderContent(ProductEntryHeaderContentParameter productEntryHeaderContentParameter) {
    return DioHttpClientProcessing((cancelToken) async {
      Map<String, dynamic> parameterMap = productEntryHeaderContentParameter.parameterMap;
      late ProductEntryHeaderContentResponseValue productEntryHeaderContentResponseValue;
      if (parameterMap.containsKey("category_id") || parameterMap.containsKey("category")) {
        LoadDataResult<ProductCategoryDetail> productCategoryDetailLoadDataResult = await productDataSource.productCategoryDetail(
          ProductCategoryDetailParameter(
            productCategoryDetailId: parameterMap.containsKey("category_id") ? parameterMap["category_id"] : parameterMap["category"],
            productCategoryDetailParameterType: parameterMap.containsKey("category_id") ? ProductCategoryDetailParameterType.id : ProductCategoryDetailParameterType.slug
          ),
        ).mapToLoadDataResult<ProductCategoryDetail>().future(parameter: cancelToken);
        if (productCategoryDetailLoadDataResult.isFailed) {
          return productCategoryDetailLoadDataResult.map<ProductEntryHeaderContentResponse>((test) => throw UnimplementedError());
        }
        ProductCategoryDetail productCategoryDetail = productCategoryDetailLoadDataResult.resultIfSuccess!;
        productEntryHeaderContentResponseValue = CategoryProductEntryHeaderContentResponseValue(
          productCategory: productCategoryDetail
        );
      } else if (parameterMap.containsKey("brand_id") || parameterMap.containsKey("brand")) {
        LoadDataResult<ProductBrandDetail> productBrandDetailLoadDataResult = await productDataSource.productBrandDetail(
          ProductBrandDetailParameter(
            productBrandId: parameterMap.containsKey("brand_id") ? parameterMap["brand_id"] : parameterMap["brand"],
            productBrandDetailParameterType: parameterMap.containsKey("brand_id") ? ProductBrandDetailParameterType.id : ProductBrandDetailParameterType.slug
          ),
        ).mapToLoadDataResult<ProductBrandDetail>().future(parameter: cancelToken);
        if (productBrandDetailLoadDataResult.isFailed) {
          return productBrandDetailLoadDataResult.map<ProductEntryHeaderContentResponse>((test) => throw UnimplementedError());
        }
        ProductBrandDetail productBrandDetail = productBrandDetailLoadDataResult.resultIfSuccess!;
        productEntryHeaderContentResponseValue = BrandProductEntryHeaderContentResponseValue(
          productBrand: productBrandDetail
        );
      } else if (parameterMap.containsKey("province")) {
        LoadDataResult<ProvinceMap> provinceMapLoadDataResult = await mapDataSource.provinceMapDetail(
          ProvinceMapDetailParameter(
            provinceMapId: parameterMap.containsKey("province_id") ? parameterMap["province_id"] : parameterMap["province"],
            provinceMapDetailParameterType: parameterMap.containsKey("province_id") ? ProvinceMapDetailParameterType.id : ProvinceMapDetailParameterType.slug
          ),
        ).mapToLoadDataResult<ProvinceMap>().future(parameter: cancelToken);
        if (provinceMapLoadDataResult.isFailed) {
          return provinceMapLoadDataResult.map<ProductEntryHeaderContentResponse>((test) => throw UnimplementedError());
        }
        ProvinceMap provinceMap = provinceMapLoadDataResult.resultIfSuccess!;
        productEntryHeaderContentResponseValue = ProvinceMapProductEntryHeaderContentResponseValue(
          provinceMap: provinceMap
        );
      } else {
        if (parameterMap.containsKey("name")) {
          productEntryHeaderContentResponseValue = StaticProductEntryHeaderContentResponseValue(
            bannerAssetImageUrl: Constant.imageProductViralBackground,
            title: MultiLanguageString(parameterMap["name"]).toString(),
          );
        } else {
          productEntryHeaderContentResponseValue = StaticProductEntryHeaderContentResponseValue(
            bannerAssetImageUrl: Constant.imageProductViralBackground,
            title: MultiLanguageString("Unknown Result".tr).toString(),
          );
        }
      }
      return SuccessLoadDataResult<ProductEntryHeaderContentResponse>(
        value: ProductEntryHeaderContentResponse(
          productEntryHeaderContentResponseValue: productEntryHeaderContentResponseValue
        )
      );
    });
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<Product>>> productPaging(ProductPagingParameter productPagingParameter) {
    return productDataSource.productPaging(productPagingParameter).mapToLoadDataResult<PagingDataResult<Product>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductBrand>>> productBrandPaging(ProductBrandPagingParameter productBrandPagingParameter) {
    return productDataSource.productBrandPaging(productBrandPagingParameter).mapToLoadDataResult<PagingDataResult<ProductBrand>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductCategory>>> productCategoryPaging(ProductCategoryPagingParameter productCategoryPagingParameter) {
    return productDataSource.productCategoryPaging(productCategoryPagingParameter).mapToLoadDataResult<PagingDataResult<ProductCategory>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductBundle>>> productBundlePaging(ProductBundlePagingParameter productBundlePagingParameter) {
    return productDataSource.productBundlePaging(productBundlePagingParameter).mapToLoadDataResult<PagingDataResult<ProductBundle>>();
  }

  @override
  FutureProcessing<LoadDataResult<ProductBundle>> productBundleHighlight(ProductBundleHighlightParameter productBundleHighlightParameter) {
    return productDataSource.productBundleHighlight(productBundleHighlightParameter).mapToLoadDataResult<ProductBundle>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductEntry>>> productWithConditionPaging(ProductWithConditionPagingParameter productWithConditionPagingParameter) {
    return productDataSource.productWithConditionPaging(productWithConditionPagingParameter).mapToLoadDataResult<PagingDataResult<ProductEntry>>();
  }

  @override
  FutureProcessing<LoadDataResult<ProductDetail>> productDetail(ProductDetailParameter productDetailParameter) {
    return productDataSource.productDetail(productDetailParameter).mapToLoadDataResult<ProductDetail>();
  }

  @override
  FutureProcessing<LoadDataResult<ProductBrandDetail>> productBrandDetail(ProductBrandDetailParameter productBrandDetailParameter) {
    return productDataSource.productBrandDetail(productBrandDetailParameter).mapToLoadDataResult<ProductBrandDetail>();
  }

  @override
  FutureProcessing<LoadDataResult<ProductCategoryDetail>> productCategoryDetail(ProductCategoryDetailParameter productCategoryDetailParameter) {
    return productDataSource.productCategoryDetail(productCategoryDetailParameter).mapToLoadDataResult<ProductCategoryDetail>();
  }

  @override
  FutureProcessing<LoadDataResult<ProductBundleDetail>> productBundleDetail(ProductBundleDetailParameter productBundleDetailParameter) {
    return productDataSource.productBundleDetail(productBundleDetailParameter).mapToLoadDataResult<ProductBundleDetail>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductEntry>>> productDetailFromYourSearchProductEntryList(ProductDetailFromYourSearchProductEntryListParameter productDetailFromYourSearchProductEntryListParameter) {
    return productDataSource.productDetailFromYourSearchProductEntryList(productDetailFromYourSearchProductEntryListParameter).mapToLoadDataResult<List<ProductEntry>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductEntry>>> productDetailOtherChosenForYouProductEntryList(ProductDetailOtherChosenForYouProductEntryListParameter productDetailOtherChosenForYouProductEntryListParameter) {
    return productDataSource.productDetailOtherChosenForYouProductEntryList(productDetailOtherChosenForYouProductEntryListParameter).mapToLoadDataResult<List<ProductEntry>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductEntry>>> productDetailOtherFromThisBrandProductEntryList(ProductDetailOtherFromThisBrandProductEntryListParameter productDetailOtherFromThisBrandProductEntryListParameter) {
    return productDataSource.productDetailOtherFromThisBrandProductEntryList(productDetailOtherFromThisBrandProductEntryListParameter).mapToLoadDataResult<List<ProductEntry>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductEntry>>> productDetailOtherInThisCategoryProductEntryList(ProductDetailOtherInThisCategoryProductEntryListParameter productDetailOtherInThisCategoryProductEntryListParameter) {
    return productDataSource.productDetailOtherInThisCategoryProductEntryList(productDetailOtherInThisCategoryProductEntryListParameter).mapToLoadDataResult<List<ProductEntry>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ProductBrand>>> productDetailOtherInterestedProductBrandListParameter(ProductDetailOtherInterestedProductBrandListParameter productDetailOtherInterestedProductBrandListParameter) {
    return productDataSource.productDetailOtherInterestedProductBrandListParameter(productDetailOtherInterestedProductBrandListParameter).mapToLoadDataResult<List<ProductBrand>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<Wishlist>>> wishlistPaging(WishlistPagingParameter wishlistPagingParameter) {
    return productDataSource.wishlistPaging(wishlistPagingParameter).mapToLoadDataResult<PagingDataResult<Wishlist>>();
  }

  @override
  FutureProcessing<LoadDataResult<AddWishlistResponse>> addWishlist(AddWishlistParameter addWishlistParameter) {
    return productDataSource.addWishlist(addWishlistParameter).mapToLoadDataResult<AddWishlistResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<RemoveWishlistResponse>> removeWishlist(RemoveWishlistParameter removeWishlistParameter) {
    return productDataSource.removeWishlist(removeWishlistParameter).mapToLoadDataResult<RemoveWishlistResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<RemoveWishlistResponse>> removeWishlistBasedProduct(RemoveWishlistBasedProductParameter removeWishlistBasedProductParameter) {
    return productDataSource.removeWishlistBasedProduct(removeWishlistBasedProductParameter).mapToLoadDataResult<RemoveWishlistResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ProductBrand>>> favoriteProductBrandPaging(FavoriteProductBrandPagingParameter favoriteProductBrandPagingParameter) {
    return productDataSource.favoriteProductBrandPaging(favoriteProductBrandPagingParameter).mapToLoadDataResult<PagingDataResult<ProductBrand>>();
  }

  @override
  FutureProcessing<LoadDataResult<AddToFavoriteProductBrandResponse>> addToFavoriteProductBrand(AddToFavoriteProductBrandParameter addToFavoriteProductBrandParameter) {
    return productDataSource.addToFavoriteProductBrand(addToFavoriteProductBrandParameter).mapToLoadDataResult<AddToFavoriteProductBrandResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<RemoveFromFavoriteProductBrandResponse>> removeFromFavoriteProductBrand(RemoveFromFavoriteProductBrandParameter removeFromFavoriteProductBrandParameter) {
    return productDataSource.removeFromFavoriteProductBrand(removeFromFavoriteProductBrandParameter).mapToLoadDataResult<RemoveFromFavoriteProductBrandResponse>();
  }
}