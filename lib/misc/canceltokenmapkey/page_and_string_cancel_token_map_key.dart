import 'string_cancel_token_map_key.dart';

class PageAndStringCancelTokenMapKey<PageKeyType> extends StringCancelTokenMapKey {
  PageKeyType page;

  PageAndStringCancelTokenMapKey({
    required this.page,
    required String key,
    String? subKey
  }) : super(
    key: key,
    subKey: subKey
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PageAndStringCancelTokenMapKey &&
          runtimeType == other.runtimeType &&
          page == other.page;

  @override
  int get hashCode => super.hashCode ^ page.hashCode;

  @override
  PageAndStringCancelTokenMapKey<PageKeyType> copy({
    PageKeyType? page,
    String? key,
    String? subKey
  }) {
    return PageAndStringCancelTokenMapKey(
      page: page ?? this.page,
      key: key ?? this.key,
      subKey: subKey ?? this.subKey
    );
  }
}