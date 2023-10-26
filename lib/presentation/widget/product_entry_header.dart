import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';

import '../../domain/entity/product/productentry/product_entry_header_content_response.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/product_entry_header_content_response_value.dart';
import '../../domain/entity/product/productentry/productentryheaderresponsevalue/static_product_entry_header_content_response_value.dart';
import '../../misc/constant.dart';
import '../../misc/error/message_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/load_data_result.dart';
import '../../misc/productentryheaderbackground/asset_product_entry_header_background.dart';
import '../../misc/productentryheaderbackground/network_product_entry_header_background.dart';
import '../../misc/productentryheaderbackground/product_entry_header_background.dart';
import 'button/custombutton/sized_outline_gradient_button.dart';
import 'loaddataresultimplementer/load_data_result_implementer.dart';
import 'modified_shimmer.dart';
import 'modifiedcachednetworkimage/product_entry_header_modified_cached_network_image.dart';

typedef OnProductEntryTitleTap = void Function();

class ProductEntryHeader extends StatelessWidget {
  final Widget Function(TextStyle) title;
  final OnProductEntryTitleTap? onProductEntryTitleTap;
  final ProductEntryHeaderBackground productEntryHeaderBackground;

  const ProductEntryHeader({
    super.key,
    required this.title,
    this.onProductEntryTitleTap,
    required this.productEntryHeaderBackground
  });

  @override
  Widget build(BuildContext context) {
    TextStyle getDefaultTextStyle() {
      return TextStyle(
        color: Constant.colorDarkBlue,
        fontWeight: FontWeight.bold
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: Constant.aspectRatioValueProductEntryHeader.toDouble(),
        child: Stack(
          children: [
            Builder(
              builder: (context) {
                if (productEntryHeaderBackground is AssetProductEntryHeaderBackground) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          (productEntryHeaderBackground as AssetProductEntryHeaderBackground).assetImageName,
                        )
                      )
                    ),
                  );
                } else if (productEntryHeaderBackground is NetworkProductEntryHeaderBackground) {
                  return ProductEntryHeaderModifiedCachedNetworkImage(
                    imageUrl: (productEntryHeaderBackground as NetworkProductEntryHeaderBackground).imageUrl,
                  );
                } else {
                  throw MessageError(title: "ProductEntryHeaderBackground is not suitable");
                }
              },
            ),
            Positioned(
              left: Constant.paddingListItem,
              bottom: Constant.paddingListItem,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IgnorePointer(
                        child: ExcludeFocus(
                          child: SizedOutlineGradientButton(
                            onPressed: () {},
                            child: title(getDefaultTextStyle()),
                            text: "",
                            outlineGradientButtonType: OutlineGradientButtonType.outline,
                            outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                            customGradientButtonVariation: (outlineGradientButtonType) {
                              return CustomGradientButtonVariation(
                                outlineGradientButtonType: outlineGradientButtonType,
                                gradient: Constant.buttonGradient2,
                                backgroundColor: Colors.white,
                                textStyle: getDefaultTextStyle()
                              );
                            },
                            customPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

class ProductEntryHeaderLoadDataResult extends StatelessWidget {
  final LoadDataResult<ProductEntryHeaderContentResponse> productEntryHeaderContentResponseLoadDataResult;
  final ErrorProvider errorProvider;

  const ProductEntryHeaderLoadDataResult({
    super.key,
    required this.productEntryHeaderContentResponseLoadDataResult,
    required this.errorProvider
  });

  @override
  Widget build(BuildContext context) {
    return LoadDataResultImplementer<ProductEntryHeaderContentResponse>(
      loadDataResult: productEntryHeaderContentResponseLoadDataResult,
      errorProvider: errorProvider,
      onIsLoadingLoadDataResultWidget: (widget) => IgnorePointer(
        child: ModifiedShimmer.fromColors(
          child: ProductEntryHeader(
            title: (textStyle) => const Text("Loading Sample"),
            onProductEntryTitleTap: null,
            productEntryHeaderBackground: AssetProductEntryHeaderBackground(
              assetImageName: Constant.imageProductViralBackground
            ),
          )
        ),
      ),
      onSuccessLoadDataResultWidget: (productEntryHeaderContentResponse) {
        ProductEntryHeaderContentResponseValue productEntryHeaderContentResponseValue = productEntryHeaderContentResponse.productEntryHeaderContentResponseValue;
        return ProductEntryHeader(
          title: (textStyle) {
            if (productEntryHeaderContentResponseValue is StaticProductEntryHeaderContentResponseValue) {
              return Text(productEntryHeaderContentResponseValue.title, style: textStyle);
            } else {
              return Text("Unknown Result".tr, style: textStyle);
            }
          },
          onProductEntryTitleTap: null,
          productEntryHeaderBackground: AssetProductEntryHeaderBackground(
            assetImageName: productEntryHeaderContentResponseValue is StaticProductEntryHeaderContentResponseValue ? productEntryHeaderContentResponseValue.bannerAssetImageUrl : Constant.imageProductViralBackground
          ),
        );
      },
      onFailedLoadDataResultWidget: (errorProviderValue, e, widget) {
        ErrorProviderResult errorProviderResult = errorProviderValue.onGetErrorProviderResult(e).toErrorProviderResultNonNull();
        return ProductEntryHeader(
          title: (textStyle) => Text(errorProviderResult.title),
          onProductEntryTitleTap: null,
          productEntryHeaderBackground: AssetProductEntryHeaderBackground(
            assetImageName: Constant.imageProductViralBackground
          ),
        );
      },
    );
  }
}