import 'package:fluttertoast/fluttertoast.dart';

class _ToastHelperImpl {
  void showToast(String text, {Toast toastLength = Toast.LENGTH_SHORT, int timeInSecForIosWeb = 1}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: timeInSecForIosWeb,
      fontSize: 16.0
    );
  }
}

// ignore: non_constant_identifier_names
final _ToastHelperImpl ToastHelper = _ToastHelperImpl();