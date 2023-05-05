
import '../data.dart';
import 'package:equatable/equatable.dart';


abstract class CategoryState{}

class CategoryLoadingState extends CategoryState{}

class CategoryLoadedState extends CategoryState with EquatableMixin {
   final List<CategoryWiseDrinks> categoryWiseDrink;
   CategoryLoadedState(this.categoryWiseDrink);

  @override
  List<Object?> get props => [categoryWiseDrink];
}

class CategoryErrorState extends CategoryState with EquatableMixin{
  final String error;
  CategoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}