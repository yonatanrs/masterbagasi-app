import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../misc/color_helper.dart';

typedef BackgroundColorInterceptor = Color? Function(BuildContext context, Color? oldBackgroundColor);
typedef TitleInterceptor = Widget? Function(BuildContext context, Widget? oldTitle);
typedef TitleInterceptorWithAdditionalParameter = Widget? Function(BuildContext context, Widget? oldTitle, TitleInterceptorAdditionalParameter titleInterceptorAdditionalParameter);
typedef SystemOverlayStyleInterceptor = SystemUiOverlayStyle? Function(BuildContext context, SystemUiOverlayStyle? oldSystemUiOverlayStyle);
const double _kLeadingWidth = kToolbarHeight; // So the leading button is square.
const double _kMaxTitleTextScaleFactor = 1.34; // TODO(perc): Add link to Material spec when available, https://github.com/flutter/flutter/issues/58769.

class ModifiedAppBar extends AppBar {
  final TitleInterceptor? titleInterceptor;
  final TitleInterceptorWithAdditionalParameter? titleInterceptorWithAdditionalParameter;
  final BackgroundColorInterceptor? backgroundColorInterceptor;
  final SystemOverlayStyleInterceptor? systemOverlayStyleInterceptor;
  final bool attachBrightnessToNavigationToolbar;

  ModifiedAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Widget? title,
    this.titleInterceptor,
    this.titleInterceptorWithAdditionalParameter,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation = 0.0,
    Color? shadowColor,
    ShapeBorder? shape,
    Color? backgroundColor,
    this.backgroundColorInterceptor,
    Color? foregroundColor,
    @Deprecated(
      'This property is no longer used, please use systemOverlayStyle instead. '
      'This feature was deprecated after v2.4.0-0.0.pre.',
    )
    Brightness? brightness,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    @Deprecated(
      'This property is no longer used, please use toolbarTextStyle and titleTextStyle instead. '
      'This feature was deprecated after v2.4.0-0.0.pre.',
    )
    TextTheme? textTheme,
    bool primary = true,
    bool? centerTitle,
    bool excludeHeaderSemantics = false,
    double? titleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
    double? toolbarHeight,
    double? leadingWidth,
    @Deprecated(
      'This property is obsolete and is false by default. '
      'This feature was deprecated after v2.4.0-0.0.pre.',
    )
    bool? backwardsCompatibility,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
    this.systemOverlayStyleInterceptor,
    this.attachBrightnessToNavigationToolbar = true
  }) : super(
        key: key,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title,
        actions: actions,
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        elevation: elevation,
        shadowColor: shadowColor,
        shape: shape,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        brightness: brightness,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,
        textTheme: textTheme,
        primary: primary,
        centerTitle: centerTitle,
        excludeHeaderSemantics: excludeHeaderSemantics,
        titleSpacing: titleSpacing,
        toolbarOpacity: toolbarOpacity,
        bottomOpacity: bottomOpacity,
        toolbarHeight: toolbarHeight,
        leadingWidth: leadingWidth,
        backwardsCompatibility: backwardsCompatibility,
        toolbarTextStyle: toolbarTextStyle,
        titleTextStyle: titleTextStyle,
        systemOverlayStyle: systemOverlayStyle,
      );

  bool _getEffectiveCenterTitle(ThemeData theme) {
    if (centerTitle != null) {
      return centerTitle!;
    }
    if (theme.appBarTheme.centerTitle != null) {
      return theme.appBarTheme.centerTitle!;
    }
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return actions == null || actions!.length < 2;
    }
  }

  @override
  ModifiedAppBarState createState() => ModifiedAppBarState();
}

