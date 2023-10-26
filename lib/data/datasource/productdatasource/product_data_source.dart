import '../../../domain/entity/product/product.dart';
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
import '../../../domain/entity/wishlist/wishlist.dart';
import '../../../domain/entity/wishlist/wishlist_paging_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class ProductDataSource {
  FutureProcessing<List<ProductBundle>> productBundleList(ProductBundleListParameter productBundleListParameter);
  FutureProcessing<List<ProductBrand>> productBrandList(ProductBrandListParameter productBrandListParameter);
  FutureProcessing<List<ProductCategory>> productCategoryList(ProductCategoryListParameter productCategoryListParameter);
  FutureProcessing<List<Product>> productList(ProductListParameter productListParameter);
  FutureProcessing<List<ProductEntry>> productWithConditionList(ProductWithConditionListParameter productWithConditionListParameter);
  FutureProcessing<PagingDataResult<Product>> productPaging(ProductPagingParameter productPagingParameter);
  FutureProcessing<PagingDataResult<ProductBrand>> productBrandPaging(ProductBrandPagingParameter productBrandPagingParameter);
  FutureProcessing<PagingDataResult<ProductCategory>> productCategoryPaging(ProductCategoryPagingParameter productCategoryPagingParameter);
  FutureProcessing<PagingDataResult<ProductBundle>> productBundlePaging(ProductBundlePagingParameter productBundlePagingParameter);
  FutureProcessing<ProductBundle> productBundleHighlight(ProductBundleHighlightParameter productBundleHighlightParameter);
  FutureProcessing<PagingDataResult<ProductEntry>> productWithConditionPaging(ProductWithConditionPagingParameter productWithConditionPagingParameter);
  FutureProcessing<ProductDetail> productDetail(ProductDetailParameter productDetailParameter);
  FutureProcessing<ProductBrandDetail> productBrandDetail(ProductBrandDetailParameter productBrandDetailParameter);
  FutureProcessing<ProductCategoryDetail> productCategoryDetail(ProductCategoryDetailParameter productCategoryDetailParameter);
  FutureProcessing<ProductBundleDetail> productBundleDetail(ProductBundleDetailParameter productBundleDetailParameter);
  FutureProcessing<List<ProductEntry>> productDetailFromYourSearchProductEntryList(ProductDetailFromYourSearchProductEntryListParameter productDetailFromYourSearchProductEntryListParameter);
  FutureProcessing<List<ProductEntry>> productDetailOtherChosenForYouProductEntryList(ProductDetailOtherChosenForYouProductEntryListParameter productDetailOtherChosenForYouProductEntryListParameter);
  FutureProcessing<List<ProductEntry>> productDetailOtherFromThisBrandProductEntryList(ProductDetailOtherFromThisBrandProductEntryListParameter productDetailOtherFromThisBrandProductEntryListParameter);
  FutureProcessing<List<ProductEntry>> productDetailOtherInThisCategoryProductEntryList(ProductDetailOtherInThisCategoryProductEntryListParameter productDetailOtherInThisCategoryProductEntryListParameter);
  FutureProcessing<List<ProductBrand>> productDetailOtherInterestedProductBrandListParameter(ProductDetailOtherInterestedProductBrandListParameter productDetailOtherInterestedProductBrandListParameter);
  FutureProcessing<PagingDataResult<Wishlist>> wishlistPaging(WishlistPagingParameter wishlistPagingParameter);
  FutureProcessing<AddWishlistResponse> addWishlist(AddWishlistParameter addWishlistParameter);
  FutureProcessing<RemoveWishlistResponse> removeWishlist(RemoveWishlistParameter removeWishlistParameter);
  FutureProcessing<RemoveWishlistResponse> removeWishlistBasedProduct(RemoveWishlistBasedProductParameter removeWishlistBasedProductParameter);
  FutureProcessing<PagingDataResult<ProductBrand>> favoriteProductBrandPaging(FavoriteProductBrandPagingParameter favoriteProductBrandPagingParameter);
  FutureProcessing<AddToFavoriteProductBrandResponse> addToFavoriteProductBrand(AddToFavoriteProductBrandParameter addToFavoriteProductBrandParameter);
  FutureProcessing<RemoveFromFavoriteProductBrandResponse> removeFromFavoriteProductBrand(RemoveFromFavoriteProductBrandParameter removeFromFavoriteProductBrandParameter);
}