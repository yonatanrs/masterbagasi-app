import 'package:masterbagasi/misc/ext/future_ext.dart';

import 'constant.dart';
import 'load_data_result.dart';
import 'processing/default_processing.dart';
import 'processing/future_processing.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class _HasVisitedIntroductionPageHelperImpl {
  FutureProcessing<LoadDataResult<void>> saveHasVisitedIntroductionPage(bool hasVisitedIntroductionPage);
  DefaultProcessing<bool> getHasVisitedIntroductionPage();
  FutureProcessing<LoadDataResult<void>> deleteHasVisitedIntroductionPage();
}

class _DefaultHasVisitedIntroductionPageHelperImpl implements _HasVisitedIntroductionPageHelperImpl {
  @override
  FutureProcessing<LoadDataResult<void>> saveHasVisitedIntroductionPage(bool hasVisitedIntroductionPage) {
    return FutureProcessing(({parameter}) {
      var box = Hive.box(Constant.settingHiveTable);
      return box.put(Constant.hasVisitedIntroductionPageHiveTableKey, hasVisitedIntroductionPage).getLoadDataResult();
    });
  }

  @override
  DefaultProcessing<bool> getHasVisitedIntroductionPage() {
    try {
      var box = Hive.box(Constant.settingHiveTable);
      return DefaultProcessing(box.get(Constant.hasVisitedIntroductionPageHiveTableKey, defaultValue: false));
    } catch (e) {
      return DefaultProcessing(false);
    }
  }

  @override
  FutureProcessing<LoadDataResult<void>> deleteHasVisitedIntroductionPage() {
    return FutureProcessing(({parameter}) {
      var box = Hive.box(Constant.settingHiveTable);
      return box.delete(Constant.hasVisitedIntroductionPageHiveTableKey).getLoadDataResult();
    });
  }
}

// ignore: non_constant_identifier_names
final _HasVisitedIntroductionPageHelperImpl HasVisitedIntroductionPageHelper = _DefaultHasVisitedIntroductionPageHelperImpl();