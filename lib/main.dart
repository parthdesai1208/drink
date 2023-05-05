import 'package:drink/bloc/CategoryEvent.dart';
import 'package:drink/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CategoryRepository.dart';
import 'bloc/categoryBloc.dart';
import 'bloc/categoryState.dart';
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

class _HomeScreenBodyState extends State<HomeScreenBody> {

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider<CategoryBloc>(
        create: (BuildContext context) => CategoryBloc(CategoryRepository()),
      ),
    ], child: Scaffold(body: BlocProvider(
        create: (context) => CategoryBloc(CategoryRepository())..add(CategoryLoadEvent()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoryLoadedState) {
                return ListView(
                    children:
                    firstCardListWrapper(state.categoryWiseDrink, context)
                        .insertBetweenAll(const SizedBox(height: 20)));
              } else if (state is CategoryErrorState) {
                return Center(child: Text(state.error));
              } else {
                return Container();
              }
            }))));
  }
}

List<Widget> firstCardListWrapper(
    List<CategoryWiseDrinks> data, BuildContext context) {
  List<Widget> child = <Widget>[];
  for (var element in data) {
    child.add(firstCardList(element, context));
  }
  return child;
}

Widget firstCardList(
    CategoryWiseDrinks categoryWiseDrinks, BuildContext context) {
  var list = categoryWiseDrinks.drinks;

  return SizedBox(
    height: MediaQuery.of(context).size.width + 18,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              Card(
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
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)))
                  ]))
            ],
          );
        },
        itemCount: list?.take(3).length),
  );
}
