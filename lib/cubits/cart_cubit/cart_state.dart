part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class AddingToCartLoading extends CartState {}
class AddingToCartSuccess extends CartState {
  final String message;

  AddingToCartSuccess({required this.message});

}
class AddingToCartFailed extends CartState {
  final String message;

  AddingToCartFailed({required this.message});

}

class GetCartLoading extends CartState {}
class GetCartSuccess extends CartState {}
class GetCartFailed extends CartState {}
class UpdatedSuccessfully extends CartState {}

