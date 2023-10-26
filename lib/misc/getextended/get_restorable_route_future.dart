import 'package:flutter/material.dart';

import '../../presentation/page/getx_page.dart';

typedef GetxPageCallback = GetxPage Function();

abstract class GetRestorableRouteFuture {
  final String restorationId;

  GetRestorableRouteFuture({
    required this.restorationId
  });

  @protected
  bool checkBeforePresent([Object? arguments]);

  @protected
  void presentIfCheckIsPassed([Object? arguments]);

  void present([Object? arguments]) {
    if (checkBeforePresent(arguments)) {
      presentIfCheckIsPassed(arguments);
    }
  }

  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore);

  void dispose();
}