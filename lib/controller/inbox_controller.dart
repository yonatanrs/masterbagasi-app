import '../domain/entity/faq/faq.dart';
import '../domain/entity/faq/faq_list_parameter.dart';
import '../domain/usecase/get_faq_list_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class InboxController extends BaseGetxController {
  final GetFaqListUseCase getFaqListUseCase;

  InboxController(
    super.controllerManager,
    this.getFaqListUseCase
  );

  Future<LoadDataResult<List<Faq>>> getFaqList(FaqListParameter faqListParameter) {
    return getFaqListUseCase.execute(faqListParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("faq").value
    );
  }
}