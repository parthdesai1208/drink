import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Drink", home: HomeScreenBody());
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

Future<CategoryWiseDrinks> fetchCategoryWiseDrinks() async {
  final response = await http.get(Uri.parse(
      "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=${category[0]}"));
  if (response.statusCode == 200) {
    return CategoryWiseDrinks.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  late Future<CategoryWiseDrinks> categoryWiseDrinks;

  @override
  void initState() {
    super.initState();
    categoryWiseDrinks = fetchCategoryWiseDrinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<CategoryWiseDrinks>(
            future: categoryWiseDrinks,
            builder: (context, snapshot) {
              return Center(child: firstCardListWrapper());
            }));
  }
}

Widget firstCardListWrapper(AsyncSnapshot<CategoryWiseDrinks> data){
    late Widget child;
    if(data.hasData){
      child = FirstCardList(data.data!);
    }else{
      child = const CircularProgressIndicator();
    }

    return Center(child: child);
}

Widget FirstCardList(CategoryWiseDrinks categoryWiseDrinks){
    return Card(child: Image(image: Image.network(categoryWiseDrinks.drinks)))
}