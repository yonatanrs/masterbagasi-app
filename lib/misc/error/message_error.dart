import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../multi_language_string.dart';

class MessageError extends Error {
  final String title;
  final String message;

  MessageError({this.title = "", this.message = ""});

  @override
  String toString() {
    String messageResult = "";
    void addMessageResult(String value) {
      messageResult += "${messageResult.isEmptyString ? "" : ": "}$value";
    }
    if (!title.isEmptyString) {
      addMessageResult(title);
    }
    if (!message.isEmptyString) {
      addMessageResult(message);
    }
    return messageResult;
  }
}

class MultiLanguageMessageError extends Error {
  final MultiLanguageString title;
  final MultiLanguageString message;

  MultiLanguageMessageError({
    MultiLanguageString? title,
    MultiLanguageString? message
  }) : title = title ?? MultiLanguageString(""),
      message = message ?? MultiLanguageString("");
}