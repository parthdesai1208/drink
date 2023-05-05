import 'dart:convert';
import '../data.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  var list = <CategoryWiseDrinks>[];

  Future<List<CategoryWiseDrinks>> fetchCategoryWiseDrinks() async {
   for (var element in category) {
        final response = await http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=$element"));
        if (response.statusCode == 200) {
          list.add(CategoryWiseDrinks.fromJson(jsonDecode(response.body),category: element));
        } else {
          throw Exception("Failed to load");
        }
      }
      return list;
    }
}
