import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../domain/entity/product/productbrand/add_to_favorite_product_brand_parameter.dart';
import '../../domain/entity/product/productbrand/add_to_favorite_product_brand_response.dart';
import '../../domain/entity/product/productbrand/product_brand.dart';
import '../../domain/usecase/add_to_favorite_product_brand_use_case.dart';
import '../../domain/usecase/remove_from_favorite_product_brand_use_case.dart';
import '../dialog_helper.dart';
import '../errorprovider/error_provider.dart';
import '../load_data_result.dart';
import '../manager/api_request_manager.dart';
import '../toast_helper.dart';
import '../typedef.dart';
import 'controller_content_delegate.dart';

class ProductBrandFavoriteControllerContentDelegate extends ControllerContentDelegate {
  final AddToFavoriteProductBrandUseCase addToFavoriteProductBrandUseCase;
  final RemoveFromFavoriteProductBrandUseCase removeFromFavoriteProductBrandUseCase;

  ProductBrandFavoriteDelegate? _productBrandFavoriteDelegate;
  ApiRequestManager Function()? _onGetApiRequestManager;

  void addToFavoriteProductBrand(ProductBrand productBrand) async {
    if (_productBrandFavoriteDelegate != null && _onGetApiRequestManager != null) {
      ApiRequestManager apiRequestManager = _onGetApiRequestManager!();
      _productBrandFavoriteDelegate!.onUnfocusAllWidget();
      _productBrandFavoriteDelegate!.onShowAddToFavoriteProductBrandRequestProcessLoadingCallback();
      LoadDataResult<AddToFavoriteProductBrandResponse> addToFavoriteProductBrandResponseLoadDataResult = await addToFavoriteProductBrandUseCase.execute(
        AddToFavoriteProductBrandParameter(productBrand: productBrand)
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart('add-to-wishlist').value
      );
      _productBrandFavoriteDelegate!.onBack();
      if (addToFavoriteProductBrandResponseLoadDataResult.isSuccess) {
        _productBrandFavoriteDelegate!.onAddToFavoriteProductBrandRequestProcessSuccessCallback();
      } else {
        _productBrandFavoriteDelegate!.onShowAddToFavoriteProductBrandProcessFailedCallback(addToFavoriteProductBrandResponseLoadDataResult.resultIfFailed);
      }
    }
  }

  void removeFromFavoriteProductBrand(ProductBrand productBrand) async {
    if (_productBrandFavoriteDelegate != null && _onGetApiRequestManager != null) {
      ApiRequestManager apiRequestManager = _onGetApiRequestManager!();
      _productBrandFavoriteDelegate!.onUnfocusAllWidget();
      _productBrandFavoriteDelegate!.onShowRemoveFromFavoriteProductBrandRequestProcessLoadingCallback();
      LoadDataResult<AddToFavoriteProductBrandResponse> addToFavoriteProductBrandResponseLoadDataResult = await addToFavoriteProductBrandUseCase.execute(
        AddToFavoriteProductBrandParameter(productBrand: productBrand)
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart('add-to-wishlist').value
      );
      _productBrandFavoriteDelegate!.onBack();
      if (addToFavoriteProductBrandResponseLoadDataResult.isSuccess) {
        _productBrandFavoriteDelegate!.onRemoveFromFavoriteProductBrandRequestProcessSuccessCallback();
      } else {
        _productBrandFavoriteDelegate!.onShowRemoveFromFavoriteProductBrandProcessFailedCallback(addToFavoriteProductBrandResponseLoadDataResult.resultIfFailed);
      }
    }
  }

  ProductBrandFavoriteControllerContentDelegate setProductBrandFavoriteDelegate(ProductBrandFavoriteDelegate productBrandFavoriteDelegate) {
    _productBrandFavoriteDelegate = productBrandFavoriteDelegate;
    return this;
  }

  ProductBrandFavoriteControllerContentDelegate setApiRequestManager(ApiRequestManager Function() onGetApiRequestManager) {
    _onGetApiRequestManager = onGetApiRequestManager;
    return this;
  }

  ProductBrandFavoriteControllerContentDelegate({
    required this.addToFavoriteProductBrandUseCase,
    required this.removeFromFavoriteProductBrandUseCase
  });
}

