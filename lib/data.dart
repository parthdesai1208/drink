
import 'package:equatable/equatable.dart';

var category = ["Ordinary Drink","Cocktail","Shake","Other / Unknown","Cocoa","Shot","Coffee / Tea","Homemade Liqueur","Punch / Party Drink","Beer","Soft Drink"];

class CategoryWiseDrinks with EquatableMixin {
  List<Drinks>? drinks;
  String category = "";

  CategoryWiseDrinks({this.drinks,required this.category});

  CategoryWiseDrinks.fromJson(Map<String, dynamic> json, {required String category}) {
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(Drinks.fromJson(v));
      });
    }
    if(category.isNotEmpty){
      this.category = category;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (drinks != null) {
      data['drinks'] = drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [drinks];
}

class Drinks with EquatableMixin{
  String? strDrink;
  String? strDrinkThumb;
  String? idDrink;

  Drinks({this.strDrink, this.strDrinkThumb, this.idDrink});

  Drinks.fromJson(Map<String, dynamic> json) {
    strDrink = json['strDrink'];
    strDrinkThumb = json['strDrinkThumb'];
    idDrink = json['idDrink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strDrink'] = strDrink;
    data['strDrinkThumb'] = strDrinkThumb;
    data['idDrink'] = idDrink;
    return data;
  }

  @override
  List<Object?> get props => [strDrink,strDrinkThumb,idDrink];
}
