import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../../domain/entity/componententity/dynamic_item_carousel_component_entity.dart';
import '../../../domain/entity/componententity/dynamic_item_carousel_directly_component_entity.dart';
import '../../../domain/entity/componententity/i_component_entity.dart';
import '../../../domain/entity/componententity/i_dynamic_item_carousel_component_entity.dart';
import '../../../domain/entity/delivery/delivery_review.dart';
import '../../../domain/entity/delivery/delivery_review_list_parameter.dart';
import '../../../domain/entity/news/news.dart';
import '../../../domain/entity/video/defaultvideo/default_video.dart';
import '../../../domain/entity/video/shortvideo/short_video.dart';
import '../../../domain/usecase/get_delivery_review_use_case.dart';
import '../../../domain/usecase/get_news_use_case.dart';
import '../../../domain/usecase/get_short_video_use_case.dart';
import '../../../domain/usecase/get_trip_default_video_use_case.dart';
import '../../../misc/constant.dart';
import '../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../misc/error/message_error.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../../misc/multi_language_string.dart';
import '../../../misc/on_observe_load_product_delegate.dart';
import '../../base_getx_controller.dart';

class FeedMainMenuSubController extends BaseGetxController {
  final GetShortVideoUseCase getShortVideoUseCase;
  final GetDeliveryReviewUseCase getDeliveryReviewUseCase;
  final GetNewsUseCase getNewsUseCase;
  final GetTripDefaultVideoUseCase getTripDefaultVideoUseCase;
  FeedMainMenuSubDelegate? _feedMainMenuSubDelegate;

  FeedMainMenuSubController(
    super.controllerManager,
    this.getShortVideoUseCase,
    this.getDeliveryReviewUseCase,
    this.getNewsUseCase,
    this.getTripDefaultVideoUseCase
  );

  IComponentEntity getShortVideoFeed() {
    return DynamicItemCarouselDirectlyComponentEntity(
      title: MultiLanguageString(""),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<ShortVideo>>());
        LoadDataResult<List<ShortVideo>> shortVideoPagingDataResult = await getShortVideoUseCase.execute().future(
          parameter: apiRequestManager.addRequestToCancellationPart("short-video-list").value
        );
        if (shortVideoPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, shortVideoPagingDataResult.map<List<ShortVideo>>(
          (shortVideoList) => shortVideoList
        ));
      },
      observeDynamicItemActionStateDirectly: (title, description, itemLoadDataResult, errorProvider) {
        LoadDataResult<List<ShortVideo>> shortListVideoLoadDataResult = itemLoadDataResult.castFromDynamic<List<ShortVideo>>();
        if (_feedMainMenuSubDelegate != null) {
          return _feedMainMenuSubDelegate!.onObserveLoadShortVideoDirectly(
            _OnObserveLoadShortVideoDirectlyParameter(
              shortVideoListLoadDataResult: shortListVideoLoadDataResult
            )
          );
        } else {
          throw MessageError(title: "Feed main menu sub delegate must be not null");
        }
      },
    );
  }

  IComponentEntity getTripDefaultVideoFeed() {
    return DynamicItemCarouselDirectlyComponentEntity(
      title: MultiLanguageString(""),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<DefaultVideo>>());
        LoadDataResult<List<DefaultVideo>> shortVideoPagingDataResult = await getTripDefaultVideoUseCase.execute().future(
          parameter: apiRequestManager.addRequestToCancellationPart("default-video-list").value
        );
        if (shortVideoPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, shortVideoPagingDataResult.map<List<DefaultVideo>>(
          (defaultVideoList) => defaultVideoList
        ));
      },
      observeDynamicItemActionStateDirectly: (title, description, itemLoadDataResult, errorProvider) {
        LoadDataResult<List<DefaultVideo>> defaultListVideoLoadDataResult = itemLoadDataResult.castFromDynamic<List<DefaultVideo>>();
        if (_feedMainMenuSubDelegate != null) {
          return _feedMainMenuSubDelegate!.onObserveLoadTripDefaultVideoDirectly(
            _OnObserveLoadTripDefaultVideoDirectlyParameter(
              tripDefaultVideoListLoadDataResult: defaultListVideoLoadDataResult
            )
          );
        } else {
          throw MessageError(title: "Feed main menu sub delegate must be not null");
        }
      },
    );
  }

  IDynamicItemCarouselComponentEntity getDeliveryReviewList() {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "Delivery Review",
        Constant.textInIdLanguageKey: "Ulasan Pengiriman"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<DeliveryReview>>());
        LoadDataResult<List<DeliveryReview>> deliveryReviewPagingDataResult = await getDeliveryReviewUseCase.execute().future(
          parameter: apiRequestManager.addRequestToCancellationPart("delivery-review-list").value
        );
        if (deliveryReviewPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, deliveryReviewPagingDataResult.map<List<DeliveryReview>>(
          (productEntryList) => productEntryList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_feedMainMenuSubDelegate != null) {
          return _feedMainMenuSubDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadDeliveryReviewCarousel(
            OnObserveLoadingLoadDeliveryReviewCarouselParameter()
          );
        }
        throw MessageError(title: "Delivery review must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<DeliveryReview> deliveryReviewList = loadDataResult.resultIfSuccess!;
        if (_feedMainMenuSubDelegate != null) {
          return _feedMainMenuSubDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadDeliveryReviewCarousel(
            OnObserveSuccessLoadDeliveryReviewCarouselParameter(
              title: title,
              description: description,
              deliveryReviewList: deliveryReviewList
            )
          );
        }
        throw MessageError(title: "Delivery review must be initialized");
      },
    );
  }

  IDynamicItemCarouselComponentEntity getNewsList() {
    return DynamicItemCarouselComponentEntity(
      title: MultiLanguageString({
        Constant.textEnUsLanguageKey: "News For You",
        Constant.textInIdLanguageKey: "Berita Untukmu"
      }),
      onDynamicItemAction: (title, description, observer) async {
        observer(title, description, IsLoadingLoadDataResult<List<News>>());
        LoadDataResult<List<News>> newsPagingDataResult = await getNewsUseCase.execute().future(
          parameter: apiRequestManager.addRequestToCancellationPart("news-list").value
        );
        if (newsPagingDataResult.isFailedBecauseCancellation) {
          return;
        }
        observer(title, description, newsPagingDataResult.map<List<News>>(
          (newsList) => newsList
        ));
      },
      onObserveLoadingDynamicItemActionState: (title, description, loadDataResult) {
        if (_feedMainMenuSubDelegate != null) {
          return _feedMainMenuSubDelegate!.onObserveLoadProductDelegate.onObserveLoadingLoadNewsCarousel(
            OnObserveLoadingLoadNewsCarouselParameter()
          );
        }
        throw MessageError(title: "News must be initialized");
      },
      onObserveSuccessDynamicItemActionState: (title, description, loadDataResult) {
        List<News> newsList = loadDataResult.resultIfSuccess!;
        if (_feedMainMenuSubDelegate != null) {
          return _feedMainMenuSubDelegate!.onObserveLoadProductDelegate.onObserveSuccessLoadNewsCarousel(
            OnObserveSuccessLoadNewsCarouselParameter(
              title: title,
              description: description,
              newsList: newsList
            )
          );
        }
        throw MessageError(title: "News must be initialized");
      },
    );
  }

  void setFeedMainMenuSubDelegate(FeedMainMenuSubDelegate feedMainMenuSubDelegate) {
    _feedMainMenuSubDelegate = feedMainMenuSubDelegate;
  }
}