class ModifiedAppBarState extends State<ModifiedAppBar> {
  static const double _defaultElevation = 4.0;
  static const Color _defaultShadowColor = Color(0xFF000000);

  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
    }
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.addListener(_handleScrollNotification);
    }
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification && widget.notificationPredicate(notification)) {
      final bool oldScrolledUnder = _scrolledUnder;
      final ScrollMetrics metrics = notification.metrics;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          _scrolledUnder = metrics.extentAfter > 0;
          break;
        case AxisDirection.down:
          _scrolledUnder = metrics.extentBefore > 0;
          break;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis.
          _scrolledUnder = false;
          break;
      }
      if (_scrolledUnder != oldScrolledUnder) {
        setState(() {
          // React to a change in MaterialState.scrolledUnder
        });
      }
    }
  }

  Color _resolveColor(Set<MaterialState> states, Color? widgetColor, Color? themeColor, Color defaultColor) {
    return MaterialStateProperty.resolveAs<Color?>(widgetColor, states)
        ?? MaterialStateProperty.resolveAs<Color?>(themeColor, states)
        ?? MaterialStateProperty.resolveAs<Color>(defaultColor, states);
  }

  SystemUiOverlayStyle _systemOverlayStyleForBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
  }

  @override
  Widget build(BuildContext context) {
    assert(!widget.primary || debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final FlexibleSpaceBarSettings? settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final Set<MaterialState> states = <MaterialState>{
      if (settings?.isScrolledUnder ?? _scrolledUnder) MaterialState.scrolledUnder,
    };

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = (parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog) || (parentRoute is PopupRoute<dynamic>);

    final double toolbarHeight = widget.toolbarHeight ?? appBarTheme.toolbarHeight ?? kToolbarHeight;
    final bool backwardsCompatibility = widget.backwardsCompatibility ?? appBarTheme.backwardsCompatibility ?? false;
    final Color effectiveBackgroundColor = widget.backgroundColor ?? theme.canvasColor;
    final Color? interceptedBackgroundColor = widget.backgroundColorInterceptor != null
        ? widget.backgroundColorInterceptor!(context, effectiveBackgroundColor)
        : effectiveBackgroundColor;
    final Color backgroundColor = backwardsCompatibility
        ? interceptedBackgroundColor
        ?? appBarTheme.backgroundColor
        ?? theme.primaryColor
        : _resolveColor(
            states,
            interceptedBackgroundColor,
            appBarTheme.backgroundColor,
            colorScheme.brightness == Brightness.dark ? colorScheme.surface : colorScheme.primary,
          );

    final Color foregroundColor = widget.foregroundColor
        ?? appBarTheme.foregroundColor
        ?? (colorScheme.brightness == Brightness.dark ? colorScheme.onSurface : colorScheme.onPrimary);

    final Color contrastColor = ColorHelper.contrastColorFromBackgroundColor(backgroundColor);

    IconThemeData overallIconTheme = backwardsCompatibility
        ? widget.iconTheme
        ?? appBarTheme.iconTheme
        ?? theme.primaryIconTheme
        : widget.iconTheme
        ?? appBarTheme.iconTheme
        ?? theme.iconTheme.copyWith(color: foregroundColor);

    IconThemeData actionsIconTheme = widget.actionsIconTheme
        ?? appBarTheme.actionsIconTheme
        ?? overallIconTheme;

    TextStyle? toolbarTextStyle = backwardsCompatibility
        ? widget.textTheme?.bodyText2
        ?? appBarTheme.textTheme?.bodyText2
        ?? theme.primaryTextTheme.bodyText2
        : widget.toolbarTextStyle
        ?? appBarTheme.toolbarTextStyle
        ?? theme.textTheme.bodyText2?.copyWith(color: foregroundColor);

    TextStyle? titleTextStyle = backwardsCompatibility
        ? widget.textTheme?.headline6
        ?? appBarTheme.textTheme?.headline6
        ?? theme.primaryTextTheme.headline6
        : widget.titleTextStyle
        ?? appBarTheme.titleTextStyle
        ?? theme.textTheme.headline6?.copyWith(color: foregroundColor);

    if (widget.toolbarOpacity != 1.0) {
      final double opacity = const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.toolbarOpacity);
      if (titleTextStyle?.color != null) {
        titleTextStyle = titleTextStyle!.copyWith(color: titleTextStyle.color!.withOpacity(opacity));
      }
      if (toolbarTextStyle?.color != null) {
        toolbarTextStyle = toolbarTextStyle!.copyWith(color: toolbarTextStyle.color!.withOpacity(opacity));
      }
      overallIconTheme = overallIconTheme.copyWith(
        opacity: opacity * (overallIconTheme.opacity ?? 1.0),
      );
      actionsIconTheme = actionsIconTheme.copyWith(
        opacity: opacity * (actionsIconTheme.opacity ?? 1.0),
      );
    }

    Widget? leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          iconSize: overallIconTheme.size ?? 24,
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (!hasEndDrawer && canPop) {
          leading = useCloseButton ? const CloseButton() : const BackButton();
        }
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: widget.leadingWidth ?? _kLeadingWidth),
        child: leading,
      );
    }

    late Widget? title;
    if (widget.titleInterceptor != null) {
      title = widget.titleInterceptor!(context, widget.title);
    } else if (widget.titleInterceptorWithAdditionalParameter != null) {
      widget.preferredSize.height;
      TitleInterceptorAdditionalParameter titleInterceptorAdditionalParameter = TitleInterceptorAdditionalParameter(
        appBarPreferredSize: widget.preferredSize
      );
      title = widget.titleInterceptorWithAdditionalParameter!(context, widget.title, titleInterceptorAdditionalParameter);
    } else {
      title = widget.title;
    }
    if (title != null) {
      bool? namesRoute;
      switch (theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          namesRoute = true;
          break;
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
      }

      title = _AppBarTitleBox(child: title);
      if (!widget.excludeHeaderSemantics) {
        title = Semantics(
          namesRoute: namesRoute,
          header: true,
          child: title,
        );
      }

      title = DefaultTextStyle(
        style: titleTextStyle!.merge(
          widget.attachBrightnessToNavigationToolbar ? TextStyle(color: contrastColor) : null
        ),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: title,
      );

      // Set maximum text scale factor to [_kMaxTitleTextScaleFactor] for the
      // title to keep the visual hierarchy the same even with larger font
      // sizes. To opt out, wrap the [title] widget in a [MediaQuery] widget
      // with [MediaQueryData.textScaleFactor] set to
      // `MediaQuery.textScaleFactorOf(context)`.
      final MediaQueryData mediaQueryData = MediaQuery.of(context);
      title = MediaQuery(
        data: mediaQueryData.copyWith(
          textScaleFactor: math.min(
            mediaQueryData.textScaleFactor,
            _kMaxTitleTextScaleFactor,
          ),
        ),
        child: title,
      );
    }

    Widget? actions;
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions!,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        iconSize: overallIconTheme.size ?? 24,
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    // Attach with icon theme data based brightness.
    if (leading != null && widget.attachBrightnessToNavigationToolbar) {
      leading = IconTheme.merge(
        data: IconThemeData(color: contrastColor),
        child: leading
      );
    }

    // Allow the trailing actions to have their own theme if necessary.
    if (actions != null) {
      actions = IconTheme.merge(
        data: widget.attachBrightnessToNavigationToolbar ? actionsIconTheme.merge(
          IconThemeData(color: contrastColor)
        ) : actionsIconTheme,
        child: actions,
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: title,
      trailing: actions,
      centerMiddle: widget._getEffectiveCenterTitle(theme),
      middleSpacing: widget.titleSpacing ?? appBarTheme.titleSpacing ?? NavigationToolbar.kMiddleSpacing,
    );

    // If the toolbar is allocated less than toolbarHeight make it
    // appear to scroll upwards within its shrinking container.
    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
        delegate: _ToolbarContainerLayout(toolbarHeight),
        child: IconTheme.merge(
          data: overallIconTheme,
          child: DefaultTextStyle(
            style: toolbarTextStyle!,
            child: toolbar,
          ),
        ),
      ),
    );
    if (widget.bottom != null) {
      appBar = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: toolbarHeight),
              child: appBar,
            ),
          ),
          if (widget.bottomOpacity == 1.0)
            widget.bottom!
          else
            Opacity(
              opacity: const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.bottomOpacity),
              child: widget.bottom,
            ),
        ],
      );
    }

    // The padding applies to the toolbar and tabbar, not the flexible space.
    if (widget.primary) {
      appBar = SafeArea(
        bottom: false,
        child: appBar,
      );
    }

    appBar = Align(
      alignment: Alignment.topCenter,
      child: appBar,
    );

    if (widget.flexibleSpace != null) {
      appBar = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Semantics(
            sortKey: const OrdinalSortKey(1.0),
            explicitChildNodes: true,
            child: widget.flexibleSpace,
          ),
          Semantics(
            sortKey: const OrdinalSortKey(0.0),
            explicitChildNodes: true,
            // Creates a material widget to prevent the flexibleSpace from
            // obscuring the ink splashes produced by appBar children.
            child: Material(
              type: MaterialType.transparency,
              child: appBar,
            ),
          ),
        ],
      );
    }

    final SystemUiOverlayStyle? interceptedOverlayStyle = widget.systemOverlayStyleInterceptor != null
        ? widget.systemOverlayStyleInterceptor!(context, widget.systemOverlayStyle)
        : widget.systemOverlayStyle;
    final SystemUiOverlayStyle overlayStyle = backwardsCompatibility
        ? _systemOverlayStyleForBrightness(
      widget.brightness
          ?? appBarTheme.brightness
          ?? ThemeData.estimateBrightnessForColor(backgroundColor),
    )
        : interceptedOverlayStyle
        ?? appBarTheme.systemOverlayStyle
        ?? _systemOverlayStyleForBrightness(ThemeData.estimateBrightnessForColor(backgroundColor));

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: backgroundColor,
          elevation: widget.elevation
            ?? appBarTheme.elevation
            ?? _defaultElevation,
          shadowColor: widget.shadowColor
            ?? appBarTheme.shadowColor
            ?? _defaultShadowColor,
          shape: widget.shape ?? appBarTheme.shape,
          child: Semantics(
            explicitChildNodes: true,
            child: appBar,
          ),
        ),
      ),
    );
  }
}

