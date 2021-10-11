List<FeatureItemModel> featureModelFromMap(List<dynamic> features) =>
    List<FeatureItemModel>.from(
        features.map((x) => FeatureItemModel.fromJson(x)));

class FeatureItemModel {
  final String label;
  final String value;
  FeatureItemModel(this.label, this.value);

  factory FeatureItemModel.fromJson(var json) =>
      FeatureItemModel(json['label'], json['value']);

  toJson() => {"lable": label, "value": value};
}

List<ProductFeature> productFeatureModelFromMap(List<dynamic> prodFeature) =>
    List<ProductFeature>.from(
        prodFeature.map((x) => ProductFeature.fromJson(x)));

class ProductFeature {
  final String featureName;
  final List<FeatureItemModel> features;
  const ProductFeature(this.featureName, this.features);

  factory ProductFeature.fromJson(var json) => ProductFeature(
      json['featureName'], featureModelFromMap(json['features']));

  toJson() => {
        "featureName": featureName,
        "features": features.map((e) => e.toJson()).toList()
      };
}
