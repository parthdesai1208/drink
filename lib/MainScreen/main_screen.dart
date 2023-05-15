import 'package:carousel_slider/carousel_slider.dart';
import 'package:drink/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../SpecificCategory/specific_category_screen.dart';
import 'CategoryRepository.dart';
import '../data.dart';
import 'bloc/CategoryEvent.dart';
import 'bloc/CategoryBloc.dart';
import 'bloc/categoryState.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Drink",
        theme: ThemeData(
            brightness: Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        debugShowCheckedModeBanner: false,
        home: const HomeScreenBody());
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) =>
                CategoryBloc(CategoryRepository())..add(CategoryLoadEvent()),
            child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoryLoadedState) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListView(
                      children: commonCardListWrapper(
                              state.categoryWiseDrink, context)
                          .insertBetweenAll(const SizedBox(height: 20))),
                );
              } else if (state is CategoryErrorState) {
                return Center(child: Text(state.error));
              } else {
                return Container();
              }
            })));
  }
}

List<Widget> commonCardListWrapper(
    List<CategoryWiseDrinks> data, BuildContext context) {
  List<Widget> child = <Widget>[];
  child.add(carouselSliderWidget(data.first, context));
  for (var element in data) {
    child.add(horizontalCardList(element, context));
  }
  child.removeAt(1);
  return child;
}

Widget carouselSliderWidget(
    CategoryWiseDrinks categoryWiseDrinks, BuildContext context) {
  var carouselCardData = categoryWiseDrinks.drinks;
  var imageWidth = MediaQuery.of(context).size.width * 0.95;
  var imageHeight = MediaQuery.of(context).size.height * 0.50;
  var currentPos = 0;

  return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        children: [
                  CarouselSlider(
            items: carouselCardData!
                  .take(3)
                  .map((e) => Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Image.network(e.strDrinkThumb!,
                            width: imageWidth,
                            height: imageHeight,
                            fit: BoxFit.cover,
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
                                        : null)),
                          );
                        }),
                      ))
                  .toList(),
            options: CarouselOptions(onPageChanged: (index, reason) {

            },
                  viewportFraction: 1.0,
                  height: imageHeight,
                  autoPlay: false,
                  autoPlayAnimationDuration: const Duration(seconds: 5),
                  enableInfiniteScroll: false)),
                  Positioned(right: 8,bottom: 8,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,children: carouselCardData.take(3).map((e) {
                      var index = carouselCardData.indexOf(e);
                    return Container(decoration: BoxDecoration(shape: BoxShape.circle,color: currentPos == index ? Colors.grey : Colors.white));
                    }).toList()),
                  )
                ],
      ));
}

Widget horizontalCardList(
    CategoryWiseDrinks categoryWiseDrinks, BuildContext context) {
  var list = categoryWiseDrinks.drinks;

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            flex: 2,
            child: Text(categoryWiseDrinks.category,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            flex: 1,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpecificCategoryScreen(
                              categoryWiseDrinks: categoryWiseDrinks)));
                },
                child: const Text("View All",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey))),
          )
        ]),
      ),
      LayoutBuilder(
        builder: (contextBuilder, constraint) {
          var sizedBoxHeight = 0.0;
          var imageWidth = 0.0;
          var imageHeight = 0.0;
          if (constraint.maxWidth >= 1000) {
            sizedBoxHeight = MediaQuery.of(context).size.width * 0.35;
            imageWidth = MediaQuery.of(context).size.width * 0.31;
            imageHeight = MediaQuery.of(context).size.width * 0.31;
          } else if (constraint.maxWidth < 1440 && constraint.maxWidth > 480) {
            sizedBoxHeight = MediaQuery.of(context).size.width * 0.32;
            imageWidth = MediaQuery.of(context).size.width * 0.29;
            imageHeight = MediaQuery.of(context).size.width * 0.32;
          } else {
            sizedBoxHeight = MediaQuery.of(context).size.height * 0.57;
            imageWidth = MediaQuery.of(context).size.width * 0.92;
            imageHeight = MediaQuery.of(context).size.height * 0.55;
          }

          return SizedBox(
            height: sizedBoxHeight,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Wrap(
                    children: [
                      Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Stack(children: [
                            Image.network(list![index].strDrinkThumb!,
                                width: imageWidth,
                                height: imageHeight,
                                fit: BoxFit.cover, loadingBuilder:
                                    (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return SizedBox(
                                width: imageWidth,
                                height: imageHeight,
                                child: Center(
                                    child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null)),
                              );
                            }),
                            Positioned(
                                left: 8,
                                right: 8,
                                top: imageHeight * 0.90,
                                bottom: 8,
                                child: Wrap(
                                  children: [
                                    Container(
                                      decoration: ShapeDecoration(
                                          color: Colors.grey.withAlpha(200),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(list[index].strDrink!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ))
                          ]))
                    ],
                  );
                },
                itemCount: list?.take(3).length),
          );
        },
      ),
    ],
  );
}
