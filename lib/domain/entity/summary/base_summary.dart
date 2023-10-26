import '../summaryvalue/summary_value.dart';

abstract class BaseSummary {
  List<SummaryValue> summaryValue;
  List<SummaryValue> finalSummaryValue;

  BaseSummary({
    required this.summaryValue,
    required this.finalSummaryValue,
  });
}