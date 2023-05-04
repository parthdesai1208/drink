

import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable{}

class CategoryLoadEvent extends CategoryEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
}