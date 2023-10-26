import '../../domain/entity/faq/faq.dart';
import '../../domain/entity/faq/faq_list_parameter.dart';
import '../../domain/repository/faq_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/faqdatasource/faq_data_source.dart';

class DefaultFaqRepository implements FaqRepository {
  final FaqDataSource faqDataSource;

  const DefaultFaqRepository({
    required this.faqDataSource
  });

  @override
  FutureProcessing<LoadDataResult<List<Faq>>> faqList(FaqListParameter faqListParameter) {
    return faqDataSource.faqList(faqListParameter).mapToLoadDataResult<List<Faq>>();
  }
}