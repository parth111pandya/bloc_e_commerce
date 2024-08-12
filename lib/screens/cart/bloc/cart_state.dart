part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<HomeProductModel> cartList;
  CartLoadedState({
    required this.cartList,
  });
}

class cartErrorState extends CartState {}
