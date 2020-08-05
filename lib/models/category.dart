class Category {
  int id;
  String name;
  int color;
  int icon;

  Category({
    this.id,
    this.name,
    this.color,
    this.icon,
  });

  // to map
  Map<String, dynamic> toMap(Category category) {
    Map<String, dynamic> categoryMap = Map();
    categoryMap["id"] = category.id;
    categoryMap["name"] = category.name;
    categoryMap["color"] = category.color;
    categoryMap["icon"] = category.icon;
    return categoryMap;
  }

  // from map
  Category.fromMap(Map categoryMap) {
    this.id = categoryMap["id"];
    this.name = categoryMap["name"];
    this.color = categoryMap["color"];
    this.icon = categoryMap["icon"];
  }
}
