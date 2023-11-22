import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/screens/home_screen.dart';

import '../../screens/categories_screen.dart';
import '../../screens/favourite_screen.dart';
import '../../screens/shop_app_screen.dart';
import '../../screens/settings_screen.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  static  NavBarCubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  void changeIndex(int index)
  {
    currentIndex =index;
    emit(NavBarIndexChanged());

  }

}
