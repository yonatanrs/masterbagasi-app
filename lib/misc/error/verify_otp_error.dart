import '../constant.dart';
import '../multi_language_string.dart';
import 'message_error.dart';

class VerifyOtpError extends MultiLanguageMessageError {
  VerifyOtpError() : super(
    title: MultiLanguageString({
      Constant.textEnUsLanguageKey: "Verify OTP Failed",
      Constant.textInIdLanguageKey: "Verifikasi OTP Gagal"
    }),
    message: MultiLanguageString({
      Constant.textEnUsLanguageKey: "Verify OTP is failed.",
      Constant.textInIdLanguageKey: "Verify OTP mengalami kegagalan."
    })
  );
}