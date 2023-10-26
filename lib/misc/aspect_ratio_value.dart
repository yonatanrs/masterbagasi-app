class AspectRatioValue {
  double width;
  double height;

  AspectRatioValue({
    required this.width,
    required this.height
  });

  double toDouble() {
    return width / height;
  }

  AspectRatioValue copy({
    double? width,
    double? height
  }) {
    return AspectRatioValue(
      width: width ?? this.width,
      height: height ?? this.height
    );
  }
}