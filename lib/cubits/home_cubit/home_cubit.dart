import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/services/home_services.dart';

import '../../models/category_model.dart';
import '../../services/favourites_services.dart';
import '../../widgets/custom_widgets.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  HomeModel homeData = HomeModel();
  CategoryModel?categories;
  List<Product>?products;
  FavouritesModel? favProducts;
  Map<int, bool>favourites = {};

  void getData() async {
    emit(GetHomeDataLoading());
    getCategories();
    homeData = await HomeServices.getHomeData();
    if (homeData.status!) {
      for (var element in homeData.data!.products!) {
        favourites.addAll({
          element.id!: element.inFavorites!
        });
      }
      print(homeData.data!.products!.length);
      print(favourites);
      emit(GetHomeDataSuccess(data: homeData));
    }
    else {
      emit(GetHomeDataFailed(data: homeData));
    }
  }

  void getCategories() async {
    emit(GetHomeCategoriesLoading());
    categories = await HomeServices.getCategories();
    if (categories!.status!) {
      print(categories!.data!.data!.length);
      emit(GetHomeCategoriesSuccess(data: categories!));
    }
    else {
      emit(GetHomeCategoriesFailed(data: categories!));
    }
  }

  Future<void> getProductsForCategory(id) async {
    emit(GetProductsForCategoryLoading());
    products = await HomeServices.getProductsForCategory(id);
    if (products != null) {
      print(products!.length);
      emit(GetProductsForCategorySuccess(products: products!));
    }
    else {
      emit(GetProductsForCategoryFailed(errorMessage: 'error'));
    }
  }


  Future<void> getFavouritesProducts() async {
    emit(GetFavouritesLoading());

    favProducts = await HomeServices.getFavProducts();
    if (FavProductData != null) {
      print(favProducts!.status);
      print(favProducts!.status);

      emit(GetFavouritesSuccess());
    }
    else {
      emit(GetFavouritesFailed());
    }
  }

  void changeFavourite(id) async {
    favourites[id]=!favourites[id]!;
    emit(ChangeFavouriteItem());
    FavouritesModel response = await FavouritesServices.favouriteAction(id);
    if (response.status!) {
      await getFavouritesProducts();
      emit(ChangeFavouriteItemSuccess(msg: response.message!));

    }
    else {
      favourites[id]=!favourites[id]!;
      emit(ChangeFavouriteItemFailed(msg: response.message!));
    }

  }

}
