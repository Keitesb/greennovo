class CategoryModel{
  late final String name;

  CategoryModel({
  required this.name
  });

  factory CategoryModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return CategoryModel(
        name: json['name']?.toString() ?? 'Nenhuma categoria',
      );
    } else if (json is String) {
      return CategoryModel(
        name: json,
      );
    } else {
      return CategoryModel(name: 'Nenhuma categoria');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

}