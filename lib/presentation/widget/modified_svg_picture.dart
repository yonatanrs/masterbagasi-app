import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ModifiedSvgPicture extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  PictureProvider? _preDefinedPictureProvider;
  final WidgetBuilder? placeholderBuilder;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;
  _ColorFilterParameter? _colorFilterParameter;
  ColorFilter? _colorFilter;
  final bool cacheColorFilter;
  final SvgTheme? theme;
  Color? _color;
  _ModifiedSvgPictureParameter? _modifiedSvgPictureParameter;
  final bool _overrideDefaultColorWithSingleColor;

  ModifiedSvgPicture(
    PictureProvider pictureProvider, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    ColorFilter? colorFilter,
    bool overrideDefaultColorWithSingleColor = true,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
  }) : _colorFilter = colorFilter,
      _overrideDefaultColorWithSingleColor = overrideDefaultColorWithSingleColor,
      _preDefinedPictureProvider = pictureProvider,
      super(key: key);

  ModifiedSvgPicture.asset(String assetName, {
    Key? key,
    this.matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    Color? color,
    bool overrideDefaultColorWithSingleColor = true,
    BlendMode colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
  }) : _modifiedSvgPictureParameter = _AssetModifiedSvgPictureParameter(
      assetName: assetName,
      color: color,
      colorBlendMode: colorBlendMode,
      bundle: bundle,
      package: package
    ),
    _colorFilterParameter = _ColorFilterParameter(color: color, colorBlendMode: colorBlendMode),
    _colorFilter = _getColorFilter(color, colorBlendMode),
    _overrideDefaultColorWithSingleColor = overrideDefaultColorWithSingleColor,
    _color = color,
    super(key: key);

  ModifiedSvgPicture.network(String url, {
    Key? key,
    Map<String, String>? headers,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    Color? color,
    bool overrideDefaultColorWithSingleColor = true,
    BlendMode colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
  }) : _modifiedSvgPictureParameter = _NetworkModifiedSvgPictureParameter(
      url: url,
      headers: headers,
      color: color,
      colorBlendMode: colorBlendMode,
    ),
    _colorFilterParameter = _ColorFilterParameter(color: color, colorBlendMode: colorBlendMode),
    _colorFilter = _getColorFilter(color, colorBlendMode),
    _overrideDefaultColorWithSingleColor = overrideDefaultColorWithSingleColor,
    _color = color,
    super(key: key);

  ModifiedSvgPicture.file(File file, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    Color? color,
    bool overrideDefaultColorWithSingleColor = true,
    BlendMode colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
  }) : _modifiedSvgPictureParameter = _FileModifiedSvgPictureParameter(
      file: file,
      color: color,
      colorBlendMode: colorBlendMode,
    ),
    _colorFilterParameter = _ColorFilterParameter(color: color, colorBlendMode: colorBlendMode),
    _colorFilter = _getColorFilter(color, colorBlendMode),
    _overrideDefaultColorWithSingleColor = overrideDefaultColorWithSingleColor,
    _color = color,
    super(key: key);

  ModifiedSvgPicture.memory(Uint8List bytes, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    Color? color,
    bool overrideDefaultColorWithSingleColor = true,
    BlendMode colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
  }) : _modifiedSvgPictureParameter = _MemoryModifiedSvgPictureParameter(
      bytes: bytes,
      color: color,
      colorBlendMode: colorBlendMode,
    ),
    _colorFilterParameter = _ColorFilterParameter(color: color, colorBlendMode: colorBlendMode),
    _colorFilter = _getColorFilter(color, colorBlendMode),
    _overrideDefaultColorWithSingleColor = overrideDefaultColorWithSingleColor,
    _color = color,
    super(key: key);

  ModifiedSvgPicture.string(String string, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    Color? color,
    bool overrideDefaultColorWithSingleColor = true,
    BlendMode colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.theme,
  }) : _modifiedSvgPictureParameter = _StringModifiedSvgPictureParameter(
      string: string,
      color: color,
      colorBlendMode: colorBlendMode,
    ),
    _colorFilterParameter = _ColorFilterParameter(color: color, colorBlendMode: colorBlendMode),
    _colorFilter = _getColorFilter(color, colorBlendMode),
    _overrideDefaultColorWithSingleColor = overrideDefaultColorWithSingleColor,
    _color = color,
    super(key: key);

  // ignore: prefer_function_declarations_over_variables
  static WidgetBuilder defaultPlaceholderBuilder = (BuildContext ctx) => const LimitedBox();

  static ColorFilter? _getColorFilter(Color? color, BlendMode colorBlendMode) {
    return color == null ? null : ColorFilter.mode(color, colorBlendMode);
  }

  // ignore: prefer_function_declarations_over_variables
  static final PictureInfoDecoderBuilder<Uint8List> svgByteDecoderBuilder = (SvgTheme theme) {
    return (Uint8List bytes, ColorFilter? colorFilter, String key) => svg.svgPictureDecoder(
      bytes,
      false,
      colorFilter,
      key,
      theme: theme,
    );
  };

  // ignore: prefer_function_declarations_over_variables
  static final PictureInfoDecoderBuilder<String> svgStringDecoderBuilder = (SvgTheme theme) {
    return (String data, ColorFilter? colorFilter, String key) => svg.svgPictureStringDecoder(
      data,
      false,
      colorFilter,
      key,
      theme: theme,
    );
  };

  // ignore: prefer_function_declarations_over_variables
  static final PictureInfoDecoderBuilder<Uint8List> svgByteDecoderOutsideViewBoxBuilder = (SvgTheme theme) {
    return (Uint8List bytes, ColorFilter? colorFilter, String key) => svg.svgPictureDecoder(
      bytes,
      true,
      colorFilter,
      key,
      theme: theme,
    );
  };

  // ignore: prefer_function_declarations_over_variables
  static final PictureInfoDecoderBuilder<String> svgStringDecoderOutsideViewBoxBuilder = (SvgTheme theme) {
    return (String data, ColorFilter? colorFilter, String key) => svg.svgPictureStringDecoder(
      data,
      true,
      colorFilter,
      key,
      theme: theme,
    );
  };

  @override
  Widget build(BuildContext context) {
    PictureProvider? pictureProvider;
    if (_preDefinedPictureProvider != null) {
      pictureProvider = _preDefinedPictureProvider;
    } else {
      if (_color == null) {
        if (_overrideDefaultColorWithSingleColor) {
          IconThemeData iconThemeData = IconTheme.of(context);
          _colorFilterParameter = _colorFilterParameter?.copy(color: iconThemeData.color);
        }
        if (_colorFilterParameter != null) {
          _colorFilter = _getColorFilter(_colorFilterParameter!.color, _colorFilterParameter!.colorBlendMode);
        }
      }
      if (_modifiedSvgPictureParameter is _AssetModifiedSvgPictureParameter) {
        _AssetModifiedSvgPictureParameter assetModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _AssetModifiedSvgPictureParameter;
        pictureProvider = ExactAssetPicture(
          allowDrawingOutsideViewBox == true ? svgStringDecoderOutsideViewBoxBuilder : svgStringDecoderBuilder,
          assetModifiedSvgPictureParameter.assetName,
          bundle: assetModifiedSvgPictureParameter.bundle,
          package: assetModifiedSvgPictureParameter.package,
          colorFilter: svg.cacheColorFilterOverride ?? cacheColorFilter ? _colorFilter : null,
        );
      } else if (_modifiedSvgPictureParameter is _NetworkModifiedSvgPictureParameter) {
        _NetworkModifiedSvgPictureParameter networkModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _NetworkModifiedSvgPictureParameter;
        pictureProvider = NetworkPicture(
          allowDrawingOutsideViewBox == true ? svgByteDecoderOutsideViewBoxBuilder : svgByteDecoderBuilder,
          networkModifiedSvgPictureParameter.url,
          headers: networkModifiedSvgPictureParameter.headers,
          colorFilter: svg.cacheColorFilterOverride ?? cacheColorFilter ? _colorFilter : null,
        );
      } else if (_modifiedSvgPictureParameter is _FileModifiedSvgPictureParameter) {
        _FileModifiedSvgPictureParameter fileModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _FileModifiedSvgPictureParameter;
        pictureProvider = FilePicture(
          allowDrawingOutsideViewBox == true ? svgByteDecoderOutsideViewBoxBuilder : svgByteDecoderBuilder,
          fileModifiedSvgPictureParameter.file,
          colorFilter: svg.cacheColorFilterOverride ?? cacheColorFilter ? _colorFilter : null,
        );
      } else if (_modifiedSvgPictureParameter is _MemoryModifiedSvgPictureParameter) {
        _MemoryModifiedSvgPictureParameter memoryModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _MemoryModifiedSvgPictureParameter;
        pictureProvider = MemoryPicture(
          allowDrawingOutsideViewBox == true ? svgByteDecoderOutsideViewBoxBuilder : svgByteDecoderBuilder,
          memoryModifiedSvgPictureParameter.bytes,
          colorFilter: svg.cacheColorFilterOverride ?? cacheColorFilter ? _colorFilter : null,
        );
      } else if (_modifiedSvgPictureParameter is _StringModifiedSvgPictureParameter) {
        _StringModifiedSvgPictureParameter stringModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _StringModifiedSvgPictureParameter;
        pictureProvider = StringPicture(
          allowDrawingOutsideViewBox == true ? svgStringDecoderOutsideViewBoxBuilder : svgStringDecoderBuilder,
          stringModifiedSvgPictureParameter.string,
          colorFilter: svg.cacheColorFilterOverride ?? cacheColorFilter ? _colorFilter : null,
        );
      } else {
        throw FlutterError("Not picture provider is assigned");
      }
    }
    return SvgPicture(
      pictureProvider!,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      colorFilter: _colorFilter,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  ModifiedSvgPicture copy({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    bool? matchTextDirection,
    bool? allowDrawingOutsideViewBox,
    WidgetBuilder? placeholderBuilder,
    ColorFilter? colorFilter,
    Color? color,
    bool? overrideDefaultColorWithSingleColor,
    BlendMode? colorBlendMode,
    String? semanticsLabel,
    bool? excludeFromSemantics,
    Clip? clipBehavior,
    bool? cacheColorFilter,
    SvgTheme? theme,
  }) {
    if (_preDefinedPictureProvider != null) {
      return ModifiedSvgPicture(
        _preDefinedPictureProvider!,
        key: key ?? this.key,
        width: width ?? this.width,
        height: height ?? this.height,
        fit: fit ?? this.fit,
        alignment: alignment ?? this.alignment,
        matchTextDirection: matchTextDirection ?? this.matchTextDirection,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
        placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
        colorFilter: colorFilter ?? _colorFilter,
        overrideDefaultColorWithSingleColor: overrideDefaultColorWithSingleColor ?? _overrideDefaultColorWithSingleColor,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
        clipBehavior: clipBehavior ?? this.clipBehavior,
        cacheColorFilter: cacheColorFilter ?? this.cacheColorFilter,
        theme: theme ?? this.theme
      );
    } else {
      if (_modifiedSvgPictureParameter is _AssetModifiedSvgPictureParameter) {
        _AssetModifiedSvgPictureParameter assetModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _AssetModifiedSvgPictureParameter;
        return ModifiedSvgPicture.asset(
          assetModifiedSvgPictureParameter.assetName,
          key: key ?? this.key,
          bundle: assetModifiedSvgPictureParameter.bundle,
          package: assetModifiedSvgPictureParameter.package,
          width: width ?? this.width,
          height: height ?? this.height,
          fit: fit ?? this.fit,
          alignment: alignment ?? this.alignment,
          matchTextDirection: matchTextDirection ?? this.matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
          color: color ?? _color,
          colorBlendMode: colorBlendMode ?? assetModifiedSvgPictureParameter.colorBlendMode,
          overrideDefaultColorWithSingleColor: overrideDefaultColorWithSingleColor ?? _overrideDefaultColorWithSingleColor,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
          clipBehavior: clipBehavior ?? this.clipBehavior,
          cacheColorFilter: cacheColorFilter ?? this.cacheColorFilter,
          theme: theme ?? this.theme
        );
      } else if (_modifiedSvgPictureParameter is _NetworkModifiedSvgPictureParameter) {
        _NetworkModifiedSvgPictureParameter networkModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _NetworkModifiedSvgPictureParameter;
        return ModifiedSvgPicture.network(
          networkModifiedSvgPictureParameter.url,
          key: key ?? this.key,
          headers: networkModifiedSvgPictureParameter.headers,
          width: width ?? this.width,
          height: height ?? this.height,
          fit: fit ?? this.fit,
          alignment: alignment ?? this.alignment,
          matchTextDirection: matchTextDirection ?? this.matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
          color: color ?? _color,
          colorBlendMode: colorBlendMode ?? networkModifiedSvgPictureParameter.colorBlendMode,
          overrideDefaultColorWithSingleColor: overrideDefaultColorWithSingleColor ?? _overrideDefaultColorWithSingleColor,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
          clipBehavior: clipBehavior ?? this.clipBehavior,
          cacheColorFilter: cacheColorFilter ?? this.cacheColorFilter,
          theme: theme ?? this.theme
        );
      } else if (_modifiedSvgPictureParameter is _FileModifiedSvgPictureParameter) {
        _FileModifiedSvgPictureParameter fileModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _FileModifiedSvgPictureParameter;
        return ModifiedSvgPicture.file(
          fileModifiedSvgPictureParameter.file,
          key: key ?? this.key,
          width: width ?? this.width,
          height: height ?? this.height,
          fit: fit ?? this.fit,
          alignment: alignment ?? this.alignment,
          matchTextDirection: matchTextDirection ?? this.matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
          color: color ?? _color,
          colorBlendMode: colorBlendMode ?? fileModifiedSvgPictureParameter.colorBlendMode,
          overrideDefaultColorWithSingleColor: overrideDefaultColorWithSingleColor ?? _overrideDefaultColorWithSingleColor,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
          clipBehavior: clipBehavior ?? this.clipBehavior,
          cacheColorFilter: cacheColorFilter ?? this.cacheColorFilter,
          theme: theme ?? this.theme
        );
      } else if (_modifiedSvgPictureParameter is _MemoryModifiedSvgPictureParameter) {
        _MemoryModifiedSvgPictureParameter memoryModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _MemoryModifiedSvgPictureParameter;
        return ModifiedSvgPicture.memory(
          memoryModifiedSvgPictureParameter.bytes,
          key: key ?? this.key,
          width: width ?? this.width,
          height: height ?? this.height,
          fit: fit ?? this.fit,
          alignment: alignment ?? this.alignment,
          matchTextDirection: matchTextDirection ?? this.matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
          color: color ?? _color,
          colorBlendMode: colorBlendMode ?? memoryModifiedSvgPictureParameter.colorBlendMode,
          overrideDefaultColorWithSingleColor: overrideDefaultColorWithSingleColor ?? _overrideDefaultColorWithSingleColor,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
          clipBehavior: clipBehavior ?? this.clipBehavior,
          cacheColorFilter: cacheColorFilter ?? this.cacheColorFilter,
          theme: theme ?? this.theme
        );
      } else if (_modifiedSvgPictureParameter is _StringModifiedSvgPictureParameter) {
        _StringModifiedSvgPictureParameter stringModifiedSvgPictureParameter = _modifiedSvgPictureParameter as _StringModifiedSvgPictureParameter;
        return ModifiedSvgPicture.string(
          stringModifiedSvgPictureParameter.string,
          key: key ?? this.key,
          width: width ?? this.width,
          height: height ?? this.height,
          fit: fit ?? this.fit,
          alignment: alignment ?? this.alignment,
          matchTextDirection: matchTextDirection ?? this.matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? this.allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder ?? this.placeholderBuilder,
          color: color ?? _color,
          colorBlendMode: colorBlendMode ?? stringModifiedSvgPictureParameter.colorBlendMode,
          overrideDefaultColorWithSingleColor: overrideDefaultColorWithSingleColor ?? _overrideDefaultColorWithSingleColor,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
          clipBehavior: clipBehavior ?? this.clipBehavior,
          cacheColorFilter: cacheColorFilter ?? this.cacheColorFilter,
          theme: theme ?? this.theme
        );
      } else {
        throw FlutterError("Not picture provider is assigned");
      }
    }
  }
}

class _ModifiedSvgPictureParameter {
  final Color? color;
  final BlendMode colorBlendMode;

  _ModifiedSvgPictureParameter({
    this.color,
    this.colorBlendMode = BlendMode.srcIn
  });
}

class _AssetModifiedSvgPictureParameter extends _ModifiedSvgPictureParameter {
  final String assetName;
  final AssetBundle? bundle;
  final String? package;

  _AssetModifiedSvgPictureParameter({
    required this.assetName,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    this.bundle,
    this.package
  }) : super(color: color, colorBlendMode: colorBlendMode);
}

class _NetworkModifiedSvgPictureParameter extends _ModifiedSvgPictureParameter {
  final String url;
  final Map<String, String>? headers;

  _NetworkModifiedSvgPictureParameter({
    required this.url,
    this.headers,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) : super(color: color, colorBlendMode: colorBlendMode);
}

class _FileModifiedSvgPictureParameter extends _ModifiedSvgPictureParameter {
  final File file;

  _FileModifiedSvgPictureParameter({
    required this.file,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) : super(color: color, colorBlendMode: colorBlendMode);
}

class _MemoryModifiedSvgPictureParameter extends _ModifiedSvgPictureParameter {
  final Uint8List bytes;

  _MemoryModifiedSvgPictureParameter({
    required this.bytes,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) : super(color: color, colorBlendMode: colorBlendMode);
}

class _StringModifiedSvgPictureParameter extends _ModifiedSvgPictureParameter {
  String string;

  _StringModifiedSvgPictureParameter({
    required this.string,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) : super(color: color, colorBlendMode: colorBlendMode);
}

class _ColorFilterParameter {
  Color? color;
  BlendMode colorBlendMode;

  _ColorFilterParameter({
    this.color,
    required this.colorBlendMode
  });

  _ColorFilterParameter copy({
    Color? color,
    BlendMode? colorBlendMode
  }) {
    return _ColorFilterParameter(
      color: color ?? this.color,
      colorBlendMode: colorBlendMode ?? this.colorBlendMode
    );
  }
}