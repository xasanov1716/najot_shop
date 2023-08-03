class CategoriesDataModel {
  final int id;
  final String name;
  final String imageUrl;
  final String createdAt;

  CategoriesDataModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.imageUrl,
  });

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    return CategoriesDataModel(
      id: json["id"] as int? ?? 0,
      name: json["name"] as String? ?? "",
      createdAt: json["created_at"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "created_at": createdAt,
      "image_url": imageUrl,
    };
  }
}
