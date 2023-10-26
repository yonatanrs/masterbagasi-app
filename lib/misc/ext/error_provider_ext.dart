import 'package:get/get.dart';

import '../errorprovider/error_provider.dart';

extension ErrorProviderResultExt on ErrorProviderResult? {
  ErrorProviderResult toErrorProviderResultNonNull() {
    if (this == null) {
      return ErrorProviderResult(
        title: "Something Failed".tr,
        message: "There is something failed".tr
      );
    }

    return this!;
  }
}