import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../domain/entity/product/productentry/product_entry_header_content_response.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/brand_product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/category_product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/province_map_product_entry_header_content_response_value.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/product_category_header_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/product_detail_brand_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/product_entry_header_background_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/province_map_header_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../load_data_result.dart';
import 'item_type_list_sub_interceptor.dart';

class ProductEntryHeaderItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  ProductEntryHeaderItemTypeListSubInterceptor({
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
    if (oldItemType is ProductEntryHeaderListItemControllerState) {
      newItemTypeList.add(oldItemType);
      return true;
    } else if (oldItemType is ProductEntryHeaderLoadDataResultListItemControllerState) {
      LoadDataResult<ProductEntryHeaderContentResponse> productEntryHeaderContentResponseLoadDataResult = oldItemType.productEntryHeaderContentResponseLoadDataResult;
      if (productEntryHeaderContentResponseLoadDataResult.isSuccess) {
        ProductEntryHeaderContentResponse productEntryHeaderContentResponse = productEntryHeaderContentResponseLoadDataResult.resultIfSuccess!;
        ProductEntryHeaderContentResponseValue productEntryHeaderContentResponseValue = productEntryHeaderContentResponse.productEntryHeaderContentResponseValue;
        if (productEntryHeaderContentResponseValue is BrandProductEntryHeaderContentResponseValue) {
          newItemTypeList.add(
            ProductDetailBrandListItemControllerState(
              productBrand: productEntryHeaderContentResponseValue.productBrand,
              onAddToFavoriteProductBrand: oldItemType.onAddToFavoriteProductBrand
            )
          );
          return true;
        } else if (productEntryHeaderContentResponseValue is CategoryProductEntryHeaderContentResponseValue) {
          newItemTypeList.add(
            ProductCategoryHeaderListItemControllerState(
              productCategory: productEntryHeaderContentResponseValue.productCategory
            )
          );
          return true;
        } else if (productEntryHeaderContentResponseValue is ProvinceMapProductEntryHeaderContentResponseValue) {
          newItemTypeList.add(
            ProvinceMapHeaderListItemControllerState(
              provinceMap: productEntryHeaderContentResponseValue.provinceMap
            )
          );
          return true;
        } else {
          newItemTypeList.add(oldItemType);
          return true;
        }
      } else {
        newItemTypeList.add(oldItemType);
        return true;
      }
    }
    return false;
  }
}