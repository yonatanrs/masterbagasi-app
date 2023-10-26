import 'cancel_token_map_key.dart';

class StringCancelTokenMapKey extends CancelTokenMapKey {
  String key;
  String? subKey;

  StringCancelTokenMapKey({
    required this.key,
    this.subKey
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringCancelTokenMapKey &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          subKey == other.subKey;

  @override
  int get hashCode => key.hashCode ^ subKey.hashCode;

  StringCancelTokenMapKey copy({
    String? key,
    String? subKey
  }) {
    return StringCancelTokenMapKey(
      key: key ?? this.key,
      subKey: subKey ?? this.subKey
    );
  }
}