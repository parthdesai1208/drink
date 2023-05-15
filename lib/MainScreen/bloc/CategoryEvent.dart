import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable{}

class CategoryLoadEvent extends CategoryEvent{
  @override
  List<Object?> get props => [];
}

class OnPageChangedEvent extends CategoryEvent{

  final int index;

  OnPageChangedEvent(this.index);

  @override
  List<Object?> get props => [];
}