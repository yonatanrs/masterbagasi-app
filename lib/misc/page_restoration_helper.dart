import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../controller/crop_picture_controller.dart';
import '../presentation/page/address_page.dart';
import '../presentation/page/affiliate_page.dart';
import '../presentation/page/cart_page.dart';
import '../presentation/page/country_delivery_review_media_view_page.dart';
import '../presentation/page/country_delivery_review_page.dart';
import '../presentation/page/coupon_page.dart';
import '../presentation/page/crop_picture_page.dart';
import '../presentation/page/delivery_page.dart';
import '../presentation/page/deliveryreview/delivery_review_page.dart';
import '../presentation/page/favorite_product_brand_page.dart';
import '../presentation/page/getx_page.dart';
import '../presentation/page/help_chat_page.dart';
import '../presentation/page/help_page.dart';
import '../presentation/page/inbox_page.dart';
import '../presentation/page/login_page.dart';
import '../presentation/page/mainmenu/main_menu_page.dart';
import '../presentation/page/modify_address_page.dart';
import '../presentation/page/msme_partner_page.dart';
import '../presentation/page/notification_page.dart';
import '../presentation/page/order_chat_page.dart';
import '../presentation/page/order_detail_page.dart';
import '../presentation/page/order_page.dart';
import '../presentation/page/product_brand_page.dart';
import '../presentation/page/product_bundle_detail_page.dart';
import '../presentation/page/product_bundle_page.dart';
import '../presentation/page/product_category_detail_page.dart';
import '../presentation/page/product_chat_page.dart';
import '../presentation/page/product_detail_page.dart';
import '../presentation/page/product_discussion_page.dart';
import '../presentation/page/product_entry_page.dart';
import '../presentation/page/register_page.dart';
import '../presentation/page/search_page.dart';
import '../presentation/page/take_friend_cart_page.dart';
import '../presentation/page/web_viewer_page.dart';
import 'constant.dart';
import 'login_helper.dart';

class _PageRestorationHelperImpl {
  bool _checkingPageRestorationMixin<T extends GetxPageRestoration>({
    required Widget checkingWidget,
    required void Function(T) onGetxPageRestorationFound,
    required BuildContext context
  }) {
    if (checkingWidget is RestorableGetxPage) {
      RestorableGetxPage widget = checkingWidget;
      GetxPageRestoration restoration = widget.getPageRestoration(context);
      if (restoration is T) {
        onGetxPageRestorationFound(restoration);
        return false;
      }
      return true;
    }
    return true;
  }

  void findPageRestorationMixin<T extends GetxPageRestoration>({
    required void Function(T) onGetxPageRestorationFound,
    required BuildContext context
  }) {
    if (_checkingPageRestorationMixin(checkingWidget: context.widget, onGetxPageRestorationFound: onGetxPageRestorationFound, context: context)) {
      context.visitAncestorElements((element) {
        return _checkingPageRestorationMixin(checkingWidget: element.widget, onGetxPageRestorationFound: onGetxPageRestorationFound, context: context);
      });
    }
  }

