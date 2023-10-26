import '../../domain/entity/summaryvalue/summary_value.dart';
import '../../misc/response_wrapper.dart';

extension SummaryValueEntityMappingExt on ResponseWrapper {
  List<SummaryValue> mapFromResponseToSummaryValueList() {
    if (response is List) {
      return response.map<SummaryValue>(
        (summaryResponse) => ResponseWrapper(summaryResponse).mapFromResponseToSummaryValue()
      ).toList();
    } else if (response is Map) {
      return [ResponseWrapper(response).mapFromResponseToSummaryValue()];
    } else {
      return [];
    }
  }

  SummaryValue mapFromResponseToSummaryValue() {
    return SummaryValue(
      name: response["name"],
      type: response["type"],
      value: response["value"]
    );
  }
}