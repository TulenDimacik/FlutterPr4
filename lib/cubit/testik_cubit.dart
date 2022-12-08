import 'package:bloc/bloc.dart';
import 'package:blok/cubit/theme_state.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'testik_state.dart';

class TestikCubit extends Cubit<TestikState> {
  TestikCubit() : super(TestikInitial());

  int count = 0;
  void increment() {
    count++;
    emit(TestClick(count));

    if (count == 10) {
      
      emit(TestError('счетчик равен 10'));
       emit(TestClick(count));
    }
    
  }

  void decriment() {
    count--;
    emit(TestClick(count));
    if (count == -10) {
      emit(TestError('счетчик равен -10'));
      emit(TestClick(count));
    }
  }

  void doubleIncDec(int act){
    if(act==0)
    {
      decriment();
      decriment();
    }
    else if(act==1){
      increment();
      increment();
    }
    
  }

}
