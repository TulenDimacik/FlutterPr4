import 'package:bloc/bloc.dart';
import 'package:blok/cubit/theme_state.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';




class ThemeCubit extends Cubit<ThemeState>{
  ThemeCubit(): super(ThemeState(theme: ThemeData.light()));

  void changeTheme(){
    if(state.theme == ThemeData.light()){
      final stateUpdate = ThemeState(theme: ThemeData.dark());
      emit(ThemeState(theme: stateUpdate.theme));
    }
    else{
       final stateUpdate = ThemeState(theme: ThemeData.light());
      emit(ThemeState(theme: stateUpdate.theme));
    }
  }
}