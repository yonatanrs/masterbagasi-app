import 'package:get/get.dart';

import '../../controller/base_getx_controller.dart';

class GetxControllerWillBeDeleted<C extends BaseGetxController> {
  String? tag;

  GetxControllerWillBeDeleted({this.tag});

  void delete() {
    Get.delete<C>(tag: tag);
  }

  void deleteWithTagParameter(String? tagParameter) {
    Get.delete<C>(tag: tagParameter);
  }

  static List<GetxControllerWillBeDeleted<C>> single<C extends BaseGetxController>(C controller, {String? tag}) {
    return <GetxControllerWillBeDeleted<C>>[GetxControllerWillBeDeleted<C>(tag: tag)];
  }

  static GetxControllerWillBeDeleted<C> singleNonList<C extends BaseGetxController>(C controller, {String? tag}) {
    return GetxControllerWillBeDeleted<C>(tag: tag);
  }
}

class GetxControllerWillBeDeletedProcessor {
  static void delete(List<GetxControllerWillBeDeleted> controllerWillBeDeleted) {
    for (var element in controllerWillBeDeleted) {
      element.delete();
    }
  }
}