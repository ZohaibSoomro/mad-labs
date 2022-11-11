class Product {
  String name, family;
  ProductCategory type;
  int unit;
  Product({
    required this.name,
    required this.type,
    required this.family,
    required this.unit,
  });

  static Product fromJSON(Map<String, dynamic> json) => Product(
        name: json["name"],
        type: ProductCategory.values
            .firstWhere((element) => element.name == json["type"]),
        family: json["family"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJSON() => {
        "name": name,
        "type": type.name,
        "family": family,
        "unit": unit,
      };

  @override
  String toString() {
    return "Product{$name,${type.name},$family,$unit}";
  }
}

enum ProductCategory {
  Eatable,
  House_Hold,
  Bathing,
}
