import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../date_util.dart';
import '../paging/pagingresult/paging_data_result.dart';
import '../response_wrapper.dart';

extension MainStructureResponseWrapperExt on Response<dynamic> {
  MainStructureResponseWrapper wrapResponse() {
    return MainStructureResponseWrapper.factory(data);
  }
}

extension DateTimeResponseWrapperExt on ResponseWrapper {
  DateTime? mapFromResponseToDateTime({DateFormat? dateFormat}) {
    return response != null ? (dateFormat ?? DateUtil.anthonyInputDateFormat).parse(response) : null;
  }
}

extension PagingResponseWrapperExt on ResponseWrapper {
  PagingDataResult<T> mapFromResponseToPagingDataResult<T>(List<T> Function(dynamic dataResponse) onMapToPagingDataResult) {
    dynamic data = response["data"];
    dynamic currentPage = response["current_page"];
    return PagingDataResult<T>(
      page: currentPage ?? 1,
      totalPage: response["last_page"] ?? 1,
      totalItem: response["total"] ?? -1,
      itemList: onMapToPagingDataResult(data)
    );
  }
}

extension DoubleResponseWrapperExt on ResponseWrapper {
  double? mapFromResponseToDouble() {
    if (response is int) {
      return (response as int).toDouble();
    } else if (response is double) {
      return response;
    } else if (response is String) {
      return double.tryParse(response);
    } else {
      return response;
    }
  }
}