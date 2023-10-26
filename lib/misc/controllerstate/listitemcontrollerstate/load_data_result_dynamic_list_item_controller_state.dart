import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../errorprovider/error_provider.dart';
import '../../load_data_result.dart';
import 'dynamic_list_item_controller_state.dart';
import 'failed_prompt_indicator_list_item_controller_state.dart';
import 'list_item_controller_state.dart';
import 'loading_list_item_controller_state.dart';
import 'no_content_list_item_controller_state.dart';

typedef OnIsLoadingLoadDataResultListItemControllerState = ListItemControllerState Function(ListItemControllerState);
typedef OnSuccessLoadDataResultListItemControllerState<T> = ListItemControllerState Function(T);
typedef OnFailedLoadDataResultListItemControllerState = ListItemControllerState Function(ErrorProvider, dynamic, ListItemControllerState);
typedef OnNoLoadingLoadDataResultListItemControllerState = ListItemControllerState Function();
typedef OnImplementLoadDataResultDirectlyListItemControllerState<T> = ListItemControllerState Function(LoadDataResult<T>, ErrorProvider);

abstract class BaseLoadDataResultDynamicListItemControllerState<T> extends DynamicListItemControllerState {
  @override
  set listItemControllerState(value) {
    throw Exception("You can only set list item controller state through loadDataResult property.");
  }

  LoadDataResult<T> loadDataResult;
  ErrorProvider errorProvider;

  BaseLoadDataResultDynamicListItemControllerState({
    required this.loadDataResult,
    required this.errorProvider,
  });
}

class LoadDataResultDynamicListItemControllerState<T> extends BaseLoadDataResultDynamicListItemControllerState<T> {
  @override
  ListItemControllerState? get listItemControllerState {
    if (loadDataResult.isLoading) {
      ListItemControllerState defaultLoadingListItemControllerState = LoadingListItemControllerState();
      if (isLoadingListItemControllerState != null) {
        return isLoadingListItemControllerState!(defaultLoadingListItemControllerState);
      } else {
        return defaultLoadingListItemControllerState;
      }
    } else if (loadDataResult.isSuccess) {
      if (successListItemControllerState != null) {
        return successListItemControllerState!(loadDataResult.resultIfSuccess!);
      } else {
        return NoContentListItemControllerState();
      }
    } else if (loadDataResult.isFailed) {
      ListItemControllerState failedPromptIndicatorListItemControllerState = FailedPromptIndicatorListItemControllerState(
        errorProvider: errorProvider,
        e: loadDataResult.resultIfFailed!
      );
      if (failedListItemControllerState != null) {
        return failedListItemControllerState!(errorProvider, loadDataResult.resultIfFailed!, failedPromptIndicatorListItemControllerState);
      } else {
        return failedPromptIndicatorListItemControllerState;
      }
    } else {
      return NoContentListItemControllerState();
    }
  }

  OnNoLoadingLoadDataResultListItemControllerState? isNotLoadingListItemControllerState;
  OnIsLoadingLoadDataResultListItemControllerState? isLoadingListItemControllerState;
  OnSuccessLoadDataResultListItemControllerState<T>? successListItemControllerState;
  OnFailedLoadDataResultListItemControllerState? failedListItemControllerState;

  LoadDataResultDynamicListItemControllerState({
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.isNotLoadingListItemControllerState,
    this.isLoadingListItemControllerState,
    this.successListItemControllerState,
    this.failedListItemControllerState
  }) : super(
    loadDataResult: loadDataResult,
    errorProvider: errorProvider
  );
}

class LoadDataResultDirectlyDynamicListItemControllerState<T> extends BaseLoadDataResultDynamicListItemControllerState<T> {
  @override
  ListItemControllerState? get listItemControllerState {
    if (onImplementLoadDataResultDirectlyListItemControllerState != null) {
      return onImplementLoadDataResultDirectlyListItemControllerState!(loadDataResult, errorProvider);
    } else {
      return NoContentListItemControllerState();
    }
  }

  @override
  set listItemControllerState(value) {
    throw Exception("You can only set list item controller state through loadDataResult property.");
  }

  OnImplementLoadDataResultDirectlyListItemControllerState<T>? onImplementLoadDataResultDirectlyListItemControllerState;

  LoadDataResultDirectlyDynamicListItemControllerState({
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.onImplementLoadDataResultDirectlyListItemControllerState,
  }) : super(
    loadDataResult: loadDataResult,
    errorProvider: errorProvider
  );
}