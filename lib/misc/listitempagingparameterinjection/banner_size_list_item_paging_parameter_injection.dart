import 'package:flutter/cupertino.dart';

import 'list_item_paging_parameter_injection.dart';

class BannerSizeListItemPagingParameterInjection extends ListItemPagingParameterInjection {
  GlobalKey bannerListGlobalKey;

  BannerSizeListItemPagingParameterInjection({
    required this.bannerListGlobalKey
  });
}