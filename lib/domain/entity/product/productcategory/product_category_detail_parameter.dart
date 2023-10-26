enum ProductCategoryDetailParameterType {
  id, slug
}

class ProductCategoryDetailParameter {
  ProductCategoryDetailParameterType productCategoryDetailParameterType;
  String productCategoryDetailId;

  ProductCategoryDetailParameter({
    required this.productCategoryDetailParameterType,
    required this.productCategoryDetailId
  });
}