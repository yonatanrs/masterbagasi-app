import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/address/address.dart';
import '../controllerstate/listitemcontrollerstate/addresslistitemcontrollerstate/address_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/addresslistitemcontrollerstate/vertical_address_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'coupon_item_type_list_sub_interceptor.dart';
import 'item_type_list_sub_interceptor.dart';

class AddressItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  AddressItemTypeListSubInterceptor({
    required this.padding,
    required this.itemSpacing,
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
    if (oldItemType is AddressContainerListItemControllerState) {
      DefaultAddressContainerStorageListItemControllerState defaultAddressContainerStorageListItemControllerState = oldItemType.addressContainerStorageListItemControllerState as DefaultAddressContainerStorageListItemControllerState;
      if (!defaultAddressContainerStorageListItemControllerState._hasInitSelectedAddress) {
        defaultAddressContainerStorageListItemControllerState._hasInitSelectedAddress = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          for (var iteratedAddress in oldItemType.address) {
            if (iteratedAddress.isPrimary == 1) {
              if (oldItemType.onSelectAddress != null) {
                oldItemType.onSelectAddress!(iteratedAddress);
                break;
              }
            }
          }
        });
      }
      var addressContainerInterceptingActionListItemControllerState = oldItemType.addressContainerInterceptingActionListItemControllerState;
      if (addressContainerInterceptingActionListItemControllerState is DefaultAddressContainerInterceptingActionListItemControllerState) {
        addressContainerInterceptingActionListItemControllerState._removeAddress = (address) {
          int l = 0;
          while (l < oldItemType.address.length) {
            if (oldItemType.address[l].id == address.id) {
              oldItemType.address.removeAt(l);
              break;
            }
            l++;
          }
          oldItemType.onUpdateState();
        };
      }
      List<ListItemControllerState> resultListItemControllerStateList = oldItemType.address.mapIndexed<ListItemControllerState>(
        (index, address) {
          return CompoundListItemControllerState(
            listItemControllerState: [
              VirtualSpacingListItemControllerState(
                height: padding()
              ),
              PaddingContainerListItemControllerState(
                padding: EdgeInsets.symmetric(horizontal: padding()),
                paddingChildListItemControllerState: VerticalAddressListItemControllerState(
                  address: address,
                  onSelectAddress: (address) {
                    for (var iteratedAddress in oldItemType.address) {
                      iteratedAddress.isPrimary = 0;
                    }
                    address.isPrimary = 1;
                    oldItemType.onUpdateState();
                    if (oldItemType.onSelectAddress != null) {
                      oldItemType.onSelectAddress!(address);
                    }
                  },
                  onRemoveAddress: oldItemType.onRemoveAddress
                )
              ),
              if (index == oldItemType.address.length - 1)
                VirtualSpacingListItemControllerState(
                  height: padding()
                ),
            ]
          );
        }
      ).toList();
      for (var listItemControllerState in resultListItemControllerStateList) {
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newItemTypeList
        );
      }
      return true;
    }
    return false;
  }
}

class DefaultAddressContainerStorageListItemControllerState extends AddressContainerStorageListItemControllerState {
  bool _hasInitSelectedAddress = false;
}

class DefaultAddressContainerInterceptingActionListItemControllerState extends AddressContainerInterceptingActionListItemControllerState {
  void Function(Address)? _removeAddress;

  @override
  void Function(Address)? get removeAddress => _removeAddress ?? (throw UnimplementedError());
}