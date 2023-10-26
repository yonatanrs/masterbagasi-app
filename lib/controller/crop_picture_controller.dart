import '../misc/error/message_error.dart';
import '../misc/manager/controller_manager.dart';
import '../misc/string_util.dart';
import 'base_getx_controller.dart';

class CropPictureController extends BaseGetxController {
  CropPictureController(ControllerManager? controllerManager) : super(controllerManager);
}

class CropPictureParameter {
  dynamic parameter;
  String picturePath;
  double? cropAspectRatio;

  CropPictureParameter({
    this.parameter,
    required this.picturePath,
    this.cropAspectRatio
  });
}

extension CropPictureParameterExt on CropPictureParameter {
  String toEncodeBase64String() {
    if (!(parameter is String || parameter is Map)) {
      throw MessageError(message: "Parameter must be a string or map");
    }
    return StringUtil.encodeBase64StringFromJson(
      <String, dynamic>{
        if (parameter != null) "parameter": parameter,
        "picture_path": picturePath,
        if (cropAspectRatio != null) "crop_aspect_ratio": cropAspectRatio
      }
    );
  }
}

extension CropPictureParameterStringExt on String {
  CropPictureParameter toCropPictureParameter() {
    dynamic result = StringUtil.decodeBase64StringToJson(this);
    return CropPictureParameter(
      parameter: result["parameter"],
      picturePath: result["picture_path"],
    );
  }
}

class CropPictureResponse {
  dynamic parameter;
  String imagePath;

  CropPictureResponse({
    this.parameter,
    required this.imagePath
  });
}

extension CropPictureResponseExt on CropPictureResponse {
  String toEncodeBase64String() {
    if (!(parameter is String || parameter is Map)) {
      throw MessageError(message: "Parameter must be a string or map");
    }
    return StringUtil.encodeBase64StringFromJson(
      <String, dynamic>{
        if (parameter != null) "parameter": parameter,
        "image_path": imagePath,
      }
    );
  }
}

extension CropPictureResponseStringExt on String {
  CropPictureResponse toCropPictureResponse() {
    dynamic result = StringUtil.decodeBase64StringToJson(this);
    return CropPictureResponse(
      parameter: result["parameter"],
      imagePath: result["image_path"],
    );
  }
}