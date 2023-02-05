class CategoryModel{
  String id;
  String categoryName;

  CategoryModel({
    this.id='',
    required this.categoryName,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'id': id,
    };
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'],
      id: json['id'],
    );
  }
}