import '../../../domain/entity/faq/faq.dart';
import '../../../domain/entity/faq/faq_list_parameter.dart';
import '../../../misc/processing/future_processing.dart';

abstract class FaqDataSource {
  FutureProcessing<List<Faq>> faqList(FaqListParameter faqListParameter);
}