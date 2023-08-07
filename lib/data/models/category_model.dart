class CategoryModel {
  String categoryId;
  String categoryName;
  String imageUrl;
  String createdAt;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    required this.createdAt,
  });

  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    String? description,
    String? imageUrl,
    String? createdAt,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
      categoryId: jsonData['categoryId'] as String? ?? "",
      categoryName: jsonData['categoryName'] as String? ?? '',
      imageUrl: jsonData['imageUrl'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return ''''
       categoryId : $categoryId,
       categoryName : $categoryName,
       imageUrl : $imageUrl,
       createdAt : $createdAt, 
      ''';
  }
}