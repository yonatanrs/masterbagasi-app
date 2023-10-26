import 'package:get/get.dart';

class _ResponseTranslationHelperImpl {
  String? _getSimilarLanguageTranslation(Map response) {
    final translationsWithNoCountry = response.map((key, value) => MapEntry(key.split("_").first, value));
    final containsKey = translationsWithNoCountry.containsKey(Get.locale!.languageCode.split("_").first);
    if (!containsKey) {
      return null;
    }
    return translationsWithNoCountry[Get.locale!.languageCode.split("_").first];
  }

  dynamic translateResponse(dynamic response) {
    if (response is! Map) {
      return response;
    }
    if (Get.locale?.languageCode == null) {
      return "";
    }
    final mainKey = "${Get.locale!.languageCode}_${Get.locale!.countryCode}";
    if (response.containsKey(mainKey)) {
      return response[mainKey]!;
    }
    final similarTranslation = _getSimilarLanguageTranslation(response);
    if (similarTranslation != null) {
      return similarTranslation;
    } else if (Get.fallbackLocale != null) {
      final fallback = Get.fallbackLocale!;
      final key = "${fallback.languageCode}_${fallback.countryCode}";
      if (response.containsKey(key)) {
        return response[key]!;
      }
      if (response.containsKey(fallback.languageCode)) {
        return response[fallback.languageCode]!;
      }
      return "";
    } else {
      return "";
    }
  }
}

// ignore: non_constant_identifier_names
final ResponseTranslationHelper = _ResponseTranslationHelperImpl();