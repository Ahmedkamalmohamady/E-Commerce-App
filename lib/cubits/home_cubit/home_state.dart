part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetHomeDataLoading extends HomeState {}
class GetHomeDataSuccess extends HomeState {
  final HomeModel data;

  GetHomeDataSuccess({required this.data});
}
class GetHomeDataFailed extends HomeState {
  final HomeModel data;

  GetHomeDataFailed({required this.data});
}
class GetHomeCategoriesFailed extends HomeState {
  final CategoryModel data;

  GetHomeCategoriesFailed({required this.data});
}
class GetHomeCategoriesLoading extends HomeState {
}
class GetHomeCategoriesSuccess extends HomeState {
  final CategoryModel data;

  GetHomeCategoriesSuccess({required this.data});
}

class GetProductsForCategoryFailed extends HomeState {
  final String errorMessage;

  GetProductsForCategoryFailed({required this.errorMessage});
}
class GetProductsForCategoryLoading extends HomeState {}
class GetProductsForCategorySuccess extends HomeState {
  final List<Product> products;

  GetProductsForCategorySuccess({required this.products});
}
class GetFavouritesLoading extends HomeState {}
class GetFavouritesSuccess extends HomeState {}
class GetFavouritesFailed extends HomeState {}
class ChangeFavouriteItemSuccess extends HomeState
{
  final String msg;

  ChangeFavouriteItemSuccess({required this.msg});
}
class ChangeFavouriteItemFailed extends HomeState
{
  final String msg;

  ChangeFavouriteItemFailed({required this.msg});
}
class ChangeFavouriteItem extends HomeState {}