import 'dart:convert'; 
import 'package:resepmakanan_5a/models/recipe_model.dart'; 
import 'package:resepmakanan_5a/services/session_service.dart'; 
import 'package:http/http.dart' as http; 

class RecipeService {
  final SessionService _sessionService = SessionService(); 
  static const String baseUrl = 'https://recipe.incube.id/api'; 

  Future<RecipeModel> getRecipeById(int recipeId) async {
    final token = await _sessionService.getToken();

    if (token == null || token.isEmpty) {
      throw Exception("Token tidak ditemukan");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/recipes/$recipeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];

      return RecipeModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception("Resep tidak ditemukan");
    } else {
      throw Exception("Gagal memuat resep");
    }
  }
}