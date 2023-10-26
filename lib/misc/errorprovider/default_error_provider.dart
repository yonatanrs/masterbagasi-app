import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../constant.dart';
import '../error/cart_empty_error.dart';
import '../error/coming_soon_error.dart';
import '../error/message_error.dart';
import '../error/not_found_error.dart';
import '../error/search_not_found_error.dart';
import '../error/token_empty_error.dart';
import '../error/validation_error.dart';
import '../multi_language_string.dart';
import 'error_provider.dart';

class DefaultErrorProvider extends ErrorProvider {
  @override
  ErrorProviderResult? onGetErrorProviderResult(e) {
    if (e is DioError) {
      return _handlingDioError(e);
    } else if (e is NotFoundError) {
      return ErrorProviderResult(
        title: "Not Found",
        message: e.message
      );
    } else if (e is ValidationError) {
      return ErrorProviderResult(
        title: e.message,
        message: e.message
      );
    } else if (e is MessageError) {
      return ErrorProviderResult(
        title: e.title,
        message: e.message
      );
    } else if (e is MultiLanguageMessageError) {
      return ErrorProviderResult(
        title: e.title.toStringNonNull,
        message: e.message.toStringNonNull
      );
    } else if (e is CartEmptyError) {
      return _cartIsEmptyErrorProvider();
    } else if (e is SearchNotFoundError) {
      return _searchNotFoundError();
    } else if (e is TokenEmptyError) {
      return ErrorProviderResult(
        title: "You Are Not Login".tr,
        message: "Please login through below button".tr
      );
    } else if (e is ComingSoonError) {
      return ErrorProviderResult(
        title: "Coming Soon".tr,
        message: "",
      );
    } else if (e is PlatformException) {
      return ErrorProviderResult(
        title: "${"Something Failed".tr} (${e.code})",
        message: "${e.message}"
      );
    } else {
      return ErrorProviderResult(
        title: "Something Failed".tr,
        message: e.toString()
      );
    }
  }

  ErrorProviderResult _cartIsEmptyErrorProvider() {
    return onGetErrorProviderResult(
      MultiLanguageMessageError(
        title: MultiLanguageString({
          Constant.textEnUsLanguageKey: "Cart Is Empty",
          Constant.textInIdLanguageKey: "Keranjang Kosong"
        }),
        message: MultiLanguageString({
          Constant.textEnUsLanguageKey: "Now cart is empty.",
          Constant.textInIdLanguageKey: "Untuk sekarang keranjangnya kosong."
        }),
      )
    ).toErrorProviderResultNonNull();
  }

  ErrorProviderResult? _searchNotFoundError() {
    return onGetErrorProviderResult(
      MultiLanguageMessageError(
        title: MultiLanguageString({
          Constant.textEnUsLanguageKey: "Search Not Found",
          Constant.textInIdLanguageKey: "Pencarian Tidak Ditemukan"
        }),
        message: MultiLanguageString({
          Constant.textEnUsLanguageKey: "For now search not found.",
          Constant.textInIdLanguageKey: "Untuk sekarang pencarian tidak ditemukan."
        }),
      )
    ).toErrorProviderResultNonNull();
  }

