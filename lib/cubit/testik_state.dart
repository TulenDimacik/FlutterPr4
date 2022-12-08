part of 'testik_cubit.dart';

@immutable
abstract class TestikState {}

class TestikInitial extends TestikState {}

class TestError extends TestikState{

  final String error;

  TestError(this.error);
}

class TestClick extends TestikState{
  final int count ;

  TestClick(this.count);
}

class TestColor extends TestikState{
  final Colors _color ;

  TestColor(this._color);
}