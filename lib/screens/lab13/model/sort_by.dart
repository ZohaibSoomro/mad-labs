import 'product.dart';

class SortByTrigger {
  SortByTrigger._();

  static List<Product> initialSort(List<Product> products) {
    products = sortByUnits(products);
    products = sortByName(products);
    products.sort((p1, p2) {
      if (p1.type == ProductCategory.Eatable &&
          p2.type != ProductCategory.Eatable) {
        return -1;
      }
      if (p2.type == ProductCategory.Eatable &&
          p1.type != ProductCategory.Eatable) {
        return 1;
      }
      if (p1.type == ProductCategory.House_Hold &&
          p2.type != ProductCategory.House_Hold &&
          p2.type != ProductCategory.Eatable) {
        return -1;
      }
      if (p2.type == ProductCategory.House_Hold &&
          p1.type != ProductCategory.House_Hold &&
          p1.type != ProductCategory.Eatable) {
        return 1;
      }
      if (p1.type == ProductCategory.Bathing &&
          p2.type != ProductCategory.Bathing) {
        return 1;
      }
      if (p2.type == ProductCategory.Bathing &&
          p1.type != ProductCategory.Bathing) {
        return -1;
      }
      return 0;
    });

    return products;
  }

  static List<Product> sortByType(List<Product> products) {
    products.sort((p1, p2) {
      return p1.type.name.compareTo(p2.type.name);
    });
    return products;
  }

  static List<Product> sortByFamily(List<Product> products) {
    products.sort((p1, p2) {
      return p1.family.compareTo(p2.family);
    });
    return products;
  }

  static List<Product> sortByUnits(List<Product> products) {
    products.sort((p1, p2) {
      return p1.unit.compareTo(p2.unit);
    });
    return products;
  }

  static List<Product> sortByName(List<Product> products) {
    products.sort((p1, p2) {
      return p1.name.compareTo(p2.name);
    });
    return products;
  }
}