  ErrorProviderResult _handlingDioError(DioError e) {
    DioErrorType dioErrorType = e.type;
    if (dioErrorType == DioErrorType.other) {
      return ErrorProviderResult(
        title: "Internet Connection Problem".tr,
        message: "${"There is a problem in internet connection".tr}.",
        imageAssetUrl: Constant.imageNoInternet
      );
    } else if (dioErrorType == DioErrorType.connectTimeout) {
      return ErrorProviderResult(
        title: "Internet Connection Timeout".tr,
        message: "${"The connection of internet has been timeout".tr}.",
        imageAssetUrl: Constant.imageNoInternet
      );
    } else if (dioErrorType == DioErrorType.sendTimeout) {
      return ErrorProviderResult(
        title: "Internet Connection Send Timeout".tr,
        message: "${"The connection of internet has been timeout while sending".tr}.",
        imageAssetUrl: Constant.imageNoInternet
      );
    } else if (dioErrorType == DioErrorType.receiveTimeout) {
      return ErrorProviderResult(
        title: "Internet Connection Receive Timeout".tr,
        message: "${"The connection of internet has been timeout while receiving".tr}.",
        imageAssetUrl: Constant.imageNoInternet
      );
    } else if (dioErrorType == DioErrorType.cancel) {
      return ErrorProviderResult(
        title: "Request Canceled".tr,
        message: "${"Request has been canceled".tr}.",
        imageAssetUrl: Constant.imageFailed
      );
    } else if (dioErrorType == DioErrorType.response) {
      ErrorProviderResult elseResponseDecision() {
        Response<dynamic>? response = e.response;
        dynamic responseData = response?.data;
        if (responseData is Map) {
          dynamic errorMeta = responseData['meta'];
          dynamic errors = responseData['data'];
          if (errors != null) {
            if (errors is Map) {
              Map<String, dynamic> errorsMap = errors as Map<String, dynamic>;
              String errorMessage = "";
              void addErrorMessage(String errorMessageContent) {
                errorMessage += "${(errorMessage.isEmptyString ? "" : "\r\n")}$errorMessageContent";
              }
              for (var errorValue in errorsMap.values) {
                if (errorValue is List) {
                  for (var errorValueContent in errorValue) {
                    addErrorMessage(errorValueContent);
                  }
                } else {
                  addErrorMessage(errorValue);
                }
              }
              return ErrorProviderResult(
                title: "Request Failed".tr,
                message: errorMessage.toStringNonNullWithCustomText(text: "(${"No Message".tr})"),
                imageAssetUrl: Constant.imageFailed
              );
            } else if (errors is List) {
              if (errors.isEmpty) {
                if (errorMeta is Map) {
                  if (errorMeta.containsKey('message')) {
                    return ErrorProviderResult(
                      title: "Request Failed".tr,
                      message: MultiLanguageString(errorMeta['message']).toEmptyStringNonNull,
                      imageAssetUrl: Constant.imageFailed
                    );
                  }
                }
              }
            }
            return ErrorProviderResult(
              title: "${"Request Failed".tr} (${e.response?.statusCode})",
              message: "(${"No Message".tr})",
              imageAssetUrl: Constant.imageFailed
            );
          } else {
            String? message = responseData['message'] != null ? responseData['message']!.toString() : null;
            return ErrorProviderResult(
              title: "Request Failed".tr,
              message: !message.isEmptyString ? message! : "(${"No Message".tr})",
              imageAssetUrl: Constant.imageFailed
            );
          }
        } else {
          String effectiveResponse = responseData is String ? responseData.substring(0, responseData.length > 500 ? 500 : responseData.length) : responseData;
          return ErrorProviderResult(
            title: "${"Request Failed".tr} (${e.response?.statusCode})",
            message: !effectiveResponse.isEmptyString ? effectiveResponse : "(${"No Message".tr})",
            imageAssetUrl: Constant.imageFailed
          );
        }
      }
      int? statusCode = e.response?.statusCode;
      if (statusCode == 404) {
        Response<dynamic>? response = e.response;
        dynamic responseData = response?.data;
        if (responseData is Map) {
          dynamic errorMeta = responseData['meta'];
          if (errorMeta is Map) {
            return ErrorProviderResult(
              title: "Not Found".tr,
              message: MultiLanguageString(errorMeta["message"]).toEmptyStringNonNull,
              imageAssetUrl: Constant.imageFailed
            );
          }
        }
        return ErrorProviderResult(
          title: "Not Found".tr,
          message: "${"Request not found (404)".tr}.",
          imageAssetUrl: Constant.imageFailed
        );
      } else if (statusCode == 400) {
        Response<dynamic>? response = e.response;
        dynamic responseData = response?.data;
        if (responseData is Map) {
          dynamic errorMeta = responseData['meta'];
          if (errorMeta is Map) {
            dynamic message = errorMeta["message"];
            if (message == "Data Cart not found!") {
              return _cartIsEmptyErrorProvider();
            }
          }
        }
        return elseResponseDecision();
      } else if (statusCode == 500) {
        return ErrorProviderResult(
          title: "Internal Server Error".tr,
          message: "${"Something has internal server error".tr}.",
          imageAssetUrl: Constant.imageFailed
        );
      } else {
        return elseResponseDecision();
      }
    } else {
      return ErrorProviderResult(
        title: "Something Wrong".tr,
        message: "${"Something wrong related with internet connection".tr}.",
        imageAssetUrl: Constant.imageFailed
      );
    }
  }
}