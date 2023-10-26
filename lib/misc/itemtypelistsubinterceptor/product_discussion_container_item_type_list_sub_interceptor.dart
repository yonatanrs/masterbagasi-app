import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/domain/entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import 'package:masterbagasi/misc/load_data_result.dart';

import '../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../controllerstate/listitemcontrollerstate/builder_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/loading_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/product_discussion_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/product_discussion_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/productdiscussiondialoglistitemcontrollerstate/product_discussion_dialog_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/productdiscussiondialoglistitemcontrollerstate/vertical_product_discussion_dialog_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/vertical_product_discussion_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../paging/pagingresult/paging_data_result.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class ProductDiscussionContainerItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  ProductDiscussionContainerItemTypeListSubInterceptor({
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
    if (oldItemType is ProductDiscussionContainerListItemControllerState) {
      void getProductDiscussionDialog(PagingDataResult<ProductDiscussionDialog>? productDiscussionDialogPagingDataResult) async {
        if (oldItemType.productDiscussionListItemValueStorage is DefaultProductDiscussionListItemValueStorage) {
          DefaultProductDiscussionListItemValueStorage defaultProductDiscussionListItemValueStorage = oldItemType.productDiscussionListItemValueStorage as DefaultProductDiscussionListItemValueStorage;
          ProductDiscussionContainerActionListItemControllerState productDiscussionContainerActionListItemControllerState = oldItemType.productDiscussionContainerActionListItemControllerState;
          late ProductDiscussionDialogPagingParameter productDiscussionDialogPagingParameter;
          if (productDiscussionDialogPagingDataResult == null) {
            productDiscussionDialogPagingParameter = ProductDiscussionDialogPagingParameter(
              page: 1,
              itemEachPageCount: 10
            );
          } else {
            productDiscussionDialogPagingParameter = ProductDiscussionDialogPagingParameter(
              page: productDiscussionDialogPagingDataResult.page + 1,
              itemEachPageCount: 10
            );
          }
          defaultProductDiscussionListItemValueStorage._productDiscussionDialogLoadDataResult = IsLoadingLoadDataResult<PagingDataResult<ProductDiscussionDialog>>();
          oldItemType.onUpdateState();
          LoadDataResult<PagingDataResult<ProductDiscussionDialog>> productDiscussionDialogLoadDataResult = await productDiscussionContainerActionListItemControllerState.getProductDiscussionDialogPaging(
            productDiscussionDialogPagingParameter
          );
          defaultProductDiscussionListItemValueStorage._productDiscussionDialogLoadDataResult = productDiscussionDialogLoadDataResult;
          if (productDiscussionDialogLoadDataResult.isFailedBecauseCancellation) {
            defaultProductDiscussionListItemValueStorage._productDiscussionDialogLoadDataResult = NoLoadDataResult<PagingDataResult<ProductDiscussionDialog>>();
          }
          if (productDiscussionDialogLoadDataResult.isSuccess) {
            defaultProductDiscussionListItemValueStorage._productDiscussionDialogList.addAll(productDiscussionDialogLoadDataResult.resultIfSuccess!.itemList);
            defaultProductDiscussionListItemValueStorage._lastProductDiscussionDialogPagingDataResult = productDiscussionDialogLoadDataResult.resultIfSuccess!;
            oldItemType.onUpdateState();
          }
        }
      }
      List<VerticalProductDiscussionListItemControllerState> verticalProductDiscussionListItemControllerState = oldItemType.productDiscussionListItemValueList.map<VerticalProductDiscussionListItemControllerState>(
        (productDiscussionListItemValue) => VerticalProductDiscussionListItemControllerState(
          productDiscussion: productDiscussionListItemValue.productDiscussion,
          isExpanded: productDiscussionListItemValue.isExpanded,
          onProductDiscussionTap: (productDiscussion) async {
            productDiscussionListItemValue.isExpanded = !productDiscussionListItemValue.isExpanded;
            oldItemType.onUpdateState();
            if (productDiscussionListItemValue.isExpanded) {
              if (oldItemType.productDiscussionListItemValueStorage is DefaultProductDiscussionListItemValueStorage) {
                DefaultProductDiscussionListItemValueStorage defaultProductDiscussionListItemValueStorage = oldItemType.productDiscussionListItemValueStorage as DefaultProductDiscussionListItemValueStorage;
                PagingDataResult<ProductDiscussionDialog>? lastProductDiscussionDialogPagingDataResult = defaultProductDiscussionListItemValueStorage._lastProductDiscussionDialogPagingDataResult;
                if (lastProductDiscussionDialogPagingDataResult == null) {
                  getProductDiscussionDialog(lastProductDiscussionDialogPagingDataResult);
                }
              }
            }
          }
        )
      ).toList();
      List<ListItemControllerState> newListItemControllerState = [];
      int j = 0;
      while (j < verticalProductDiscussionListItemControllerState.length) {
        ListItemControllerState listItemControllerState = CompoundListItemControllerState(
          listItemControllerState: [
            VirtualSpacingListItemControllerState(height: padding()),
            verticalProductDiscussionListItemControllerState[j],
            if (verticalProductDiscussionListItemControllerState[j].isExpanded)
              CompoundListItemControllerState(
                listItemControllerState: [
                  VerticalProductDiscussionDialogListItemControllerState(
                    productDiscussionDialog: verticalProductDiscussionListItemControllerState[j].productDiscussion.productDiscussionDialog,
                    isMainProductDiscussion: true
                  ),
                  VirtualSpacingListItemControllerState(height: 10),
                  PaddingContainerListItemControllerState(
                    padding: EdgeInsets.symmetric(horizontal: padding()),
                    paddingChildListItemControllerState: TitleAndDescriptionListItemControllerState(
                      title: "${"Answer".tr} (${verticalProductDiscussionListItemControllerState[j].productDiscussion.discussionCount})"
                    ),
                  ),
                  VirtualSpacingListItemControllerState(height: 10),
                  BuilderListItemControllerState(
                    buildListItemControllerState: () {
                      if (oldItemType.productDiscussionListItemValueStorage is DefaultProductDiscussionListItemValueStorage) {
                        DefaultProductDiscussionListItemValueStorage defaultProductDiscussionListItemValueStorage = oldItemType.productDiscussionListItemValueStorage as DefaultProductDiscussionListItemValueStorage;
                        return CompoundListItemControllerState(
                          listItemControllerState: defaultProductDiscussionListItemValueStorage._productDiscussionDialogList.map<ListItemControllerState>((productDiscussionDialog) {
                            return PaddingContainerListItemControllerState(
                              padding: EdgeInsets.only(left: padding()),
                              paddingChildListItemControllerState: VerticalProductDiscussionDialogListItemControllerState(
                                productDiscussionDialog: productDiscussionDialog
                              )
                            );
                          }).toList()
                        );
                      }
                      return NoContentListItemControllerState();
                    }
                  ),
                  BuilderListItemControllerState(
                    buildListItemControllerState: () {
                      if (oldItemType.productDiscussionListItemValueStorage is DefaultProductDiscussionListItemValueStorage) {
                        DefaultProductDiscussionListItemValueStorage defaultProductDiscussionListItemValueStorage = oldItemType.productDiscussionListItemValueStorage as DefaultProductDiscussionListItemValueStorage;
                        if (defaultProductDiscussionListItemValueStorage._productDiscussionDialogLoadDataResult.isLoading) {
                          return CompoundListItemControllerState(
                            listItemControllerState: [
                              VirtualSpacingListItemControllerState(height: 10),
                              LoadingListItemControllerState()
                            ]
                          );
                        }
                      }
                      return NoContentListItemControllerState();
                    }
                  ),
                ]
              ),
            if (j == verticalProductDiscussionListItemControllerState.length - 1) VirtualSpacingListItemControllerState(height: padding())
          ]
        );
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newListItemControllerState
        );
        j++;
      }
      newItemTypeList.addAll(newListItemControllerState);
      return true;
    }
    return false;
  }
}

class DefaultProductDiscussionListItemValueStorage extends ProductDiscussionListItemValueStorage {
  PagingDataResult<ProductDiscussionDialog>? _lastProductDiscussionDialogPagingDataResult;
  LoadDataResult<PagingDataResult<ProductDiscussionDialog>> _productDiscussionDialogLoadDataResult = NoLoadDataResult<PagingDataResult<ProductDiscussionDialog>>();
  List<ProductDiscussionDialog> _productDiscussionDialogList = [];
}

class DefaultProductDiscussionContainerActionListItemControllerState extends ProductDiscussionContainerActionListItemControllerState {
  final Future<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> Function(ProductDiscussionDialogPagingParameter)? _getProductDiscussionDialogPaging;

  DefaultProductDiscussionContainerActionListItemControllerState({
    required Future<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> Function(ProductDiscussionDialogPagingParameter)? getProductDiscussionDialogPaging
  }) : _getProductDiscussionDialogPaging = getProductDiscussionDialogPaging;

  @override
  Future<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> Function(ProductDiscussionDialogPagingParameter) get getProductDiscussionDialogPaging => _getProductDiscussionDialogPaging ?? (throw UnimplementedError());
}