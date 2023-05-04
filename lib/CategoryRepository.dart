import 'dart:convert';
import 'data.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  var list = <CategoryWiseDrinks>[];

  Future<List<CategoryWiseDrinks>> fetchCategoryWiseDrinks() async {

    final response = await http.get(Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[0]}"));
    if (response.statusCode == 200) {
      list.add(CategoryWiseDrinks.fromJson(jsonDecode(response.body)));
    } else {
      throw Exception("Failed to load");
    }

    /*var response = await Future.wait([
      http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[0]}")),
      http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[1]}")),
      http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[2]}")),
      http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[3]}")),
      http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[4]}"))
    ]);
    response.forEach((element) {
      if(element.statusCode == 200){
        list.add(CategoryWiseDrinks.fromJson(jsonDecode(element.body)));
      }else{
        throw Exception("Failed to load");
      }
    });*/
   /*category.forEach((element) async {
        final response = await  http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=$element"));
        if (response.statusCode == 200) {
          list.add(CategoryWiseDrinks.fromJson(jsonDecode(response.body)));
        } else {
          throw Exception("Failed to load");
        }
      });*/
      return list;
    }
}
