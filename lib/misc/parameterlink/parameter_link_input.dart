import 'parameter_link_input_output.dart';

class ParameterLinkInput extends ParameterLinkInputOutput {
  ParameterLinkInput({
    required String id,
    required String type,
    dynamic otherParameter
  }) : super(id: id, type: type, otherParameter: otherParameter);
}