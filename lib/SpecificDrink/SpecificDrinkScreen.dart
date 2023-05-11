import 'package:drink/DrinkData.dart';
import 'package:drink/SpecificDrink/DrinkRepository.dart';
import 'package:drink/SpecificDrink/bloc/DrinkBloc.dart';
import 'package:drink/SpecificDrink/bloc/DrinkEvent.dart';
import 'package:drink/SpecificDrink/bloc/DrinkState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SpecificCategory/specific_category_screen.dart';

class SpecificDrinkScreen extends StatelessWidget {
  const SpecificDrinkScreen({Key? key, required this.drinkId})
      : super(key: key);

  final String drinkId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SpecificDrinkScreenBody(drinkId: drinkId));
  }
}

class SpecificDrinkScreenBody extends StatefulWidget {
  const SpecificDrinkScreenBody({Key? key, required this.drinkId})
      : super(key: key);

  final String drinkId;

  @override
  State<SpecificDrinkScreenBody> createState() =>
      _SpecificDrinkScreenBodyState();
}

class _SpecificDrinkScreenBodyState extends State<SpecificDrinkScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: commonBlocProviderForSpecificDrink(
            drinkId: widget.drinkId, isLargerSize: false),
        floatingActionButton: Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.yellow)),
                child: const Text("Start mixing"))));
  }
}

Widget commonBlocProviderForSpecificDrink(
    {required String drinkId, required bool isLargerSize}) {
  return BlocProvider(
      create: (context) =>
          DrinkBloc(DrinkRepository(drinkId))..add(DrinkLoadEvent()),
      child: BlocBuilder<DrinkBloc, DrinkState>(builder: (context, state) {
        if (state is DrinkLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DrinkLoadedState) {
          if (isLargerSize) {
            return drinkScreenForDialog(state.drinkClass, context);
          } else {
            return drinkScreen(state.drinkClass, context);
          }
        } else if (state is DrinkErrorState) {
          return Center(child: Text(state.error));
        } else {
          return Container();
        }
      }));
}

Widget drinkScreen(DrinkClass drinkClass, BuildContext context) {
  var ingredientList = [];
  if (drinkClass.drinks![0].strIngredient1 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient1);
  }
  if (drinkClass.drinks![0].strIngredient2 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient2);
  }
  if (drinkClass.drinks![0].strIngredient3 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient3);
  }
  if (drinkClass.drinks![0].strIngredient4 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient4);
  }
  if (drinkClass.drinks![0].strIngredient5 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient5);
  }
  if (drinkClass.drinks![0].strIngredient6 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient6);
  }
  if (drinkClass.drinks![0].strIngredient7 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient7);
  }
  if (drinkClass.drinks![0].strIngredient8 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient8);
  }
  if (drinkClass.drinks![0].strIngredient9 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient9);
  }
  if (drinkClass.drinks![0].strIngredient10 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient10);
  }
  if (drinkClass.drinks![0].strIngredient11 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient11);
  }
  if (drinkClass.drinks![0].strIngredient12 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient12);
  }
  if (drinkClass.drinks![0].strIngredient13 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient13);
  }
  if (drinkClass.drinks![0].strIngredient14 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient14);
  }
  if (drinkClass.drinks![0].strIngredient15 != null) {
    ingredientList.add(drinkClass.drinks![0].strIngredient15);
  }

  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(fit: StackFit.passthrough, children: [
        Image.network(drinkClass.drinks![0].strDrinkThumb!,
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.maxFinite,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                  child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null)));
        }),
        Positioned(
            left: 16,
            top: 36,
            child: Container(
              decoration: const ShapeDecoration(
                  color: Colors.grey, shape: CircleBorder()),
              child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, size: 32)),
            )),
        Positioned(
          left: 16,
          bottom: 16,
          right: 0,
          child: SizedBox(
              width: double.maxFinite,
              child: Text(
                drinkClass.drinks![0].strDrink!,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              )),
        )
      ]),
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
        child: Text("Ingredients",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Text(ingredientList[index]);
            },
            itemCount: ingredientList.length),
      ),
    ]),
  );
}
