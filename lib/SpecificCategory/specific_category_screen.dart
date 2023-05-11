import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../DrinkData.dart' as drink2;
import '../SpecificDrink/SpecificDrinkScreen.dart';
import '../data.dart' as drink1;
import '../data.dart';

class SpecificCategoryScreen extends StatelessWidget {
  const SpecificCategoryScreen({Key? key, required this.categoryWiseDrinks})
      : super(key: key);

  final drink1.CategoryWiseDrinks categoryWiseDrinks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              child: const Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context)),
          title: Text(categoryWiseDrinks.category,
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      body: SpecificCategoryScreenBody(categoryWiseDrinks: categoryWiseDrinks),
    );
  }
}

class SpecificCategoryScreenBody extends StatefulWidget {
  const SpecificCategoryScreenBody({Key? key, required this.categoryWiseDrinks})
      : super(key: key);

  final drink1.CategoryWiseDrinks categoryWiseDrinks;

  @override
  State<SpecificCategoryScreenBody> createState() =>
      _SpecificCategoryScreenBodyState();
}

class _SpecificCategoryScreenBodyState
    extends State<SpecificCategoryScreenBody> {
  @override
  Widget build(BuildContext context) {
    var list = widget.categoryWiseDrinks.drinks;

    return LayoutBuilder(builder: (contextBuilder, constraint) {
      var columnCount = 0;
      var widthRatio = 0.0;
      var heightRatio = 0.0;
      var imageWidth = 0.0;
      var imageHeight = 0.0;
      if (constraint.maxWidth >= 1000) {
        //desktop,web
        columnCount = 4;
        widthRatio = MediaQuery.of(context).size.width / 2.3;
        heightRatio = MediaQuery.of(context).size.height;
        imageWidth = MediaQuery.of(context).size.width / 4;
        imageHeight = MediaQuery.of(context).size.height / 2;
      } else if (constraint.maxWidth < 1440 && constraint.maxWidth > 480) {
        //tablet
        columnCount = 3;
        widthRatio = MediaQuery.of(context).size.width / 2;
        heightRatio = MediaQuery.of(context).size.height / 1.5;
        imageWidth = MediaQuery.of(context).size.width / 3;
        imageHeight = MediaQuery.of(context).size.height / 2.5;
      } else {
        //mobile
        columnCount = 2;
        widthRatio = MediaQuery.of(context).size.width / 1.5;
        heightRatio = MediaQuery.of(context).size.height / 2;
        imageWidth = MediaQuery.of(context).size.width / 2;
        imageHeight = MediaQuery.of(context).size.height / 3;
      }

      var aspectRatio = widthRatio / heightRatio;

      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              childAspectRatio: aspectRatio),
          itemCount: list!.length,
          itemBuilder: (context, index) {
            return itemCard(
                drinks: list[index],
                context: context,
                imageWidth: imageWidth,
                imageHeight: imageHeight,
                constraint: constraint);
          });
    });
  }
}

Widget itemCard(
    {required Drinks drinks,
    required BuildContext context,
    required double imageWidth,
    required double imageHeight,
    required BoxConstraints constraint}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Wrap(
      children: [
        Column(
          children: [
            ResponsiveBuilder(builder:
                (BuildContext context, SizingInformation sizingInformation) {
              return GestureDetector(
                onTap: () {
                  if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.desktop &&
                      sizingInformation.screenSize.width > 1050) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: commonBlocProviderForSpecificDrink(drinkId: drinks.idDrink!, isLargerSize: true));
                        });
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SpecificDrinkScreen(drinkId: drinks.idDrink!)));
                  }
                },
                child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(
                      drinks.strDrinkThumb!,
                      fit: BoxFit.fill,
                      width: imageWidth,
                      height: imageHeight,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                            width: imageWidth,
                            height: imageHeight,
                            child: Center(
                                child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null)));
                      },
                    )),
              );
            }),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(drinks.strDrink!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget drinkScreenForDialog(
    drink2.DrinkClass drinkClass, BuildContext context) {
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

  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.25,
    height: double.maxFinite,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        Image.network(drinkClass.drinks![0].strDrinkThumb!,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.fill,
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
            right: 16,
            // left: 16,
            top: 16,
            child: Container(
              decoration: const ShapeDecoration(
                  color: Colors.grey, shape: CircleBorder()),
              child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, size: 32)),
            ))
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
      )
    ]),
  );
}
