import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../modified_shimmer.dart';
import '../shimmer_custom_effect_marker.dart';

typedef TitleAndDescriptionItemInterceptor = Widget Function(EdgeInsetsGeometry? padding, String? title, Widget? titleWidget, String? description, Widget? descriptionWidget, Widget titleAndDescriptionWidget, List<Widget> titleAndDescriptionWidgetList);
typedef TitleInterceptor = Widget Function(String title, TextStyle? lastTitleTextStyle);
typedef DescriptionInterceptor = Widget Function(String description, TextStyle? lastDescriptionTextStyle);

class TitleAndDescriptionItem extends StatelessWidget {
  final String? title;
  final String? description;
  final TitleInterceptor? titleInterceptor;
  final DescriptionInterceptor? descriptionInterceptor;
  final TitleAndDescriptionItemInterceptor? titleAndDescriptionItemInterceptor;
  final EdgeInsetsGeometry? padding;
  final double? verticalSpace;

  const TitleAndDescriptionItem({
    Key? key,
    required this.title,
    required this.description,
    this.titleInterceptor,
    this.descriptionInterceptor,
    this.titleAndDescriptionItemInterceptor,
    required this.padding,
    this.verticalSpace
  }): super(key: key);

  Color? _containerColor(BuildContext context) {
    return ShimmerCustomEffectMarker.of(context) != null ? Colors.black : null;
  }

  Widget _interceptWithContainer(BuildContext context, Widget interceptWidget) {
    return ShimmerCustomEffectMarker.of(context) != null ? Container(
      color: _containerColor(context),
      child: interceptWidget
    ) : interceptWidget;
  }

  @protected
  Widget titleWidget(BuildContext context, String title) {
    TextStyle? lastTitleTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold
    );
    return _interceptWithContainer(
      context,
      titleInterceptor != null ? titleInterceptor!(title, lastTitleTextStyle) : Text(
        title,
        style: lastTitleTextStyle!
      )
    );
  }

  @protected
  Widget descriptionWidget(BuildContext context, String description) {
    TextStyle? lastDescriptionTextStyle = const TextStyle();
    return _interceptWithContainer(
      context,
      descriptionInterceptor != null ? descriptionInterceptor!(description, lastDescriptionTextStyle) : Text(
        description,
        style: lastDescriptionTextStyle
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidgetList = [];
    void addItemToColumnWidgetList(Widget widget) {
      if (columnWidgetList.isNotEmpty) {
        columnWidgetList.add(SizedBox(height: verticalSpace ?? 1.h));
      }
      columnWidgetList.add(widget);
    }
    Widget? titleWidgetResult;
    if (!title.isEmptyString) {
      titleWidgetResult = titleWidget(context, title!);
      addItemToColumnWidgetList(titleWidgetResult);
    }
    Widget? descriptionWidgetResult;
    if (!description.isEmptyString) {
      descriptionWidgetResult = descriptionWidget(context, description!);
      addItemToColumnWidgetList(descriptionWidgetResult);
    }
    Widget column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnWidgetList
    );
    Widget result = padding != null ? Padding(
      padding: padding!,
      child: column,
    ) : column;
    return titleAndDescriptionItemInterceptor != null
      ? titleAndDescriptionItemInterceptor!(padding, title, titleWidgetResult, description, descriptionWidgetResult, result, columnWidgetList)
      : result;
  }
}

class ShimmerTitleAndDescriptionItem extends TitleAndDescriptionItem {
  const ShimmerTitleAndDescriptionItem({
    Key? key,
    required String? title,
    required String? description,
    required EdgeInsetsGeometry? padding,
    double? verticalSpace
  }) : super(
    key: key,
    title: title,
    description: description,
    padding: padding,
    verticalSpace: verticalSpace
  );

  @override
  Widget build(BuildContext context) {
    return ModifiedShimmer.fromColors(
      child: Builder(
        builder: (BuildContext context) => super.build(context)
      )
    );
  }
}