// Bottom justify the toolbarHeight child which may overflow the top.
class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout(this.toolbarHeight);

  final double toolbarHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: toolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, toolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) =>
      toolbarHeight != oldDelegate.toolbarHeight;
}

// Layout the AppBar's title with unconstrained height, vertically
// center it within its (NavigationToolbar) parent, and allow the
// parent to constrain the title's actual height.
class _AppBarTitleBox extends SingleChildRenderObjectWidget {
  const _AppBarTitleBox({ Key? key, required Widget child }) : assert(child != null), super(key: key, child: child);

  @override
  _RenderAppBarTitleBox createRenderObject(BuildContext context) {
    return _RenderAppBarTitleBox(
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderAppBarTitleBox renderObject) {
    renderObject.textDirection = Directionality.of(context);
  }
}

class _RenderAppBarTitleBox extends RenderAligningShiftedBox {
  _RenderAppBarTitleBox({
    RenderBox? child,
    TextDirection? textDirection,
  }) : super(child: child, alignment: Alignment.center, textDirection: textDirection);

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final BoxConstraints innerConstraints = constraints.copyWith(maxHeight: double.infinity);
    final Size childSize = child!.getDryLayout(innerConstraints);
    return constraints.constrain(childSize);
  }

  @override
  void performLayout() {
    final BoxConstraints innerConstraints = constraints.copyWith(maxHeight: double.infinity);
    child!.layout(innerConstraints, parentUsesSize: true);
    size = constraints.constrain(child!.size);
    alignChild();
  }
}

class TitleInterceptorAdditionalParameter {
  final Size appBarPreferredSize;

  TitleInterceptorAdditionalParameter({
    required this.appBarPreferredSize
  });
}