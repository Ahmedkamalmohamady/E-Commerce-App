import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/services/home_services.dart';

import '../../models/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);
   HomeModel homeData=HomeModel();
   CategoryModel?categories;
void getData()
async {
  emit(GetHomeDataLoading());
  getCategories();
  homeData=await HomeServices.getHomeData();
  if(homeData.status!)
  {
    print(homeData.data!.products!.length);
    emit(GetHomeDataSuccess(data: homeData));
  }
  else
  {
    emit(GetHomeDataFailed(data: homeData));
  }
}
void getCategories()
async {
  emit(GetHomeDataLoading());
  categories=await HomeServices.getCategories();
  if(categories!.status!)
  {
    print(categories!.data!.data!.length!);
    emit(GetHomeCategoriesSuccess(data: categories!));
  }
  else
  {
    emit(GetHomeCategoriesFailed(data: categories!));

  }
}

}