class ProductBrandFavoriteDelegate {
  OnBack onBack;
  OnUnfocusAllWidget onUnfocusAllWidget;
  OnShowAddToFavoriteProductBrandRequestProcessLoadingCallback onShowAddToFavoriteProductBrandRequestProcessLoadingCallback;
  OnAddToFavoriteProductBrandRequestProcessSuccessCallback onAddToFavoriteProductBrandRequestProcessSuccessCallback;
  OnShowAddToFavoriteProductBrandProcessFailedCallback onShowAddToFavoriteProductBrandProcessFailedCallback;
  OnShowRemoveFromFavoriteProductBrandRequestProcessLoadingCallback onShowRemoveFromFavoriteProductBrandRequestProcessLoadingCallback;
  OnRemoveFromFavoriteProductBrandRequestProcessSuccessCallback onRemoveFromFavoriteProductBrandRequestProcessSuccessCallback;
  OnShowRemoveFromFavoriteProductBrandProcessFailedCallback onShowRemoveFromFavoriteProductBrandProcessFailedCallback;

  ProductBrandFavoriteDelegate({
    required this.onBack,
    required this.onUnfocusAllWidget,
    required this.onShowAddToFavoriteProductBrandRequestProcessLoadingCallback,
    required this.onAddToFavoriteProductBrandRequestProcessSuccessCallback,
    required this.onShowAddToFavoriteProductBrandProcessFailedCallback,
    required this.onShowRemoveFromFavoriteProductBrandRequestProcessLoadingCallback,
    required this.onRemoveFromFavoriteProductBrandRequestProcessSuccessCallback,
    required this.onShowRemoveFromFavoriteProductBrandProcessFailedCallback
  });
}

class ProductBrandFavoriteDelegateFactory {
  ProductBrandFavoriteDelegate generateProductBrandFavoriteDelegate({
    required BuildContext Function() onGetBuildContext,
    required ErrorProvider Function() onGetErrorProvider,
    OnBack? onBack,
    OnUnfocusAllWidget? onUnfocusAllWidget,
    OnShowAddToFavoriteProductBrandRequestProcessLoadingCallback? onShowAddToFavoriteProductBrandRequestProcessLoadingCallback,
    OnAddToFavoriteProductBrandRequestProcessSuccessCallback? onAddToFavoriteProductBrandRequestProcessSuccessCallback,
    OnShowAddToFavoriteProductBrandProcessFailedCallback? onShowAddToFavoriteProductBrandProcessFailedCallback
  }) {
    return ProductBrandFavoriteDelegate(
      onUnfocusAllWidget: () => FocusScope.of(onGetBuildContext()).unfocus(),
      onBack: () => Get.back(),
      onShowAddToFavoriteProductBrandRequestProcessLoadingCallback: onShowAddToFavoriteProductBrandRequestProcessLoadingCallback ?? () async => DialogHelper.showLoadingDialog(onGetBuildContext()),
      onAddToFavoriteProductBrandRequestProcessSuccessCallback: onAddToFavoriteProductBrandRequestProcessSuccessCallback ?? () async {
        ToastHelper.showToast("${"Success add to favorite product".tr}.");
      },
      onShowAddToFavoriteProductBrandProcessFailedCallback: onShowAddToFavoriteProductBrandProcessFailedCallback ?? (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
        context: onGetBuildContext(),
        errorProvider: onGetErrorProvider(),
        e: e
      ),
      onShowRemoveFromFavoriteProductBrandRequestProcessLoadingCallback: onShowAddToFavoriteProductBrandRequestProcessLoadingCallback ?? () async => DialogHelper.showLoadingDialog(onGetBuildContext()),
      onRemoveFromFavoriteProductBrandRequestProcessSuccessCallback: onAddToFavoriteProductBrandRequestProcessSuccessCallback ?? () async {
        ToastHelper.showToast("${"Success remove from favorite product".tr}.");
      },
      onShowRemoveFromFavoriteProductBrandProcessFailedCallback: onShowAddToFavoriteProductBrandProcessFailedCallback ?? (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
        context: onGetBuildContext(),
        errorProvider: onGetErrorProvider(),
        e: e
      ),
    );
  }
}