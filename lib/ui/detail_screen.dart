import 'package:flutter/material.dart';
import 'package:resepmakanan_5a/models/recipe_model.dart';
import 'package:resepmakanan_5a/services/detail_services.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int recipeId;
  final bool initialIsLiked;
  final int initialLikesCount;

  RecipeDetailScreen({
    required this.recipeId,
    required this.initialIsLiked,
    required this.initialLikesCount,
  });

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<RecipeModel> recipeDetail;
  final RecipeService _recipeService = RecipeService();

  late bool _isLiked;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
    _likesCount = widget.initialLikesCount;

    recipeDetail = _recipeService.getRecipeById(widget.recipeId);
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked; 
      if (_isLiked) {
        _likesCount += 1;
      } else {
        _likesCount -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, {
              'isLiked': _isLiked,
              'likesCount': _likesCount,
            });
          },
        ),
      ),
      body: FutureBuilder<RecipeModel>(
        future: recipeDetail, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (!snapshot.hasData) {
            return Center(child: Text('Tidak ada data'));
          }
          else {
            final recipe = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(recipe.photoUrl),
                    SizedBox(height: 16),

                    Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleLike, 
                          child: Icon(
                            _isLiked ? Icons.star : Icons.star_border,
                            color: _isLiked ? Colors.yellow : Colors.grey,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text("$_likesCount likes"),
                        SizedBox(width: 16),
                        Icon(Icons.comment),
                        SizedBox(width: 4),
                        Text("${recipe.commentsCount} comments"),
                      ],
                    ),
                    SizedBox(height: 16),

                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(recipe.description),
                    SizedBox(height: 16),

                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(recipe.ingredients),
                    SizedBox(height: 16),

                    Text(
                      'Steps',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(recipe.cookingMethod),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}