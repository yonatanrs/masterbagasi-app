import 'modified_app_bar.dart';

class OpacityModifiedAppBar extends ModifiedAppBar {
  final double value;

  OpacityModifiedAppBar({
    super.key,
    this.value = 1.0,
    super.leading,
    super.automaticallyImplyLeading = true,
    super.title,
    super.titleInterceptor,
    super.titleInterceptorWithAdditionalParameter,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation = 0.0,
    super.shadowColor,
    super.shape,
    super.backgroundColor,
    super.backgroundColorInterceptor,
    super.foregroundColor,
    super.brightness,
    super.iconTheme,
    super.actionsIconTheme,
    super.textTheme,
    super.primary = true,
    super.centerTitle,
    super.excludeHeaderSemantics = false,
    super.titleSpacing,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.toolbarHeight,
    super.leadingWidth,
    super.backwardsCompatibility,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.systemOverlayStyleInterceptor,
    super.attachBrightnessToNavigationToolbar = true
  });

  @override
  BackgroundColorInterceptor get backgroundColorInterceptor {
    return (context, oldColor) => oldColor?.withOpacity(value);
  }
}