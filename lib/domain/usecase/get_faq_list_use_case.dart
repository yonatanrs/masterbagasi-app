import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/faq/faq.dart';
import '../entity/faq/faq_list_parameter.dart';
import '../repository/faq_repository.dart';

class GetFaqListUseCase {
  final FaqRepository faqRepository;

  const GetFaqListUseCase({
    required this.faqRepository
  });

  FutureProcessing<LoadDataResult<List<Faq>>> execute(FaqListParameter faqListParameter) {
    return faqRepository.faqList(faqListParameter);
  }
}