import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/faq/faq.dart';
import '../entity/faq/faq_list_parameter.dart';

abstract class FaqRepository {
  FutureProcessing<LoadDataResult<List<Faq>>> faqList(FaqListParameter faqListParameter);
}