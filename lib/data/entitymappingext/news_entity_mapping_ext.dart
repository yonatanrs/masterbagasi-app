import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../domain/entity/news/news.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/response_wrapper.dart';

extension NewsEntityMappingExt on ResponseWrapper {
  List<News> mapFromResponseToNewsList() {
    return response.map<News>((newsResponse) => ResponseWrapper(newsResponse).mapFromResponseToNews()).toList();
  }

  PagingDataResult<News> mapFromResponseToNewsPaging() {
    return ResponseWrapper(response).mapFromResponseToPagingDataResult(
      (dataResponse) => dataResponse.map<News>(
        (newsResponse) => ResponseWrapper(newsResponse).mapFromResponseToNews()
      ).toList()
    );
  }
}

extension NewsDetailEntityMappingExt on ResponseWrapper {
  News mapFromResponseToNews() {
    return News(
      id: response["id"],
      title: response["title"],
      slug: response["slug"],
      thumbnail: response["thumbnail"],
      body: response["body"],
      status: response["status"]
    );
  }
}