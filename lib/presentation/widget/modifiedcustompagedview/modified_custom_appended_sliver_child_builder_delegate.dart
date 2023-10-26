import 'dart:math' as math;
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/utils/appended_sliver_child_builder_delegate.dart';

class ModifiedCustomAppendedSliverChildBuilderDelegate extends AppendedSliverChildBuilderDelegate {
  ModifiedCustomAppendedSliverChildBuilderDelegate({
    required bool showOriginalLoaderIndicator,
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder additionalBuilder,
    required int additionalChildCount,
    WidgetBuilder? appendixBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) : super(
    builder: (context, index) {
      if (showOriginalLoaderIndicator) {
        if (appendixBuilder != null) {
          if (index == childCount) {
            return appendixBuilder(context);
          }
        }
      } else {
        if (additionalChildCount > 0) {
          if (index > childCount - 1) {
            return additionalBuilder(context, index);
          }
        }
      }
      return builder(context, index);
    },
    childCount: showOriginalLoaderIndicator ? (appendixBuilder == null ? childCount : childCount + 1) : childCount + additionalChildCount,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: semanticIndexCallback ?? (_, index) => index,
  );

  ModifiedCustomAppendedSliverChildBuilderDelegate.separated({
    required bool showOriginalLoaderIndicator,
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder additionalBuilder,
    required int additionalChildCount,
    required IndexedWidgetBuilder separatorBuilder,
    WidgetBuilder? appendixBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : super(
    builder: (context, index) {
      final itemIndex = index ~/ 2;
      if (index.isEven) {
        return builder(context, itemIndex);
      }
      return separatorBuilder(context, itemIndex);
    },
    childCount: math.max(
      0,
      childCount * 2 - (appendixBuilder != null ? 0 : 1),
    ),
    appendixBuilder: appendixBuilder,
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
  );
}
