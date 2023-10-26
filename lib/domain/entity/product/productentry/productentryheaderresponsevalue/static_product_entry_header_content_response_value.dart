import 'product_entry_header_content_response_value.dart';

class StaticProductEntryHeaderContentResponseValue extends ProductEntryHeaderContentResponseValue {
  String bannerAssetImageUrl;
  String title;

  StaticProductEntryHeaderContentResponseValue({
    required this.bannerAssetImageUrl,
    required this.title
  });
}