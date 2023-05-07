import 'package:flutter/material.dart';
import '../SpecificDrink/SpecificDrinkScreen.dart';
import '../data.dart';

class SpecificCategoryScreen extends StatelessWidget {
  const SpecificCategoryScreen({Key? key, required this.categoryWiseDrinks})
      : super(key: key);

  final CategoryWiseDrinks categoryWiseDrinks;

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

  final CategoryWiseDrinks categoryWiseDrinks;

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
      if(constraint.maxWidth >= 1000){ //desktop,web
        columnCount = 4;
        widthRatio = MediaQuery.of(context).size.width / 2.3;
        heightRatio = MediaQuery.of(context).size.height;
        imageWidth = MediaQuery.of(context).size.width / 4;
        imageHeight = MediaQuery.of(context).size.height / 2;
      }else if(constraint.maxWidth < 1440 && constraint.maxWidth > 480){ //tablet
        columnCount = 3;
        widthRatio = MediaQuery.of(context).size.width / 2;
        heightRatio = MediaQuery.of(context).size.height / 1.5;
        imageWidth = MediaQuery.of(context).size.width / 3;
        imageHeight = MediaQuery.of(context).size.height / 2.5;
      }else{  //mobile
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
            return itemCard(drinks: list[index],context:  context,imageWidth: imageWidth,imageHeight: imageHeight);
          });
    });
  }
}

Widget itemCard({required Drinks drinks, required BuildContext context,required double imageWidth,required double imageHeight}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Wrap(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SpecificDrinkScreen(drinkId: drinks.idDrink!)));
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
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null)));
                    },
                  )),
            ),
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
