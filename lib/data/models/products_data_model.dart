class ProductsDataModel {
  int id;
  int categoryId;
  String name;
  int price;
  String imageUrl;
  bool isFavorite;

  ProductsDataModel(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false,});

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) =>
      ProductsDataModel(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        price: json["price"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "price": price,
        "image_url": imageUrl,
      };

  copyWith({bool? isFavorite}) {
    return ProductsDataModel(
      id: id,
      categoryId: categoryId,
      name: name,
      price: price,
      imageUrl: imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
