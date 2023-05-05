

import 'package:equatable/equatable.dart';

abstract class DrinkEvent extends Equatable{}

class DrinkLoadEvent extends DrinkEvent{
  @override
  List<Object?> get props => [];
}