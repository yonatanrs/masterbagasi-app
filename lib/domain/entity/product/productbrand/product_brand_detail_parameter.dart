enum ProductBrandDetailParameterType {
  id, slug
}

class ProductBrandDetailParameter {
  String productBrandId;
  ProductBrandDetailParameterType productBrandDetailParameterType;

  ProductBrandDetailParameter({
    required this.productBrandId,
    required this.productBrandDetailParameterType
  });
}