  void toLoginPage(BuildContext context, String restorableRouteFuturePushParameter) {
    PageRestorationHelper.findPageRestorationMixin<LoginPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.loginPageRestorableRouteFuture.present(restorableRouteFuturePushParameter);
      },
      context: context
    );
  }

  void toMainMenuPage(BuildContext context, String restorableRouteFuturePushParameter) {
    PageRestorationHelper.findPageRestorationMixin<MainMenuPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.mainMenuPageRestorableRouteFuture.present(restorableRouteFuturePushParameter);
      },
      context: context
    );
  }

  void toRegisterPage(BuildContext context) {
    PageRestorationHelper.findPageRestorationMixin<RegisterPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.registerPageRestorableRouteFuture.present();
      },
      context: context
    );
  }

  void toCropPicturePage(BuildContext context, CropPictureParameter cropPictureParameter) {
    PageRestorationHelper.findPageRestorationMixin<CropPicturePageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.cropPicturePageRestorableRouteFuture.present(
          cropPictureParameter.toEncodeBase64String()
        );
      },
      context: context
    );
  }

  void toProductEntryPage(BuildContext context, ProductEntryPageParameter productEntryPageParameter) {
    PageRestorationHelper.findPageRestorationMixin<ProductEntryPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.productEntryPageRestorableRouteFuture.present(productEntryPageParameter.toEncodeBase64String());
      },
      context: context
    );
  }

  void toProductBundlePage(BuildContext context) {
    PageRestorationHelper.findPageRestorationMixin<ProductBundlePageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.productBundlePageRestorableRouteFuture.present();
      },
      context: context
    );
  }

  void toProductBundleDetailPage(BuildContext context, String productBundleId) {
    PageRestorationHelper.findPageRestorationMixin<ProductBundleDetailPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.productBundleDetailPageRestorableRouteFuture.present(productBundleId);
      },
      context: context
    );
  }

  void toProductDetailPage(BuildContext context, ProductDetailPageParameter productDetailPageParameter) {
    PageRestorationHelper.findPageRestorationMixin<ProductDetailPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.productDetailPageRestorableRouteFuture.present(productDetailPageParameter.toEncodeBase64String());
      },
      context: context
    );
  }

  void toProductBrandPage(BuildContext context) {
    PageRestorationHelper.findPageRestorationMixin<ProductBrandPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.productBrandPageRestorableRouteFuture.present();
      },
      context: context
    );
  }

  void toProductCategoryDetailPage(BuildContext context, String productCategoryId) {
    PageRestorationHelper.findPageRestorationMixin<ProductCategoryDetailPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.productCategoryDetailPageRestorableRouteFuture.present(productCategoryId);
      },
      context: context
    );
  }

  void toCouponPage(BuildContext context, String? couponId) {
    PageRestorationHelper.findPageRestorationMixin<CouponPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        restoration.couponPageRestorableRouteFuture.present(couponId.toEmptyStringNonNull);
      },
      context: context
    );
  }

  void toCartPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<CartPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.cartPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toTakeFriendCartPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<TakeFriendCartPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.takeFriendCartPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toDeliveryPage(BuildContext context, DeliveryPageParameter deliveryPageParameter) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<DeliveryPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.deliveryPageRestorableRouteFuture.present(
            deliveryPageParameter.toEncodeBase64String()
          );
        },
        context: context
      );
    });
  }

  void toWebViewerPage(BuildContext context, Map<String, dynamic> parameter) {
    PageRestorationHelper.findPageRestorationMixin<WebViewerPageRestorationMixin>(
      onGetxPageRestorationFound: (restoration) {
        String parameterString = "";
        parameter.forEach((key, value) {
          late String effectiveKey, effectiveValue;
          if (key == Constant.textUrlKey) {
            effectiveKey = Constant.textEncodedUrlKey;
            effectiveValue = base64.encode(utf8.encode(value));
          } else {
            effectiveKey = key;
            effectiveValue = value;
          }
          parameterString += "${parameterString.isEmpty ? "" : "&"}$effectiveKey=$effectiveValue";
        });
        restoration.webViewerPageRestorableRouteFuture.present(Uri.encodeFull("masterbagasi://webviewer?$parameterString"));
      },
      context: context
    );
  }

  void toAddressPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<AddressPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.addressPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toOrderPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<OrderPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.orderPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toOrderDetailPage(BuildContext context, String orderId) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<OrderDetailPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.orderDetailPageRestorableRouteFuture.present(orderId);
        },
        context: context
      );
    });
  }

  void toDeliveryReviewPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<DeliveryReviewPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.deliveryReviewPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toFavoriteProductBrandPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<FavoriteProductBrandPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.favoriteProductBrandPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toProductDiscussionPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<ProductDiscussionPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.productDiscussionPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toModifyAddressPage(BuildContext context, ModifyAddressPageParameter modifyAddressPageParameter) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<ModifyAddressPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.modifyAddressPageRestorableRouteFuture.present(
            modifyAddressPageParameter.toEncodeBase64String()
          );
        },
        context: context
      );
    });
  }

  void toInboxPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<InboxPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.inboxPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toAffiliatePage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<AffiliatePageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.affiliatePageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toMsmePartnerPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<MsmePartnerPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.msmePartnerPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toCountryDeliveryReviewPage(String countryId, BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<CountryDeliveryReviewPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.countryDeliveryReviewPageRestorableRouteFuture.present(countryId);
        },
        context: context
      );
    });
  }

  void toSearchPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<SearchPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.searchPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toHelpPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<HelpPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.helpPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toHelpChatPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<HelpChatPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.helpChatPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toOrderChatPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<OrderChatPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.orderChatPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }

  void toProductChatPage(String productId, BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<ProductChatPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.productChatPageRestorableRouteFuture.present(productId);
        },
        context: context
      );
    });
  }

  void toCountryDeliveryReviewMediaViewPage(BuildContext context, CountryDeliveryReviewMediaViewPageParameter countryDeliveryReviewMediaViewPageParameter) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<CountryDeliveryReviewMediaViewPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.countryDeliveryReviewMediaViewPageRestorableRouteFuture.present(
            countryDeliveryReviewMediaViewPageParameter.toEncodeBase64String()
          );
        },
        context: context
      );
    });
  }

  void toNotificationPage(BuildContext context) {
    LoginHelper.checkingLogin(context, () {
      PageRestorationHelper.findPageRestorationMixin<NotificationPageRestorationMixin>(
        onGetxPageRestorationFound: (restoration) {
          restoration.notificationPageRestorableRouteFuture.present();
        },
        context: context
      );
    });
  }
}

// ignore: non_constant_identifier_names
final PageRestorationHelper = _PageRestorationHelperImpl();