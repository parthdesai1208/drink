import 'package:flutter/material.dart';

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
    var widthRatio = MediaQuery.of(context).size.width / 1.5;
    var heightRatio = MediaQuery.of(context).size.height / 2;
    var aspectRatio = widthRatio / heightRatio;

    return LayoutBuilder(
      builder: (contextBuilder, constraint) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraint.maxWidth > 700 ? 4 : 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: aspectRatio),
            itemCount: list!.length,
            itemBuilder: (context, index) {
              return itemCard(list[index], context);
            });
      }
    );
  }
}

List<Widget> listOfItemCard(List<Drinks> list, BuildContext context) {
  List<Widget> widgetList = [];
  for (var element in list) {
    widgetList.add(itemCard(element, context));
  }
  return widgetList;
}

Widget itemCard(Drinks drinks, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Wrap(
      children: [
        Column(
          children: [
            Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  drinks.strDrinkThumb!,
                  fit: BoxFit.fill,
                  // width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 3,
                )),
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
