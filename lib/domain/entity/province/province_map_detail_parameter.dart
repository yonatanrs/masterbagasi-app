enum ProvinceMapDetailParameterType {
  id, slug
}

class ProvinceMapDetailParameter {
  String provinceMapId;
  ProvinceMapDetailParameterType provinceMapDetailParameterType;

  ProvinceMapDetailParameter({
    required this.provinceMapId,
    required this.provinceMapDetailParameterType
  });
}