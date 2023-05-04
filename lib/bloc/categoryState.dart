
import '../data.dart';
import 'package:equatable/equatable.dart';


 class CategoryState{
   final bool value;

   CategoryState({this.value=false});
 }

class CategoryLoadingState extends CategoryState{

}

class CategoryLoadedState extends CategoryState {
  final bool isLoaded;
   final List<CategoryWiseDrinks> categoryWiseDrink;
   CategoryLoadedState(this.categoryWiseDrink,this.isLoaded):super(value: true);

  @override
  List<Object?> get props => [categoryWiseDrink];
}

class CategoryErrorState extends CategoryState with EquatableMixin{
  final String error;
  CategoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}