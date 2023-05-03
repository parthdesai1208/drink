import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'data.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Drink",
        debugShowCheckedModeBanner: false,
        home: HomeScreenBody());
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
              return firstCardListWrapper(snapshot);
            }));
  }
}

Widget firstCardListWrapper(AsyncSnapshot<CategoryWiseDrinks> data) {
  late Widget child;
  if (data.hasData) {
    child = firstCardList(data.data!);
  } else {
    child = const CircularProgressIndicator();
  }

  return child;
}

Widget firstCardList(CategoryWiseDrinks categoryWiseDrinks) {
  var list = categoryWiseDrinks.drinks;

  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Wrap(
          children:[Card(
              margin: const EdgeInsets.all(16),
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Stack(children: [
                Image.network(list![index].strDrinkThumb!,
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.width,
                fit: BoxFit.fill),
                Positioned(
                    left: 16,
                    right: 16,
                    top: MediaQuery.of(context).size.width - 50,
                    bottom: 8,
                    child: Text(list[index].strDrink!,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)))
              ]))],
        );
      },
      itemCount: list?.length);
}
