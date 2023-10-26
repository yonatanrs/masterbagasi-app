abstract class ErrorProvider {
  ErrorProviderResult? onGetErrorProviderResult(dynamic e);
}

class ErrorProviderResult {
  String title;
  String message;
  String imageAssetUrl;

  ErrorProviderResult({
    this.title = "(No Title)",
    this.message = "(No Message)",
    this.imageAssetUrl = ""
  });
}