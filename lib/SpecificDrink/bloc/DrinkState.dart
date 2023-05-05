

import 'package:equatable/equatable.dart';

import '../../DrinkData.dart';

abstract class DrinkState{}

class DrinkLoadingState extends DrinkState{}

class DrinkLoadedState extends DrinkState with EquatableMixin {
  final DrinkClass drinkClass;
  DrinkLoadedState(this.drinkClass);

  @override
  List<Object?> get props => [drinkClass];
}

class DrinkErrorState extends DrinkState with EquatableMixin{
  final String error;
  DrinkErrorState(this.error);

  @override
  List<Object?> get props => [error];
}