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

