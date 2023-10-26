import 'parameter_link_input_output.dart';

class ParameterLinkOutput extends ParameterLinkInputOutput {
  ParameterLinkOutput({
    required String id,
    required String type,
    dynamic otherParameter
  }) : super(id: id, type: type, otherParameter: otherParameter);
}