import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/news/news.dart';
import '../entity/news/news_paging_parameter.dart';
import '../repository/feed_repository.dart';

class GetNewsUseCase {
  final FeedRepository feedRepository;

  const GetNewsUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<List<News>>> execute() {
    return feedRepository.newsPaging(
      NewsPagingParameter(page: 1, itemEachPageCount: 10)
    ).map<LoadDataResult<List<News>>>(
      onMap: (newsPagingDataResult) {
        return newsPagingDataResult.map<List<News>>(
          (newsPaging) => newsPaging.itemList
        );
      }
    );
  }
}