class FeedMainMenuSubControllerInjectionFactory {
  final GetShortVideoUseCase getShortVideoUseCase;
  final GetDeliveryReviewUseCase getDeliveryReviewUseCase;
  final GetNewsUseCase getNewsUseCase;
  final GetTripDefaultVideoUseCase getTripDefaultVideoUseCase;

  FeedMainMenuSubControllerInjectionFactory({
    required this.getShortVideoUseCase,
    required this.getDeliveryReviewUseCase,
    required this.getNewsUseCase,
    required this.getTripDefaultVideoUseCase
  });

  FeedMainMenuSubController inject(ControllerManager controllerManager, String pageName) {
    return GetExtended.put<FeedMainMenuSubController>(
      FeedMainMenuSubController(
        controllerManager,
        getShortVideoUseCase,
        getDeliveryReviewUseCase,
        getNewsUseCase,
        getTripDefaultVideoUseCase
      ),
      tag: pageName
    );
  }
}

class FeedMainMenuSubDelegate {
  OnObserveLoadProductDelegate onObserveLoadProductDelegate;
  ListItemControllerState Function(_OnObserveLoadShortVideoDirectlyParameter) onObserveLoadShortVideoDirectly;
  ListItemControllerState Function(_OnObserveLoadTripDefaultVideoDirectlyParameter) onObserveLoadTripDefaultVideoDirectly;

  FeedMainMenuSubDelegate({
    required this.onObserveLoadProductDelegate,
    required this.onObserveLoadShortVideoDirectly,
    required this.onObserveLoadTripDefaultVideoDirectly
  });
}

class _OnObserveLoadShortVideoDirectlyParameter {
  LoadDataResult<List<ShortVideo>> shortVideoListLoadDataResult;

  _OnObserveLoadShortVideoDirectlyParameter({
    required this.shortVideoListLoadDataResult
  });
}

class _OnObserveLoadTripDefaultVideoDirectlyParameter {
  LoadDataResult<List<DefaultVideo>> tripDefaultVideoListLoadDataResult;

  _OnObserveLoadTripDefaultVideoDirectlyParameter({
    required this.tripDefaultVideoListLoadDataResult
  });
}