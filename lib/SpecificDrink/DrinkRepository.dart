import 'dart:convert';

import '../DrinkData.dart';
import 'package:http/http.dart' as http;

class DrinkRepository{

  final String drinkId;
  DrinkRepository(this.drinkId);

  Future<DrinkClass> fetchSpecificDrink() async {
    final response = await http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$drinkId"));
    if (response.statusCode == 200) {
      return DrinkClass.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to load");
    }
  }

}