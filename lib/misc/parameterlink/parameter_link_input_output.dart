abstract class ParameterLinkInputOutput {
  String id;
  String type;
  dynamic otherParameter;

  ParameterLinkInputOutput({
    required this.id,
    required this.type,
    this.otherParameter
  });
}