import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entity/cart/cart.dart';
import '../../../domain/entity/cart/support_cart.dart';
import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../domain/entity/product/productentry/product_entry.dart';
import '../../../domain/entity/product/productvariant/product_variant.dart';
import '../../../misc/constant.dart';
import '../check_list_item.dart';
import '../modified_svg_picture.dart';
import '../modifiedcachednetworkimage/product_modified_cached_network_image.dart';
import '../tap_area.dart';

abstract class CartItem extends StatelessWidget {
  final Cart cart;
  final bool isSelected;
  final bool showDefaultCart;
  final bool showCheck;
  final void Function()? onChangeSelected;
  final void Function()? onAddToNotes;
  final void Function()? onChangeNotes;
  final void Function()? onRemoveFromNotes;
  final void Function()? onAddToWishlist;
  final void Function()? onRemoveCart;
  final void Function(int)? onChangeQuantity;

  @protected
  double? get itemWidth;

  @protected
  double? get itemHeight;

  const CartItem({
    super.key,
    required this.cart,
    required this.isSelected,
    required this.showDefaultCart,
    required this.onChangeSelected,
    this.showCheck = true,
    this.onAddToNotes,
    this.onChangeNotes,
    this.onRemoveFromNotes,
    this.onAddToWishlist,
    this.onRemoveCart,
    this.onChangeQuantity
  });

  @override
  Widget build(BuildContext context) {
    return CheckListItem(
      value: isSelected,
      showCheck: showCheck,
      title: Row(
        children: [
          SizedBox(
            width: 70,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                child: ProductModifiedCachedNetworkImage(
                  imageUrl: cart.supportCart.cartImageUrl,
                )
              )
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Builder(
              builder: (context) {
                List<Widget> columnWidget = [];
                SupportCart supportCart = cart.supportCart;
                if (supportCart is ProductEntry) {
                  ProductEntry productEntry = supportCart;
                  List<ProductVariant> productVariantList = productEntry.productVariantList;
                  String productVariantDescription = "";
                  if (productVariantList.isNotEmpty) {
                    int j = 0;
                    for (ProductVariant productVariant in productVariantList) {
                      productVariantDescription += "${(j > 0 ? ", " : "")}${productVariant.type} (${productVariant.name})";
                      j++;
                    }
                  }
                  columnWidget.addAll(<Widget>[
                    Text(productEntry.name),
                    if (productEntry.product.productCategory.name.isNotEmptyString)
                      ...[
                        const SizedBox(height: 5),
                        Text(productEntry.product.productCategory.name.toEmptyStringNonNull, style: const TextStyle(color: Colors.grey)),
                      ],
                    if (productVariantDescription.isNotEmptyString)
                      ...[
                        const SizedBox(height: 10),
                        Text(productVariantDescription, style: const TextStyle(color: Colors.grey)),
                      ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productEntry.sellingPrice.toRupiah(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        Text(
                          "${productEntry.weight} Kg",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        if (!showDefaultCart)
                          ...[
                            Text(
                              " | ${"Quantity".tr} ${cart.quantity}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                      ]
                    )
                  ]);
                } else if (supportCart is ProductBundle) {
                  ProductBundle productBundle = supportCart;
                  columnWidget.addAll(<Widget>[
                    Text(productBundle.name),
                    const SizedBox(height: 10),
                    Text(
                      productBundle.price.toRupiah(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ]);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columnWidget
                );
              }
            ),
          )
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onAddToNotes != null) ...[
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    children: [
                      TapArea(
                        onTap: onAddToNotes,
                        child: Text(
                          cart.notes.isEmptyString ? "Add Notes".tr : cart.notes.toEmptyStringNonNull,
                          style: TextStyle(
                            color: cart.notes.isEmptyString ? Theme.of(context).colorScheme.primary : Colors.black
                          )
                        )
                      ),
                    ]
                  )
                ),
              ]
            ),
            const SizedBox(height: 10.0),
            if (cart.notes.isNotEmptyString)
              Row(
                children: [
                  TapArea(
                    onTap: onChangeNotes != null ? () => onChangeNotes!() : null,
                    child: Text(
                      "Change Notes".tr,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                      )
                    )
                  ),
                  const SizedBox(width: 10),
                  TapArea(
                    onTap: onRemoveFromNotes != null ? () => onRemoveFromNotes!() : null,
                    child: Text(
                      "Remove Notes".tr,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                      )
                    )
                  ),
                ]
              )
          ],
          if (showDefaultCart) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TapArea(
                  onTap: onAddToWishlist,
                  child: Text("Add To Wishlist".tr),
                ),
                const SizedBox(width: 20),
                const Text("|"),
                const SizedBox(width: 20),
                TapArea(
                  onTap: onRemoveCart,
                  child: ModifiedSvgPicture.asset(
                    Constant.vectorTrash,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(width: 20),
                TapArea(
                  onTap: onChangeQuantity != null ? () => onChangeQuantity!(cart.quantity - 1) : null,
                  child: ModifiedSvgPicture.asset(
                    Constant.vectorMinusCircle,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(width: 20),
                Text(cart.quantity.toString()),
                const SizedBox(width: 20),
                TapArea(
                  onTap: onChangeQuantity != null ? () => onChangeQuantity!(cart.quantity + 1) : null,
                  child: ModifiedSvgPicture.asset(
                    Constant.vectorPlusCircle,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            )
          ]
        ],
      ),
      onChanged: onChangeSelected != null ? (bool? value) => onChangeSelected!() : null,
      reverse: true,
      spaceBetweenCheckListAndTitle: 4.w,
      spaceBetweenTitleAndContent: showDefaultCart ? 4.w : 0.0,
    );
  }
}