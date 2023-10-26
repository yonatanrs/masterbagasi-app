import 'package:flutter/material.dart';

import '../../../domain/entity/product/productbrand/product_brand.dart';
import '../../../domain/entity/product/productentry/product_entry_header_content_response.dart';
import '../../../presentation/widget/product_entry_header.dart';
import '../../errorprovider/error_provider.dart';
import '../../load_data_result.dart';
import '../../productentryheaderbackground/product_entry_header_background.dart';
import 'list_item_controller_state.dart';

class ProductEntryHeaderListItemControllerState extends ListItemControllerState {
  Widget Function(TextStyle) title;
  OnProductEntryTitleTap? onProductEntryTitleTap;
  ProductEntryHeaderBackground productEntryHeaderBackground;

  ProductEntryHeaderListItemControllerState({
    required this.title,
    this.onProductEntryTitleTap,
    required this.productEntryHeaderBackground
  });
}

class ProductEntryHeaderLoadDataResultListItemControllerState extends ListItemControllerState {
  LoadDataResult<ProductEntryHeaderContentResponse> productEntryHeaderContentResponseLoadDataResult;
  ErrorProvider errorProvider;
  void Function(ProductBrand) onAddToFavoriteProductBrand;

  ProductEntryHeaderLoadDataResultListItemControllerState({
    required this.productEntryHeaderContentResponseLoadDataResult,
    required this.errorProvider,
    required this.onAddToFavoriteProductBrand
  });
}