import 'package:masterbagasi/misc/parameterlink/parameter_link_input.dart';

import 'constant.dart';
import 'parameterlink/parameter_link_input_output.dart';
import 'parameterlink/parameter_link_output.dart';

class _ParameterLinkHelperImpl {
  ParameterLinkInputOutput _toParameterLinkInputOrOutput(String parameterLink, bool isInput) {
    Uri parameterLinkUri = toUri(parameterLink);
    String id = "";
    String type = "";
    Map<String, dynamic> otherParameter = {};
    parameterLinkUri.queryParameters.forEach((key, value) {
      if (key == Constant.textIdKey) {
        id = value;
      } else if (key == Constant.textTypeKey) {
        type = value;
      } else {
        otherParameter[key] = value;
      }
    });
    if (isInput) {
      return ParameterLinkInput(
        id: id,
        type: type,
        otherParameter: otherParameter
      );
    } else {
      return ParameterLinkOutput(
        id: id,
        type: type,
        otherParameter: otherParameter
      );
    }
  }

  ParameterLinkInput toParameterLinkInput(String parameterLink) {
    return _toParameterLinkInputOrOutput(parameterLink, true) as ParameterLinkInput;
  }

  ParameterLinkOutput toParameterLinkOutput(String parameterLink) {
    return _toParameterLinkInputOrOutput(parameterLink, false) as ParameterLinkOutput;
  }

  Uri toUri(String parameterLink) {
    Uri parameterLinkUri = Uri.parse(parameterLink);
    return parameterLinkUri;
  }
}

// ignore: non_constant_identifier_names
final _ParameterLinkHelperImpl ParameterLinkHelper = _ParameterLinkHelperImpl();