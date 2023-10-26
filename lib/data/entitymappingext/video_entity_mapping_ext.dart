import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/video/defaultvideo/default_video.dart';
import '../../domain/entity/video/shortvideo/short_video.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension VideoEntityMappingExt on ResponseWrapper {
  List<DefaultVideo> mapFromResponseToDefaultVideoList() {
    return response.map<DefaultVideo>((defaultVideoResponse) => ResponseWrapper(defaultVideoResponse).mapFromResponseToDefaultVideo()).toList();
  }

  List<ShortVideo> mapFromResponseToShortVideoList() {
    return response.map<ShortVideo>((shortVideoResponse) => ResponseWrapper(shortVideoResponse).mapFromResponseToShortVideo()).toList();
  }

  PagingDataResult<DefaultVideo> mapFromResponseToDefaultVideoPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<DefaultVideo>(
        (defaultVideoResponse) => ResponseWrapper(defaultVideoResponse).mapFromResponseToDefaultVideo()
      ).toList()
    );
  }

  PagingDataResult<ShortVideo> mapFromResponseToShortVideoPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<ShortVideo>(
        (shortVideoResponse) => ResponseWrapper(shortVideoResponse).mapFromResponseToShortVideo()
      ).toList()
    );
  }
}

extension VideoDetailEntityMappingExt on ResponseWrapper {
  DefaultVideo mapFromResponseToDefaultVideo() {
    return DefaultVideo(
      id: response["id"],
      title: response["title"],
      description: response["description"],
      url: response["url"]
    );
  }

  ShortVideo mapFromResponseToShortVideo() {
    return ShortVideo(
      id: response["id"],
      title: response["title"],
      description: response["description"],
      url: response["url"]
    );
  }
}