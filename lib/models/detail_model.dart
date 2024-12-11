class RecipeModel {
  final int id;
  final String title;
  final String photoUrl;
  final int likesCount;
  final int commentsCount;
  final String description;
  final String ingredients;
  final String cookingMethod;

  RecipeModel({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.description,
    required this.ingredients,
    required this.cookingMethod,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      photoUrl: json['photo_url'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      description: json['description'],
      ingredients: json['ingredients'],
      cookingMethod: json['cooking_method'],
    );
  }
}
