import '../../controller/base_getx_controller.dart';
import '../getextended/getx_controller_will_be_deleted.dart';

class ControllerManager {
  late List<ControllerMember> _controllerMemberList;
  int _addControllerMemberCalledCount = 0;
  int get addControllerMemberCalledCount => _addControllerMemberCalledCount;

  ControllerManager() {
    _controllerMemberList = <ControllerMember>[];
  }

  void addControllerMember(ControllerMember controllerMember) {
    _controllerMemberList.add(controllerMember);
    markControllerMemberHasBeenAdded();
  }

  void addAllControllerMember(List<ControllerMember> controllerMemberList) {
    _controllerMemberList.addAll(controllerMemberList);
    markControllerMemberHasBeenAdded();
  }

  void markControllerMemberHasBeenAdded() {
    _addControllerMemberCalledCount += 1;
  }

  List<GetxControllerWillBeDeleted> toGetxControllerWillBeDeletedList() {
    return _controllerMemberList.map(
      (controllerMember) => controllerMember.getxControllerWillBeDeleted
    ).toList();
  }

  ControllerMember getControllerMember(int index) {
    return _controllerMemberList[index];
  }

  void dispose() {
    for (var element in _controllerMemberList) {
      String? tagParameter = element.controller.tag;
      element.getxControllerWillBeDeleted.deleteWithTagParameter(tagParameter);
    }
    _controllerMemberList.clear();
  }
}

class ControllerMember<C extends BaseGetxController> {
  C? _controller;
  set controller(C value) => _controller = value;
  C get controller {
   if (_controller == null) {
     throw Exception("Controller must be assigned.");
   }
   return _controller!;
  }
  late final GetxControllerWillBeDeleted<C> getxControllerWillBeDeleted;
  final dynamic additionalParameter;

  ControllerMember({this.additionalParameter}) {
    getxControllerWillBeDeleted = GetxControllerWillBeDeleted<C>();
  }
}

extension ControllerMemberExt<C extends BaseGetxController> on ControllerMember<C> {
  ControllerMember<C> addToControllerManager(ControllerManager controllerManager) {
    controllerManager.addControllerMember(this);
    return this;
  }
}