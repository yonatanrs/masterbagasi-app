import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/aspect_ratio_value.dart';

import '../controller/base_getx_controller.dart';
import '../domain/entity/cart/cart.dart';
import '../domain/entity/wishlist/wishlist.dart';
import 'validation/validation_result.dart';
import 'validation/validator/validator.dart';

typedef OnUnfocusAllWidget = void Function();
typedef DummyInitiator<T> = T Function();
typedef WidgetBuilderWithRx<T> = Widget Function(BuildContext, T);
typedef WidgetBuilderWithError = Widget Function(BuildContext, dynamic);
typedef WidgetBuilderWithValidator<T extends Validator> = Widget Function(BuildContext, T);
typedef WidgetBuilderWithValidatorResult = Widget Function(BuildContext, ValidationResult, Validator?);
typedef WidgetBuilderWithItem<T> = Widget Function(BuildContext, T);
typedef TypeCallback<T> = void Function(T);
typedef AspectRatioWithPreviousValue = AspectRatioValue? Function(AspectRatioValue previousAspectRatio);
typedef DoubleReturned = double Function();
typedef SizeCallback = void Function(Size);
typedef GetControllerFromGetPut = BaseGetxController Function();
typedef VoidCallbackWithBuildContextParameter = void Function(BuildContext);
typedef OnShowProcessCancelTransactionRequestProcessLoadingCallback = Future<void> Function();
typedef OnShowProcessCancelTransactionRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef OnAddToWishlist = void Function(dynamic);
typedef OnShowAddToWishlistRequestProcessLoadingCallback = Future<void> Function();
typedef OnAddToWishlistRequestProcessSuccessCallback = Future<void> Function();
typedef OnShowAddToWishlistRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef OnShowRemoveFromWishlistRequestProcessLoadingCallback = Future<void> Function();
typedef OnRemoveFromWishlist = void Function(dynamic);
typedef OnRemoveFromWishlistRequestProcessSuccessCallback = Future<void> Function(Wishlist);
typedef OnShowRemoveFromWishlistRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef OnAddCart = void Function(dynamic);
typedef OnShowAddCartRequestProcessLoadingCallback = Future<void> Function();
typedef OnAddCartRequestProcessSuccessCallback = Future<void> Function();
typedef OnShowAddCartRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef OnBack = void Function();
typedef OnRemoveCart = void Function(dynamic);
typedef OnAddToFavoriteProductBrandRequest = void Function(dynamic);
typedef OnShowAddToFavoriteProductBrandRequestProcessLoadingCallback = Future<void> Function();
typedef OnAddToFavoriteProductBrandRequestProcessSuccessCallback = Future<void> Function();
typedef OnShowAddToFavoriteProductBrandProcessFailedCallback = Future<void> Function(dynamic e);
typedef OnShowRemoveFromFavoriteProductBrandRequestProcessLoadingCallback = Future<void> Function();
typedef OnRemoveFromFavoriteProductBrandRequestProcessSuccessCallback = Future<void> Function();
typedef OnShowRemoveFromFavoriteProductBrandProcessFailedCallback = Future<void> Function(dynamic e);